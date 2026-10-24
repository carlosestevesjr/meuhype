<?php

use App\Tags;
use Illuminate\Contracts\Console\Kernel;

require dirname(__DIR__) . '/vendor/autoload.php';

$app = require dirname(__DIR__) . '/bootstrap/app.php';
$app->make(Kernel::class)->bootstrap();

$updated = 0;
$missing = [];

foreach (Tags::query()->orderBy('id')->get() as $tag) {
    if ($tag->imdb_url) {
        continue;
    }

    $source = implode(' ', [(string) $tag->keywords, (string) $tag->image, (string) $tag->description]);
    if (!preg_match('/\b(tt\d{7,9})\b/i', $source, $match)) {
        $missing[] = '#' . $tag->id . ' ' . $tag->title;
        continue;
    }

    $tag->imdb_url = 'https://www.imdb.com/pt/title/' . strtolower($match[1]) . '/';
    $tag->save();
    $updated++;
}

echo 'Links preenchidos: ' . $updated . PHP_EOL;
echo 'Sem IMDb ID: ' . count($missing) . PHP_EOL;
if ($missing) {
    echo implode(PHP_EOL, $missing) . PHP_EOL;
}
