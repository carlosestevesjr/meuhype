<?php

namespace App\Services;

use App\Channels;
use App\News;
use App\NewsImportItem;
use App\NewsImportRun;
use Throwable;

class NewsImportLogger
{
    private ?NewsImportRun $run = null;

    public function __destruct()
    {
        if ($this->run) {
            $this->finish('interrupted', 'A execução foi encerrada antes da finalização normal.');
        }
    }

    public function start(string $source = 'cronjob'): ?NewsImportRun
    {
        try {
            $run = new NewsImportRun();
            $run->source = $source;
            $run->status = 'running';
            $run->imported_count = 0;
            $run->started_at = now();
            $run->save();
            $this->run = $run;

            return $run;
        } catch (Throwable $exception) {
            report($exception);
            return null;
        }
    }

    public function record(News $news): void
    {
        if (!$this->run) {
            return;
        }

        try {
            $channel = Channels::find($news->channels_id);
            $item = new NewsImportItem();
            $item->news_import_run_id = $this->run->id;
            $item->news_id = $news->id;
            $item->channels_id = $news->channels_id;
            $item->news_title = $news->title;
            $item->channel_name = $channel?->name;
            $item->news_link = $news->link;
            $item->news_image = $news->image;
            $item->news_date = $news->data;
            $item->imported_at = now();
            $item->save();

            $this->run->increment('imported_count');
            $this->run->refresh();
        } catch (Throwable $exception) {
            report($exception);
        }
    }

    public function finish(string $status = 'completed', ?string $error = null): void
    {
        if (!$this->run) {
            return;
        }

        try {
            $this->run->status = $status;
            $this->run->error_message = $error;
            $this->run->finished_at = now();
            $this->run->save();
        } catch (Throwable $exception) {
            report($exception);
        } finally {
            $this->run = null;
        }
    }
}
