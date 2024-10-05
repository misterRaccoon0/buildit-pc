<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Models\UserBuild;
return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('user_post', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->text("content")->nullable();
            $table->string("filename")->nullable();
            $table->binary("thumbnail", 1024 * 1024 * 4)->nullable();
            $table->foreignIdFor(UserBuild::class, 'url_hash')->references('build_hash')->on(app(UserBuild::class)->getTable())->cascadeOnUpdate()->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_post');
    }
};
