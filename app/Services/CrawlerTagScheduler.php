<?php

namespace App\Services;

use App\Crawler;
use App\Tags;

class CrawlerTagScheduler
{
    private const SLOT_INTERVAL_MINUTES = 30;

    private const SLOTS_PER_DAY = 48;

    /**
     * Cria um crawler ativo para a tag no horario de menor ocupacao do dia.
     */
    public function schedule(Tags $tag): array
    {
        $existing = Crawler::where('tags_id', $tag->id)->first();

        if ($existing) {
            return $this->result($existing, false);
        }

        // O bloqueio evita que importacoes simultaneas escolham o mesmo slot livre.
        $crawlers = Crawler::query()->lockForUpdate()->get();
        $time = $this->leastUsedTime($crawlers->pluck('time_initial')->all());

        $crawler = new Crawler();
        $crawler->title = $tag->title;
        $crawler->tags_id = $tag->id;
        $crawler->time_initial = $time;
        $crawler->type = 'site';
        $crawler->description = 'Agendamento criado automaticamente pelo importador do IMDb.';
        $crawler->order = ((int) $crawlers->max('order')) + 1;
        $crawler->status = 'active';
        $crawler->save();

        return $this->result($crawler, true);
    }

    /**
     * Distribui novos registros entre os 48 slots de 30 minutos.
     */
    private function leastUsedTime(array $scheduledTimes): string
    {
        $usage = array_fill(0, self::SLOTS_PER_DAY, 0);

        foreach ($scheduledTimes as $scheduledTime) {
            if (!$scheduledTime) {
                continue;
            }

            [$hour, $minute] = array_map('intval', explode(':', $scheduledTime));
            $slot = (($hour * 60) + $minute) / self::SLOT_INTERVAL_MINUTES;

            if (isset($usage[(int) $slot])) {
                $usage[(int) $slot]++;
            }
        }

        $slot = array_search(min($usage), $usage, true);
        $minutes = $slot * self::SLOT_INTERVAL_MINUTES;

        return sprintf('%02d:%02d:00', intdiv($minutes, 60), $minutes % 60);
    }

    private function result(Crawler $crawler, bool $created): array
    {
        return [
            'crawler_id' => $crawler->id,
            'tag_id' => $crawler->tags_id,
            'tag' => $crawler->title,
            'horario' => $crawler->time_initial,
            'tipo' => $crawler->type,
            'status' => $crawler->status,
            'criado' => $created,
        ];
    }
}
