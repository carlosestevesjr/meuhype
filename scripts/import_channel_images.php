<?php

use App\Channels;
use Illuminate\Contracts\Console\Kernel;
use Illuminate\Support\Str;

require dirname(__DIR__) . '/vendor/autoload.php';

$app = require dirname(__DIR__) . '/bootstrap/app.php';
$app->make(Kernel::class)->bootstrap();

$destination = public_path('uploads/channels');

if (!is_dir($destination) && !mkdir($destination, 0755, true) && !is_dir($destination)) {
    throw new RuntimeException('Nao foi possivel criar o diretorio: ' . $destination);
}

function requestUrl(string $url): array
{
    $curl = curl_init($url);
    curl_setopt_array($curl, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_CONNECTTIMEOUT => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_USERAGENT => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 Chrome/141 Safari/537.36',
        CURLOPT_ENCODING => '',
        CURLOPT_HTTPHEADER => ['Accept-Language: pt-BR,pt;q=0.9,en;q=0.8'],
    ]);

    $body = curl_exec($curl);
    $status = (int) curl_getinfo($curl, CURLINFO_HTTP_CODE);
    $contentType = (string) curl_getinfo($curl, CURLINFO_CONTENT_TYPE);
    $finalUrl = (string) curl_getinfo($curl, CURLINFO_EFFECTIVE_URL);
    $error = curl_error($curl);
    curl_close($curl);

    if ($body === false || $status >= 400 || $status === 0) {
        throw new RuntimeException('HTTP ' . $status . ($error ? ': ' . $error : ''));
    }

    return [$body, $contentType, $finalUrl];
}

function absoluteUrl(string $url, string $baseUrl): string
{
    $url = html_entity_decode(trim($url), ENT_QUOTES | ENT_HTML5, 'UTF-8');

    if (preg_match('~^https?://~i', $url)) {
        return $url;
    }

    $base = parse_url($baseUrl);
    if (!$base || empty($base['host'])) {
        return '';
    }

    $scheme = $base['scheme'] ?? 'https';
    if (strpos($url, '//') === 0) {
        return $scheme . ':' . $url;
    }

    return $scheme . '://' . $base['host'] . '/' . ltrim($url, '/');
}

function imageUrlFromHtml(string $html, string $pageUrl): string
{
    $crawler = new Symfony\Component\DomCrawler\Crawler($html, $pageUrl);
    $selectors = [
        'meta[property="og:image"]' => 'content',
        'meta[name="twitter:image"]' => 'content',
        'meta[property="twitter:image"]' => 'content',
        'link[rel="apple-touch-icon"]' => 'href',
        'link[rel="icon"]' => 'href',
    ];

    foreach ($selectors as $selector => $attribute) {
        $node = $crawler->filter($selector)->first();
        if ($node->count()) {
            $url = absoluteUrl((string) $node->attr($attribute), $pageUrl);
            if ($url !== '') {
                return $url;
            }
        }
    }

    return '';
}

function extensionForImage(string $contentType, string $data): string
{
    $mime = strtolower(trim(explode(';', $contentType)[0]));
    $detected = (new finfo(FILEINFO_MIME_TYPE))->buffer($data);
    $mime = strpos($detected, 'image/') === 0 ? $detected : $mime;

    $extensions = [
        'image/jpeg' => 'jpg',
        'image/png' => 'png',
        'image/webp' => 'webp',
        'image/gif' => 'gif',
    ];

    if (!isset($extensions[$mime])) {
        throw new RuntimeException('Formato de imagem invalido: ' . ($mime ?: 'desconhecido'));
    }

    return $extensions[$mime];
}

$channels = Channels::where('status', 'active')->orderBy('id')->get();
$brandImages = [];
$failures = [];

foreach ($channels as $channel) {
    $brand = Str::slug(preg_replace('/(?:\s+-\s+|\s+)(site|youtube|podcast)$/i', '', $channel->name));

    try {
        if (isset($brandImages[$brand])) {
            [$sourceFile, $extension] = $brandImages[$brand];
            $filename = 'channel-' . $channel->id . '-' . Str::slug($channel->name) . '.' . $extension;
            copy($sourceFile, $destination . '/' . $filename);
        } else {
            $pageUrl = trim((string) $channel->link);
            if ($pageUrl === '') {
                throw new RuntimeException('canal sem link cadastrado');
            }

            [$html, , $finalUrl] = requestUrl($pageUrl);
            $imageUrl = imageUrlFromHtml($html, $finalUrl ?: $pageUrl);
            if ($imageUrl === '') {
                throw new RuntimeException('pagina sem og:image, twitter:image ou icone');
            }

            [$imageData, $contentType] = requestUrl($imageUrl);
            $extension = extensionForImage($contentType, $imageData);
            $filename = 'channel-' . $channel->id . '-' . Str::slug($channel->name) . '.' . $extension;

            if (file_put_contents($destination . '/' . $filename, $imageData) === false) {
                throw new RuntimeException('falha ao salvar a imagem');
            }

            $brandImages[$brand] = [$destination . '/' . $filename, $extension];
        }

        $channel->image = '/uploads/channels/' . $filename;
        $channel->save();
        echo '[OK] #' . $channel->id . ' ' . $channel->name . ' -> ' . $channel->image . PHP_EOL;
    } catch (Throwable $exception) {
        $failures[] = '#' . $channel->id . ' ' . $channel->name . ': ' . $exception->getMessage();
        echo '[ERRO] ' . end($failures) . PHP_EOL;
    }
}

echo PHP_EOL . 'Importados: ' . ($channels->count() - count($failures)) . '/' . $channels->count() . PHP_EOL;
if ($failures) {
    echo implode(PHP_EOL, $failures) . PHP_EOL;
    exit(1);
}
