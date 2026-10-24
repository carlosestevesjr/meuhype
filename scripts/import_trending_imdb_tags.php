<?php

use App\Tags;
use Illuminate\Contracts\Console\Kernel;
use Illuminate\Support\Str;

require dirname(__DIR__) . '/vendor/autoload.php';

$app = require dirname(__DIR__) . '/bootstrap/app.php';
$app->make(Kernel::class)->bootstrap();

// Titulos selecionados nos rankings de popularidade e calendario do IMDb.
$titles = [
    ['The Odyssey', 'A Odisseia', 2026, 'movie', 'Filme'],
    ['Spider-Man: Brand New Day', 'Homem-Aranha: Um Novo Dia', 2026, 'movie', 'Filme'],
    ['Avengers: Doomsday', 'Vingadores: Doutor Destino', 2026, 'movie', 'Filme'],
    ['Scream 7', 'Pânico 7', 2026, 'movie', 'Filme'],
    ['Jumanji: Open World', 'Jumanji: Mundo Real', 2026, 'movie', 'Filme'],
    ['Clayface', 'Cara de Barro', 2026, 'movie', 'Filme'],
    ['Wildwood', 'Floresta Selvagem', 2026, 'movie', 'Filme'],
    ['Klara and the Sun', 'Klara e o Sol', 2026, 'movie', 'Filme'],
    ['The Further Mis-Adventures of Cliff Booth', 'As Novas Aventuras de Cliff Booth', 2026, 'movie', 'Filme'],
    ['Focker-in-Law', 'Entrando Numa Fria 4', 2026, 'movie', 'Filme'],
    ['Hexed', 'Enfeitiçados', 2026, 'movie', 'Filme'],
    ['Violent Night 2', 'Noite Violenta 2', 2026, 'movie', 'Filme'],
    ['The Gallerist', 'A Galerista', 2026, 'movie', 'Filme'],
    ['Sense and Sensibility', 'Razão e Sensibilidade', 2026, 'movie', 'Filme'],
    ['Project Hail Mary', 'Projeto Hail Mary', 2026, 'movie', 'Filme'],
    ['Carrie', 'Carrie', 2026, 'series', 'Serie'],
    ['Below', 'Nas Profundezas', 2026, 'series', 'Serie'],
    ['East of Eden', 'A Leste do Éden', 2026, 'series', 'Serie'],
    ['Lanterns', 'Lanternas', 2026, 'series', 'Serie'],
    ['VisionQuest', 'VisionQuest', 2026, 'series', 'Serie'],
    ['Crystal Lake', 'Lago de Cristal', 2026, 'series', 'Serie'],
    ["Widow's Bay", 'Baía da Viúva', 2026, 'series', 'Serie'],
    ['Silo', 'Silo', 2023, 'series', 'Serie'],
    ['The Gentlemen', 'Magnatas do Crime', 2024, 'series', 'Serie'],
    ['Reacher', 'Reacher', 2022, 'series', 'Serie'],
    ['Ted Lasso', 'Ted Lasso', 2020, 'series', 'Serie'],
    ['Slow Horses', 'Cavalos Lentos', 2022, 'series', 'Serie'],
    ['MobLand', 'Terra da Máfia', 2025, 'series', 'Serie'],
    ['Dark Matter', 'Matéria Escura', 2024, 'series', 'Serie'],
    ['The Shards', 'Os Fragmentos', 2026, 'series', 'Serie'],
];

function imdbGet(string $url): array
{
    $curl = curl_init($url);
    curl_setopt_array($curl, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_CONNECTTIMEOUT => 10,
        CURLOPT_TIMEOUT => 35,
        CURLOPT_USERAGENT => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 Chrome/141 Safari/537.36',
        CURLOPT_ENCODING => '',
    ]);

    $body = curl_exec($curl);
    $status = (int) curl_getinfo($curl, CURLINFO_HTTP_CODE);
    $contentType = (string) curl_getinfo($curl, CURLINFO_CONTENT_TYPE);
    $error = curl_error($curl);
    curl_close($curl);

    if ($body === false || $status < 200 || $status >= 300) {
        throw new RuntimeException('IMDb respondeu HTTP ' . $status . ($error ? ': ' . $error : ''));
    }

    return [$body, $contentType];
}

function normalizedTitle(string $title): string
{
    return Str::slug($title);
}

function imdbTitle(string $query, int $year, string $expectedType): array
{
    [$body] = imdbGet('https://v3.sg.media-imdb.com/suggestion/x/' . rawurlencode(Str::slug($query, '_')) . '.json');
    $results = json_decode($body, true)['d'] ?? [];
    $expectedSlug = normalizedTitle($query);

    foreach ($results as $result) {
        $type = (string) ($result['qid'] ?? '');
        $isExpectedType = $expectedType === 'movie'
            ? $type === 'movie'
            : in_array($type, ['tvSeries', 'tvMiniSeries'], true);

        if (normalizedTitle((string) ($result['l'] ?? '')) === $expectedSlug
            && (int) ($result['y'] ?? 0) === $year
            && $isExpectedType
            && !empty($result['i']['imageUrl'])) {
            return $result;
        }
    }

    throw new RuntimeException('resultado exato nao encontrado no IMDb');
}

function imageExtension(string $data, string $contentType): string
{
    $mime = (new finfo(FILEINFO_MIME_TYPE))->buffer($data) ?: $contentType;
    $extensions = ['image/jpeg' => 'jpg', 'image/png' => 'png', 'image/webp' => 'webp'];

    if (!isset($extensions[$mime])) {
        throw new RuntimeException('o cartaz retornado nao e uma imagem valida (' . $mime . ')');
    }

    return $extensions[$mime];
}

$destination = public_path('uploads/fotos');
if (!is_dir($destination) && !mkdir($destination, 0755, true) && !is_dir($destination)) {
    throw new RuntimeException('Nao foi possivel criar ' . $destination);
}

$existingSlugs = Tags::all()->flatMap(function (Tags $tag) {
    return [normalizedTitle($tag->title), normalizedTitle($tag->slug)];
})->filter()->unique()->values()->all();

$nextOrder = (int) Tags::max('order');
$created = 0;
$skipped = 0;
$errors = [];

foreach ($titles as [$searchTitle, $localizedTitle, $year, $expectedType, $category]) {
    $originalSlug = normalizedTitle($searchTitle);
    $localizedSlug = normalizedTitle($localizedTitle);
    $existing = Tags::whereIn('slug', [$originalSlug, $localizedSlug])->first();

    if ($existing && $existing->slug === $localizedSlug) {
        echo '[IGNORADO] ' . $localizedTitle . ' ja existe em portugues.' . PHP_EOL;
        $skipped++;
        continue;
    }

    try {
        $result = imdbTitle($searchTitle, $year, $expectedType);
        [$image, $contentType] = imdbGet($result['i']['imageUrl']);
        $extension = imageExtension($image, $contentType);
        $imdbId = $result['id'];
        $originalTitle = trim($result['l']);
        $title = $localizedTitle;
        $cast = trim((string) ($result['s'] ?? ''));
        $filename = 'tag-' . $localizedSlug . '-' . $imdbId . '.' . $extension;

        if (file_put_contents($destination . '/' . $filename, $image) === false) {
            throw new RuntimeException('nao foi possivel salvar o cartaz');
        }

        $kind = $category === 'Filme' ? 'filme' : 'serie';
        $short = $title . ' e uma ' . ($kind === 'filme' ? 'producao cinematografica' : 'producao para televisao')
            . ' de ' . $year . ' em evidencia no IMDb.';
        $description = '<p><strong>' . e($title) . '</strong> (' . $year . ') - ' . e($category) . '.</p>';
        if ($cast !== '') {
            $description .= '<p>Elenco principal informado pelo IMDb: ' . e($cast) . '.</p>';
        }
        $description .= '<p>Referencia: <a href="https://www.imdb.com/title/' . $imdbId . '/" target="_blank" rel="noopener">IMDb ' . $imdbId . '</a>.</p>';

        $tag = $existing ?: new Tags();
        $tag->title = $title;
        $tag->slug = normalizedTitle($title);
        $tag->description_short = Str::limit($short, 255, '');
        $tag->description = $description;
        $tag->keywords = implode(', ', array_unique([$title, $originalTitle, $searchTitle, $imdbId]));
        $tag->imdb_url = 'https://www.imdb.com/pt/title/' . $imdbId . '/';
        $tag->match_percentage = 60;
        $tag->categoria = $category;
        $tag->order = $existing ? $existing->order : ++$nextOrder;
        $tag->status = 'active';
        $tag->image = '/uploads/fotos/' . $filename;
        $tag->save();

        $existingSlugs[] = $tag->slug;
        if ($existing) {
            echo '[ATUALIZADO] #' . $tag->id . ' ' . $originalTitle . ' -> ' . $title . PHP_EOL;
        } else {
            $created++;
            echo '[OK] #' . $tag->id . ' ' . $title . ' (' . $imdbId . ', ' . $category . ')' . PHP_EOL;
        }
    } catch (Throwable $exception) {
        $errors[] = $searchTitle . ': ' . $exception->getMessage();
        echo '[ERRO] ' . end($errors) . PHP_EOL;
    }

    usleep(180000);
}

echo PHP_EOL . 'Criadas: ' . $created . ' | Ignoradas: ' . $skipped . ' | Erros: ' . count($errors) . PHP_EOL;
exit($errors ? 1 : 0);
