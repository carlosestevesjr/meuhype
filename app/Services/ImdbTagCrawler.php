<?php

namespace App\Services;

use App\Tags;
use GuzzleHttp\Client;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use RuntimeException;
use Throwable;

class ImdbTagCrawler
{
    private Client $client;

    private CrawlerTagScheduler $scheduler;

    private TagImageOptimizer $imageOptimizer;

    public function __construct(CrawlerTagScheduler $scheduler, TagImageOptimizer $imageOptimizer)
    {
        $this->scheduler = $scheduler;
        $this->imageOptimizer = $imageOptimizer;
        $this->client = new Client([
            'connect_timeout' => 10,
            'timeout' => 35,
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
    }

    public function import(int $limit = 30): array
    {
        $limit = max(1, min(100, $limit));
        $perChart = min(100, max(30, $limit));
        $movies = $this->chart('MOST_POPULAR_MOVIES', $perChart, 'Filme');
        $series = $this->chart('MOST_POPULAR_TV_SHOWS', $perChart, 'Serie');
        $candidates = $this->interleave($movies, $series);
        $result = [
            'adicionados' => [],
            'existentes' => [],
            'agendamentos' => [],
            'erros' => [],
        ];

        foreach ($candidates as $candidate) {
            if (count($result['adicionados']) >= $limit) {
                break;
            }

            try {
                $existing = Tags::where('slug', Str::slug($candidate['title']))
                    ->orWhere('keywords', 'LIKE', '%' . $candidate['imdb_id'] . '%')
                    ->first();

                if ($existing) {
                    $result['existentes'][] = $candidate['title'];
                    continue;
                }

                $tag = null;
                $schedule = DB::transaction(function () use ($candidate, &$tag) {
                    $tag = $this->createTag($candidate);

                    return $this->scheduler->schedule($tag);
                });

                $result['adicionados'][] = $tag->title;
                $result['agendamentos'][] = $schedule;
                usleep(150000);
            } catch (Throwable $exception) {
                if (isset($tag) && $tag->image) {
                    @unlink(public_path($tag->image));
                }
                $result['erros'][] = $candidate['title'] . ': ' . $exception->getMessage();
            }
        }

        return $result;
    }

    private function chart(string $chartType, int $limit, string $category): array
    {
        $query = <<<'GRAPHQL'
query ($first: Int!) {
  chartTitles(first: $first, chart: {chartType: CHART_TYPE}) {
    edges {
      currentRank
      node {
        id
        titleText { text }
        originalTitleText { text }
        releaseYear { year }
        titleType { id text }
        primaryImage { url width height }
        plot { plotText { plainText } }
        genres { genres { text } }
        ratingsSummary { aggregateRating voteCount }
        meterRank { currentRank }
        credits(first: 4) { edges { node { name { nameText { text } } } } }
      }
    }
  }
}
GRAPHQL;

        $response = $this->client->post('https://api.graphql.imdb.com/', [
            'json' => [
                'query' => str_replace('CHART_TYPE', $chartType, $query),
                'variables' => ['first' => $limit],
            ],
        ]);
        $payload = json_decode((string) $response->getBody(), true);

        if (!empty($payload['errors'])) {
            throw new RuntimeException($payload['errors'][0]['message'] ?? 'Erro desconhecido no IMDb.');
        }

        return array_values(array_filter(array_map(function (array $edge) use ($category) {
            $node = $edge['node'] ?? [];
            $title = trim((string) ($node['titleText']['text'] ?? ''));
            $image = (string) ($node['primaryImage']['url'] ?? '');

            if ($title === '' || $image === '' || empty($node['id'])) {
                return null;
            }

            return [
                'imdb_id' => $node['id'],
                'title' => $title,
                'original_title' => trim((string) ($node['originalTitleText']['text'] ?? $title)),
                'year' => (int) ($node['releaseYear']['year'] ?? 0),
                'type' => (string) ($node['titleType']['text'] ?? $category),
                'category' => $category,
                'plot' => trim((string) ($node['plot']['plotText']['plainText'] ?? '')),
                'genres' => array_column($node['genres']['genres'] ?? [], 'text'),
                'cast' => array_values(array_filter(array_map(
                    fn (array $credit) => $credit['node']['name']['nameText']['text'] ?? null,
                    $node['credits']['edges'] ?? []
                ))),
                'image_url' => $image,
                'rating' => isset($node['ratingsSummary']['aggregateRating']) ? (float) $node['ratingsSummary']['aggregateRating'] : null,
                'vote_count' => isset($node['ratingsSummary']['voteCount']) ? (int) $node['ratingsSummary']['voteCount'] : null,
                'popularity' => isset($node['meterRank']['currentRank'])
                    ? (int) $node['meterRank']['currentRank']
                    : (isset($edge['currentRank']) ? (int) $edge['currentRank'] : null),
            ];
        }, $payload['data']['chartTitles']['edges'] ?? [])));
    }

    private function interleave(array $movies, array $series): array
    {
        $items = [];
        $size = max(count($movies), count($series));

        for ($index = 0; $index < $size; $index++) {
            if (isset($movies[$index])) {
                $items[] = $movies[$index];
            }
            if (isset($series[$index])) {
                $items[] = $series[$index];
            }
        }

        return $items;
    }

    private function createTag(array $item): Tags
    {
        $directory = public_path('uploads/fotos');

        if (!is_dir($directory) && !mkdir($directory, 0755, true) && !is_dir($directory)) {
            throw new RuntimeException('Nao foi possivel criar o diretorio de imagens.');
        }

        $basename = 'tag-' . Str::slug($item['title']) . '-' . $item['imdb_id'];
        [$filename, $imagePath, $imageMetadata] = $this->downloadImage($item['image_url'], $directory, $basename);

        $short = $item['plot'] ?: $item['title'] . ' (' . $item['year'] . ') em evidencia no IMDb.';
        $description = '<p>' . e($short) . '</p>';
        if ($item['cast']) {
            $description .= '<p><strong>Elenco principal:</strong> ' . e(implode(', ', $item['cast'])) . '.</p>';
        }
        $description .= '<p><a href="https://www.imdb.com/pt/title/' . $item['imdb_id'] . '/" target="_blank" rel="noopener">Ver no IMDb</a></p>';

        $tag = new Tags();
        $tag->title = $item['title'];
        $tag->slug = Str::slug($item['title']);
        $tag->description_short = Str::limit($short, 255, '');
        $tag->description = $description;
        $keywords = array_unique(array_filter(array_merge(
            [$item['title'], $item['original_title'], $item['imdb_id']],
            $item['genres']
        )));
        $tag->keywords = Str::limit(implode(', ', $keywords), 255, '');
        $tag->imdb_url = 'https://www.imdb.com/pt/title/' . $item['imdb_id'] . '/';
        $tag->imdb_rating = $item['rating'];
        $tag->imdb_vote_count = $item['vote_count'];
        $tag->imdb_popularity = $item['popularity'];
        $tag->imdb_metrics_updated_at = now();
        $tag->match_percentage = 60;
        $tag->categoria = $item['category'];
        $tag->order = ((int) Tags::max('order')) + 1;
        $tag->status = 'active';
        $tag->image = '/uploads/fotos/' . $filename;
        $tag->image_width = $imageMetadata['width'];
        $tag->image_height = $imageMetadata['height'];
        $tag->image_size_bytes = $imageMetadata['after_bytes'];
        $tag->image_optimized_at = now();

        try {
            $tag->save();
        } catch (Throwable $exception) {
            @unlink($imagePath);
            throw $exception;
        }

        return $tag;
    }

    private function downloadImage(string $url, string $directory, string $basename): array
    {
        $temporaryPath = $directory . '/' . $basename . '.download';

        try {
            $this->client->get($url, [
                'headers' => ['Accept' => 'image/*'],
                'sink' => $temporaryPath,
            ]);
        } catch (Throwable $exception) {
            @unlink($temporaryPath);
            throw $exception;
        }

        $mime = (new \finfo(FILEINFO_MIME_TYPE))->file($temporaryPath);
        $extensions = ['image/jpeg' => 'jpg', 'image/png' => 'png', 'image/webp' => 'webp'];

        if (!isset($extensions[$mime])) {
            @unlink($temporaryPath);
            throw new RuntimeException('O arquivo retornado pelo IMDb nao e uma imagem valida.');
        }

        $filename = $basename . '.' . $extensions[$mime];
        $finalPath = $directory . '/' . $filename;

        if (!rename($temporaryPath, $finalPath)) {
            @unlink($temporaryPath);
            throw new RuntimeException('Nao foi possivel finalizar o arquivo do cartaz.');
        }

        try {
            $metadata = $this->imageOptimizer->optimize($finalPath);
            $finalPath = $metadata['path'];
        } catch (Throwable $exception) {
            @unlink($finalPath);
            throw $exception;
        }

        return [basename($finalPath), $finalPath, $metadata];
    }
}
