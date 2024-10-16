<?php

use App\Models\User;
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
            $table->string('url_hash')->nullable();
        });
        Schema::table('user_comments', function(Blueprint $table){
            $table->foreignIdFor(User::class, 'user_id')->nullable()->constrained(app(User::class)->getTable());
            $table->foreign('url_hash')
                ->on(app(UserPost::class)->getTable())
                ->references('url_hash');
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
