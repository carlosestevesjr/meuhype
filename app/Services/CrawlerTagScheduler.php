<?php

namespace App\Services;

use App\Crawler;
use App\Tags;
use Illuminate\Support\Facades\DB;
use RuntimeException;

class CrawlerTagScheduler
{
    private array $assignedCrawlerIds = [];

    /**
     * Distribui a tag em um crawler de horario existente, alterando apenas tags_id.
     */
    public function schedule(Tags $tag): array
    {
        $existing = Crawler::where('tags_id', $tag->id)->first();

        if ($existing) {
            return $this->result($existing, $tag, false);
        }

        $crawler = Crawler::query()
            ->lockForUpdate()
            ->orderBy('time_initial')
            ->orderBy('id')
            ->get()
            ->first(function (Crawler $crawler) {
                return $this->isTimeTitle($crawler->title)
                    && !in_array($crawler->id, $this->assignedCrawlerIds, true);
            });

        if (!$crawler) {
            throw new RuntimeException('Nao ha mais crawlers com titulo de horario disponiveis para distribuir as novas tags.');
        }

        // Query Builder evita atualizar updated_at: somente o ID da tag pode mudar.
        DB::table('crawler')->where('id', $crawler->id)->update(['tags_id' => $tag->id]);
        $crawler->tags_id = $tag->id;
        $this->assignedCrawlerIds[] = $crawler->id;

        return $this->result($crawler, $tag, true);
    }

    private function isTimeTitle(?string $title): bool
    {
        if (!$title || !preg_match('/^(?:[01]\d|2[0-3]):[0-5]\d:[0-5]\d$/', $title)) {
            return false;
        }

        return true;
    }

    private function result(Crawler $crawler, Tags $tag, bool $updated): array
    {
        return [
            'crawler_id' => $crawler->id,
            'tag_id' => $crawler->tags_id,
            'tag' => $tag->title,
            'titulo_crawler_preservado' => $crawler->title,
            'horario' => $crawler->time_initial,
            'tipo' => $crawler->type,
            'status' => $crawler->status,
            'tags_id_atualizado' => $updated,
        ];
    }
}
