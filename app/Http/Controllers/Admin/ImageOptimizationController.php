<?php

namespace App\Http\Controllers\Admin;

use App\Admin;
use App\Channels;
use App\Config;
use App\Http\Controllers\Controller;
use App\News;
use App\Podcasts;
use App\Services\TagImageOptimizer;
use Illuminate\Http\Request;
use Validator;

class ImageOptimizationController extends Controller
{
    private const TYPES = [
        'news' => [News::class, 'image', 'Notícias'],
        'channels' => [Channels::class, 'image', 'Canais'],
        'podcasts' => [Podcasts::class, 'image', 'Podcasts'],
        'admins' => [Admin::class, 'image', 'Administradores'],
        'configs' => [Config::class, 'image_logo', 'Configurações'],
    ];

    public function optimize(Request $request, string $type, TagImageOptimizer $optimizer)
    {
        abort_unless(isset(self::TYPES[$type]), 404);

        $validator = Validator::make($request->all(), [
            'after_id' => 'nullable|integer|min:0',
        ]);
        if ($validator->fails()) {
            return $this->response($type, [], $validator->errors()->all(), null, 422);
        }

        [$modelClass, $column, $label] = self::TYPES[$type];
        $afterId = (int) $request->input('after_id', 0);
        $records = $modelClass::query()
            ->whereNotNull($column)
            ->where($column, '!=', '')
            ->where('id', '>', $afterId)
            ->orderBy('id')
            ->limit(3)
            ->get();

        $items = [];
        $errors = [];
        $processedIds = [];

        foreach ($records as $record) {
            $processedIds[] = $record->id;
            try {
                $metadata = $optimizer->optimize(public_path($record->{$column}));
                $record->{$column} = str_replace(public_path(), '', $metadata['path']);
                $record->save();
                $items[] = [
                    'id' => $record->id,
                    'registro' => $record->title ?? $record->name ?? ('#' . $record->id),
                    'arquivo' => $record->{$column},
                    'dimensoes' => $metadata['width'] . 'x' . $metadata['height'],
                    'antes_kb' => round($metadata['before_bytes'] / 1024, 1),
                    'depois_kb' => round($metadata['after_bytes'] / 1024, 1),
                    'economia_kb' => round($metadata['saved_bytes'] / 1024, 1),
                    'alterada' => $metadata['changed'],
                ];
            } catch (\Throwable $exception) {
                $errors[] = ($record->title ?? $record->name ?? ('#' . $record->id)) . ': ' . $exception->getMessage();
            }
        }

        $lastId = $processedIds ? max($processedIds) : null;
        $nextUrl = null;
        if ($lastId && $modelClass::query()->whereNotNull($column)->where($column, '!=', '')->where('id', '>', $lastId)->exists()) {
            $nextUrl = route('images.optimize', ['type' => $type, 'after_id' => $lastId]);
        }

        return $this->response($label, $items, $errors, $nextUrl);
    }

    private function response(string $label, array $items, array $errors, ?string $nextUrl, int $status = 200)
    {
        $result = [
            'Otimizacao_' . str_replace(' ', '_', $label) => [
                'processadas_neste_lote' => $items,
                'total_alteradas' => count(array_filter($items, fn ($item) => $item['alterada'])),
                'economia_kb' => round(array_sum(array_column($items, 'economia_kb')), 1),
                'erros' => $errors,
                'proximo_lote' => $nextUrl,
            ],
        ];
        $refresh = $nextUrl ? '<meta http-equiv="refresh" content="1;url=' . e($nextUrl) . '">' : '';
        $message = $nextUrl ? 'Próximo lote será iniciado automaticamente...' : 'Otimização concluída.';

        return response(
            '<!doctype html><html><head><meta charset="UTF-8">' . $refresh . '</head><body><p>'
            . e($message) . '</p><pre>' . e(print_r($result, true)) . '</pre></body></html>',
            $status,
            ['Content-Type' => 'text/html; charset=UTF-8']
        );
    }
}
