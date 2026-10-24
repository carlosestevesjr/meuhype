<?php

use App\Tags;
use GuzzleHttp\Client;
use Illuminate\Contracts\Console\Kernel;

require dirname(__DIR__) . '/vendor/autoload.php';

$app = require dirname(__DIR__) . '/bootstrap/app.php';
$app->make(Kernel::class)->bootstrap();

$client = new Client([
    'connect_timeout' => 10,
    'timeout' => 40,
    'headers' => [
        'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 Chrome/141 Safari/537.36',
        'Content-Type' => 'application/json',
        'Origin' => 'https://www.imdb.com',
        'Referer' => 'https://www.imdb.com/',
        'x-imdb-client-name' => 'imdb-web-next-localized',
        'x-imdb-user-country' => 'BR',
        'x-imdb-user-language' => 'pt-BR',
    ],
]);

$tags = Tags::query()->whereNotNull('imdb_url')->orderBy('id')->get();
$updated = 0;
$errors = [];

foreach ($tags->chunk(20) as $chunk) {
    $fields = [];
    $tagByAlias = [];

    foreach ($chunk as $tag) {
        if (!preg_match('/\b(tt\d{7,9})\b/i', $tag->imdb_url, $match)) {
            $errors[] = '#' . $tag->id . ' ' . $tag->title . ': IMDb ID invalido';
            continue;
        }

        $alias = 'tag' . $tag->id;
        $imdbId = strtolower($match[1]);
        $fields[] = $alias . ': title(id: "' . $imdbId . '") {'
            . ' id ratingsSummary { aggregateRating voteCount } meterRank { currentRank } }';
        $tagByAlias[$alias] = $tag;
    }

    if (!$fields) {
        continue;
    }

    try {
        $response = $client->post('https://api.graphql.imdb.com/', [
            'json' => ['query' => 'query { ' . implode(' ', $fields) . ' }'],
        ]);
        $payload = json_decode((string) $response->getBody(), true);

        foreach ($tagByAlias as $alias => $tag) {
            $data = $payload['data'][$alias] ?? null;
            if (!$data) {
                $errors[] = '#' . $tag->id . ' ' . $tag->title . ': sem dados no IMDb';
                continue;
            }

            $tag->imdb_rating = $data['ratingsSummary']['aggregateRating'] ?? null;
            $tag->imdb_vote_count = $data['ratingsSummary']['voteCount'] ?? null;
            $tag->imdb_popularity = $data['meterRank']['currentRank'] ?? null;
            $tag->imdb_metrics_updated_at = now();
            $tag->save();
            $updated++;
        }
    } catch (Throwable $exception) {
        $errors[] = 'Lote iniciado na tag #' . $chunk->first()->id . ': ' . $exception->getMessage();
    }

    usleep(200000);
}

echo 'Tags atualizadas: ' . $updated . PHP_EOL;
echo 'Erros: ' . count($errors) . PHP_EOL;
if ($errors) {
    echo implode(PHP_EOL, $errors) . PHP_EOL;
    exit(1);
}
