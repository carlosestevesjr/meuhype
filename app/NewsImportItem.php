<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class NewsImportItem extends Model
{
    protected $table = 'news_import_items';

    protected $casts = [
        'news_date' => 'date',
        'imported_at' => 'datetime',
    ];

    public function run()
    {
        return $this->belongsTo(NewsImportRun::class, 'news_import_run_id');
    }
}
