<?php

use App\News;
use App\NewsTags;
use App\Tags;
use Illuminate\Contracts\Console\Kernel;
use Illuminate\Support\Facades\DB;

require dirname(__DIR__) . '/vendor/autoload.php';

$app = require dirname(__DIR__) . '/bootstrap/app.php';
$app->make(Kernel::class)->bootstrap();

$apply = in_array('--apply', $argv, true);
$news = News::query()->select(['id', 'title'])->orderBy('id')->get();
$tags = Tags::query()->where('status', 'active')->select(['id', 'title', 'keywords', 'match_percentage'])->orderBy('id')->get();
$existingRows = NewsTags::query()->select(['id', 'news_id', 'tags_id'])->orderBy('id')->get();
$existing = [];

foreach ($existingRows as $row) {
    $existing[$row->news_id . ':' . $row->tags_id][] = $row->id;
}

function normalizeWords(string $text): array
{
    $converted = iconv('UTF-8', 'ASCII//TRANSLIT//IGNORE', mb_strtolower($text, 'UTF-8')) ?: $text;
    $words = array_values(array_filter(preg_split('/[^a-z0-9]+/i', strtolower($converted))));
    $stopwords = [
        'o', 'a', 'e', 'os', 'as', 'um', 'uma', 'uns', 'umas', 'de', 'da', 'do', 'das', 'dos',
        'em', 'no', 'na', 'nos', 'nas', 'para', 'por', 'com', 'sem', 'the', 'a', 'an', 'of',
        'in', 'on', 'at', 'to', 'for', 'and', 'or', 'with', 'without',
    ];
    $aliases = ['dr' => 'doutor', 'dra' => 'doutora'];

    return array_values(array_map(
        fn (string $word) => $aliases[$word] ?? $word,
        array_filter($words, fn (string $word) => !in_array($word, $stopwords, true))
    ));
}

function titleAliases(Tags $tag): array
{
    $aliases = [$tag->title];

    foreach (array_map('trim', explode(',', (string) $tag->keywords)) as $keyword) {
        if ($keyword === '' || preg_match('/^tt\d+$/i', $keyword)) {
            break;
        }
        $aliases[] = $keyword;
    }

    return array_values(array_unique($aliases));
}

function wordsMatch(array $tagWords, array $newsWords, int $percentage): bool
{
    if (!$tagWords || !$newsWords) {
        return false;
    }

    $used = [];
    $total = 0.0;

    foreach ($tagWords as $tagWord) {
        $bestScore = 0.0;
        $bestIndex = null;

        foreach ($newsWords as $index => $newsWord) {
            if (isset($used[$index])) {
                continue;
            }

            if ($tagWord === $newsWord) {
                $score = 100.0;
            } elseif (strlen($tagWord) >= 5
                && strlen($newsWord) >= 5
                && $tagWord[0] === $newsWord[0]
                && substr($tagWord, -1) === substr($newsWord, -1)) {
                similar_text($tagWord, $newsWord, $score);
            } else {
                $score = 0.0;
            }

            if ($score > $bestScore) {
                $bestScore = $score;
                $bestIndex = $index;
            }
        }

        if ($bestIndex !== null) {
            $used[$bestIndex] = true;
        }
        $total += $bestScore;
    }

    return ($total / count($tagWords)) >= $percentage;
}

function matchesTag(Tags $tag, string $newsTitle): bool
{
    $newsWords = normalizeWords($newsTitle);
    $percentage = max(1, min(100, (int) ($tag->match_percentage ?: 60)));

    foreach (titleAliases($tag) as $alias) {
        $tagWords = normalizeWords($alias);

        // Tags de uma palavra exigem a palavra completa para evitar Venom/vendo e Reacher/revanche.
        if (count($tagWords) === 1) {
            if (in_array($tagWords[0], $newsWords, true)) {
                return true;
            }

            foreach ($newsWords as $newsWord) {
                if (strlen($tagWords[0]) < 5
                    || strlen($newsWord) < 5
                    || $tagWords[0][0] !== $newsWord[0]
                    || substr($tagWords[0], -1) !== substr($newsWord, -1)) {
                    continue;
                }

                similar_text($tagWords[0], $newsWord, $score);
                if ($score >= $percentage) {
                    return true;
                }
            }
            continue;
        }

        if (wordsMatch($tagWords, $newsWords, $percentage)) {
            return true;
        }
    }

    return false;
}

$expected = [];
foreach ($news as $item) {
    foreach ($tags as $tag) {
        $percentage = max(1, min(100, (int) ($tag->match_percentage ?: 60)));
        if (matchesTag($tag, $item->title)) {
            $expected[$item->id . ':' . $tag->id] = [
                'news_id' => $item->id,
                'tags_id' => $tag->id,
                'news_title' => $item->title,
                'tag_title' => $tag->title,
                'percentage' => $percentage,
            ];
        }
    }
}

$removeIds = [];
$invalid = [];
$duplicates = [];
foreach ($existing as $key => $ids) {
    if (!isset($expected[$key])) {
        $removeIds = array_merge($removeIds, $ids);
        $row = $existingRows->firstWhere('id', $ids[0]);
        $item = $news->firstWhere('id', $row->news_id);
        $tag = $tags->firstWhere('id', $row->tags_id);
        $invalid[] = [
            'news_id' => $row->news_id,
            'noticia' => $item->title ?? '(noticia inexistente)',
            'tags_id' => $row->tags_id,
            'tag' => $tag->title ?? '(tag inativa ou inexistente)',
            'percentual_exigido' => $tag->match_percentage ?? 60,
        ];
        continue;
    }

    if (count($ids) > 1) {
        $extraIds = array_slice($ids, 1);
        $removeIds = array_merge($removeIds, $extraIds);
        $duplicates[$key] = $extraIds;
    }
}

$missing = array_values(array_diff_key($expected, $existing));

echo 'Modo: ' . ($apply ? 'APLICAR ALTERACOES' : 'SOMENTE AUDITORIA') . PHP_EOL;
echo 'Noticias analisadas: ' . count($news) . PHP_EOL;
echo 'Tags ativas analisadas: ' . count($tags) . PHP_EOL;
echo 'Relacoes atuais: ' . count($existingRows) . PHP_EOL;
echo 'Relacoes validas esperadas: ' . count($expected) . PHP_EOL;
echo 'Relacoes invalidas: ' . count($invalid) . PHP_EOL;
echo 'Relacoes duplicadas excedentes: ' . array_sum(array_map('count', $duplicates)) . PHP_EOL;
echo 'Relacoes validas ausentes: ' . count($missing) . PHP_EOL;

if ($invalid) {
    echo PHP_EOL . 'Exemplos de relacoes invalidas:' . PHP_EOL;
    foreach (array_slice($invalid, 0, 20) as $row) {
        echo '- Noticia #' . $row['news_id'] . ' [' . $row['noticia'] . '] -> Tag #'
            . $row['tags_id'] . ' [' . $row['tag'] . '] (' . $row['percentual_exigido'] . '%)' . PHP_EOL;
    }
}

if ($missing) {
    echo PHP_EOL . 'Exemplos de relacoes ausentes:' . PHP_EOL;
    foreach (array_slice($missing, 0, 20) as $row) {
        echo '- Noticia #' . $row['news_id'] . ' [' . $row['news_title'] . '] -> Tag #'
            . $row['tags_id'] . ' [' . $row['tag_title'] . '] (' . $row['percentage'] . '%)' . PHP_EOL;
    }
}

if (!$apply) {
    echo PHP_EOL . 'Nenhuma alteracao foi feita. Use --apply para corrigir o banco.' . PHP_EOL;
    exit(0);
}

$backupDirectory = storage_path('app/backups');
if (!is_dir($backupDirectory) && !mkdir($backupDirectory, 0755, true) && !is_dir($backupDirectory)) {
    throw new RuntimeException('Nao foi possivel criar o diretorio de backup.');
}
$backupPath = $backupDirectory . '/news_tags_before_match_' . date('Ymd_His') . '.json';
if (file_put_contents($backupPath, json_encode($existingRows->toArray(), JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE)) === false) {
    throw new RuntimeException('Nao foi possivel salvar o backup de news_tags.');
}

DB::transaction(function () use ($removeIds, $missing) {
    foreach (array_chunk(array_values(array_unique($removeIds)), 500) as $ids) {
        NewsTags::query()->whereIn('id', $ids)->delete();
    }

    $now = date('Y-m-d H:i:s');
    foreach (array_chunk($missing, 500) as $chunk) {
        NewsTags::query()->insert(array_map(function (array $row) use ($now) {
            return [
                'news_id' => $row['news_id'],
                'tags_id' => $row['tags_id'],
                'created_at' => $now,
                'updated_at' => $now,
            ];
        }, $chunk));
    }
});

echo PHP_EOL . 'Banco corrigido com sucesso.' . PHP_EOL;
echo 'Backup: ' . $backupPath . PHP_EOL;
echo 'Removidas: ' . count(array_unique($removeIds)) . PHP_EOL;
echo 'Adicionadas: ' . count($missing) . PHP_EOL;
echo 'Total final esperado: ' . count($expected) . PHP_EOL;
