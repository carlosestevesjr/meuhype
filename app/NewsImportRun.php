<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class NewsImportRun extends Model
{
    protected $table = 'news_import_runs';

    protected $casts = [
        'started_at' => 'datetime',
        'finished_at' => 'datetime',
    ];

    public function items()
    {
        return $this->hasMany(NewsImportItem::class, 'news_import_run_id')->orderBy('imported_at');
    }
}
