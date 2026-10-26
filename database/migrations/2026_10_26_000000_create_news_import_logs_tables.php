<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('news_import_runs', function (Blueprint $table) {
            $table->id();
            $table->string('source', 50)->default('cronjob');
            $table->string('status', 20)->default('running');
            $table->unsignedInteger('imported_count')->default(0);
            $table->text('error_message')->nullable();
            $table->timestamp('started_at');
            $table->timestamp('finished_at')->nullable();
            $table->timestamps();
            $table->index(['started_at', 'status']);
        });

        Schema::create('news_import_items', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('news_import_run_id');
            $table->unsignedBigInteger('news_id')->nullable();
            $table->unsignedBigInteger('channels_id')->nullable();
            $table->string('news_title');
            $table->string('channel_name')->nullable();
            $table->text('news_link')->nullable();
            $table->text('news_image')->nullable();
            $table->date('news_date')->nullable();
            $table->timestamp('imported_at');
            $table->timestamps();
            $table->index(['news_import_run_id', 'imported_at'], 'news_import_items_run_date_index');
            $table->index('news_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('news_import_items');
        Schema::dropIfExists('news_import_runs');
    }
};
