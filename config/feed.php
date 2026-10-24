<?php

return [
    /*
    |--------------------------------------------------------------------------
    | Período do FeedDock
    |--------------------------------------------------------------------------
    |
    | Quantidade de dias anteriores a hoje que entram no FeedDock e no Reels.
    | Com o valor 3, por exemplo, o período inclui hoje e os três dias anteriores.
    |
    */
    'feed_dock_days_back' => (int) env('FEED_DOCK_DAYS_BACK', 3),
];
