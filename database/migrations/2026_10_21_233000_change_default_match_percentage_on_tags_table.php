<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        DB::statement('ALTER TABLE tags MODIFY match_percentage TINYINT UNSIGNED NOT NULL DEFAULT 60');
    }

    public function down(): void
    {
        DB::statement('ALTER TABLE tags MODIFY match_percentage TINYINT UNSIGNED NOT NULL DEFAULT 80');
    }
};
