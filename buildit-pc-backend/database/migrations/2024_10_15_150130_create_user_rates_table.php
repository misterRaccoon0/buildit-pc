<?php

use App\Models\UserPost;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('user_rates', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->foreignIdFor(UserPost::class, 'post_id')
                  ->nullable()
                  ->constrained(
                      app(UserPost::class)->getTable()
                  )
                  ->cascadeOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_rates');
    }
};
