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
            $table->string("filename")->nullable();
            $table->binary("thumbnail")->nullable();
        });
        Schema::table('user_build',function($table){
            $table->foreignIdFor(CPU::class,'cpu_id')->nullable()->constrained(app(CPU::class)->getTable());
            $table->foreignIdFor(GPU::class,'gpu_id')->nullable()->constrained(app(CPU::class)->getTable());
            $table->foreignIdFor(PSU::class,'psu_id')->nullable()->constrained(app(CPU::class)->getTable());
            $table->foreignIdFor(RAM::class,'ram_id')->nullable()->constrained(app(CPU::class)->getTable());
            $table->foreignIdFor(Motherboard::class,'motherboard_id')->nullable()->constrained(app(CPU::class)->getTable());
            $table->foreignIdFor(Storage::class,'storage_id')->nullable()->constrained(app(CPU::class)->getTable());
            $table->foreignIdFor(User::class,'user_id')->nullable()->constrained(app(User::class)->getTable());
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
