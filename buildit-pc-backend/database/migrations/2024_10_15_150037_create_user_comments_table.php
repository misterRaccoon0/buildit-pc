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
        Schema::create('user_comments', function (Blueprint $table) {
            $table->id();
            $table->mediumText('content');
            $table->timestamps();

        });
        Schema::table('user_comments', function(Blueprint $table){

            $table->foreignIdFor(UserPost::class,'post_id')
                ->nullable()
                ->constrained(app(UserPost::class)->getTable());
        });

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_comments');
    }
};
