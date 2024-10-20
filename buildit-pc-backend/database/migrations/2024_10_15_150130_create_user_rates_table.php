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
            $table->unsignedBigInteger('post_id',false);
            $table->timestamps();
            $table->float('rate');
            $table->foreignIdFor(UserPost::class, 'post_id')
                  ->constrained(
                      app(UserPost::class)->getTable(),
                      'id'
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
