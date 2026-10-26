<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\NewsImportRun;

class NewsImportLogController extends Controller
{
    public function index()
    {
        $runs = NewsImportRun::with('items')
            ->orderByDesc('started_at')
            ->paginate(30);
        $runsByDate = $runs->getCollection()->groupBy(function (NewsImportRun $run) {
            return $run->started_at->format('Y-m-d');
        });

        return view('admin.pages.news-import-logs.index', compact('runs', 'runsByDate'));
    }
}
