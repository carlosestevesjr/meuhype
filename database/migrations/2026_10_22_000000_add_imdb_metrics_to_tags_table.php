<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('tags', function (Blueprint $table) {
            $table->decimal('imdb_rating', 3, 1)->nullable()->after('imdb_url');
            $table->unsignedBigInteger('imdb_vote_count')->nullable()->after('imdb_rating');
            $table->unsignedInteger('imdb_popularity')->nullable()->after('imdb_vote_count');
            $table->timestamp('imdb_metrics_updated_at')->nullable()->after('imdb_popularity');
        });
    }

    public function down(): void
    {
        Schema::table('tags', function (Blueprint $table) {
            $table->dropColumn(['imdb_rating', 'imdb_vote_count', 'imdb_popularity', 'imdb_metrics_updated_at']);
        });
    }
};
