<?php

use App\Tags;
use App\Services\TagImageOptimizer;
use Illuminate\Contracts\Console\Kernel;
use Illuminate\Support\Str;

require dirname(__DIR__) . '/vendor/autoload.php';

$app = require dirname(__DIR__) . '/bootstrap/app.php';
$app->make(Kernel::class)->bootstrap();
$imageOptimizer = $app->make(TagImageOptimizer::class);

const MAX_REMOTE_IMAGE_BYTES = 8388608;

$titles = [
    4 => ['The Bad Batch', 'tt12708542'],
    8 => ['The Falcon and the Winter Soldier', 'tt9208876'],
    9 => ['Cobra Kai', 'tt7221388'],
    10 => ['Mortal Kombat', 'tt0293429'],
    11 => ['Doctor Strange in the Multiverse of Madness', 'tt9419884'],
    12 => ['WandaVision', 'tt9140560'],
    13 => ['Army of the Dead', 'tt0993840'],
    14 => ['Venom Let There Be Carnage', 'tt7097896'],
    15 => ['The Batman', 'tt1877830'],
    16 => ['Thor Love and Thunder', 'tt10648342'],
    17 => ['Michael', 'tt11378946'],
    18 => ['Dune Part Two', 'tt15239678'],
    19 => ['House of the Dragon', 'tt11198330'],
    20 => ['Street Fighter', 'tt27419420'],
];

$destination = public_path('uploads/fotos');
if (!is_dir($destination) && !mkdir($destination, 0755, true) && !is_dir($destination)) {
    throw new RuntimeException('Nao foi possivel criar o diretorio: ' . $destination);
}

function imdbRequest(string $url): array
{
    $curl = curl_init($url);
    curl_setopt_array($curl, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_CONNECTTIMEOUT => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_USERAGENT => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 Chrome/141 Safari/537.36',
        CURLOPT_ENCODING => '',
        CURLOPT_NOPROGRESS => false,
        CURLOPT_XFERINFOFUNCTION => function (
            $curl,
            $downloadTotal,
            $downloadedBytes
        ): int {
            return $downloadedBytes > MAX_REMOTE_IMAGE_BYTES ? 1 : 0;
        },
    ]);

    $body = curl_exec($curl);
    $status = (int) curl_getinfo($curl, CURLINFO_HTTP_CODE);
    $contentType = (string) curl_getinfo($curl, CURLINFO_CONTENT_TYPE);
    $error = curl_error($curl);
    curl_close($curl);

    if ($body === false || $status >= 400 || $status === 0) {
        throw new RuntimeException('HTTP ' . $status . ($error ? ': ' . $error : ''));
    }

    return [$body, $contentType];
}

function imdbPosterUrl(string $title, string $imdbId): array
{
    $query = rawurlencode(Str::slug($title, '_'));
    [$json] = imdbRequest('https://v3.sg.media-imdb.com/suggestion/x/' . $query . '.json');
    $response = json_decode($json, true);

    foreach ($response['d'] ?? [] as $result) {
        if (($result['id'] ?? '') === $imdbId && !empty($result['i']['imageUrl'])) {
            return [
                $result['i']['imageUrl'],
                $result['l'] ?? $title,
                $result['i']['width'] ?? null,
                $result['i']['height'] ?? null,
            ];
        }
    }

    throw new RuntimeException('titulo ' . $imdbId . ' nao encontrado no catalogo IMDb');
}

function posterExtension(string $contentType, string $data): string
{
    $mime = (new finfo(FILEINFO_MIME_TYPE))->buffer($data);
    $extensions = [
        'image/jpeg' => 'jpg',
        'image/png' => 'png',
        'image/webp' => 'webp',
    ];

    if (!isset($extensions[$mime])) {
        throw new RuntimeException('arquivo retornado nao e uma imagem valida: ' . ($mime ?: $contentType));
    }

    return $extensions[$mime];
}

$imported = 0;
$failures = [];

foreach ($titles as $tagId => [$searchTitle, $imdbId]) {
    try {
        $tag = Tags::find($tagId);
        if (!$tag) {
            throw new RuntimeException('tag nao encontrada no banco');
        }

        [$posterUrl, $imdbTitle, $width, $height] = imdbPosterUrl($searchTitle, $imdbId);
        [$image, $contentType] = imdbRequest($posterUrl);
        $extension = posterExtension($contentType, $image);
        $filename = 'tag-' . $tag->id . '-' . Str::slug($tag->title) . '-' . $imdbId . '.' . $extension;
        $filePath = $destination . '/' . $filename;

        if (file_put_contents($filePath, $image) === false) {
            throw new RuntimeException('nao foi possivel salvar o cartaz');
        }

        $metadata = $imageOptimizer->optimize($filePath);
        $filePath = $metadata['path'];
        $filename = basename($filePath);

        $tag->image = '/uploads/fotos/' . $filename;
        $tag->image_width = $metadata['width'];
        $tag->image_height = $metadata['height'];
        $tag->image_size_bytes = $metadata['after_bytes'];
        $tag->image_optimized_at = now();
        $tag->save();
        $imported++;

        echo '[OK] #' . $tag->id . ' ' . $tag->title . ' -> ' . $imdbTitle
            . ' (' . $imdbId . ', ' . $metadata['width'] . 'x' . $metadata['height']
            . ', ' . round($metadata['after_bytes'] / 1024, 1) . ' KB)' . PHP_EOL;
    } catch (Throwable $exception) {
        $message = '#' . $tagId . ' ' . $searchTitle . ': ' . $exception->getMessage();
        $failures[] = $message;
        echo '[ERRO] ' . $message . PHP_EOL;
    }
}

echo PHP_EOL . 'Importados: ' . $imported . '/' . count($titles) . PHP_EOL;
if ($failures) {
    echo implode(PHP_EOL, $failures) . PHP_EOL;
    exit(1);
}
