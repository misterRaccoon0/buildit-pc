<?php

use App\Models\CPU;
use App\Models\GPU;
use App\Models\Motherboard;
use App\Models\PSU;
use App\Models\RAM;
use App\Models\Storage;
use App\Models\User;
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
        Schema::create('user_build', function (Blueprint $table) {
            $table->id();
            $table->string('build_hash')->unique();
            $table->boolean('isPublic')->default(false);
        });
        Schema::table('user_build',function($table){

            $table->foreignId('user_id')->nullable()->constrained('users');
        });
    }
    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_build');
    }
};
