<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('user_news_likes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('users_id');
            $table->unsignedBigInteger('news_id');
            $table->timestamps();

            $table->unique(['users_id', 'news_id']);
            $table->index('news_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('user_news_likes');
    }
};
