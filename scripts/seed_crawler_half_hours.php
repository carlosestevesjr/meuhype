<?php

use App\Crawler;
use Illuminate\Contracts\Console\Kernel;
use Illuminate\Support\Facades\DB;

require dirname(__DIR__) . '/vendor/autoload.php';

$app = require dirname(__DIR__) . '/bootstrap/app.php';
$app->make(Kernel::class)->bootstrap();

function halfHourSlot(string $time): string
{
    [$hour, $minute] = array_map('intval', explode(':', $time));
    $minute = $minute >= 30 ? 30 : 0;

    return sprintf('%02d:%02d:00', $hour, $minute);
}

DB::transaction(function (): void {
    $existing = Crawler::orderBy('time_initial')->orderBy('id')->get();
    $recordsByTime = [];

    foreach ($existing as $record) {
        $slot = halfHourSlot($record->time_initial);

        if (isset($recordsByTime[$slot])) {
            throw new RuntimeException(
                'Mais de um registro cairia no horario ' . $slot . ': IDs '
                . $recordsByTime[$slot]->id . ' e ' . $record->id
            );
        }

        $recordsByTime[$slot] = $record;
    }

    for ($index = 0; $index < 48; $index++) {
        $minutes = $index * 30;
        $slot = sprintf('%02d:%02d:00', intdiv($minutes, 60), $minutes % 60);

        if (isset($recordsByTime[$slot])) {
            $record = $recordsByTime[$slot];
        } else {
            $record = new Crawler();
            $record->tags_id = 0;
            $record->type = 'site';
            $record->description = null;
            $record->status = 'hidden';
        }

        $record->title = $slot;
        $record->time_initial = $slot;
        $record->order = $index + 1;
        $record->save();
    }

    if (Crawler::count() !== 48) {
        throw new RuntimeException('A tabela nao terminou com exatamente 48 registros.');
    }
});

echo 'Crawler preenchido com 48 intervalos de 30 minutos.' . PHP_EOL;
