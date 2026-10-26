<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('tags', function (Blueprint $table) {
            $table->unsignedInteger('image_width')->nullable()->after('image');
            $table->unsignedInteger('image_height')->nullable()->after('image_width');
            $table->unsignedBigInteger('image_size_bytes')->nullable()->after('image_height');
            $table->timestamp('image_optimized_at')->nullable()->after('image_size_bytes');
        });
    }

    public function down(): void
    {
        Schema::table('tags', function (Blueprint $table) {
            $table->dropColumn([
                'image_width',
                'image_height',
                'image_size_bytes',
                'image_optimized_at',
            ]);
        });
    }
};
