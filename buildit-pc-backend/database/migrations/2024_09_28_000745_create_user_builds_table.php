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
        Schema::create('user_builds', function (Blueprint $table) {
            $table->id();
            $table->foreignIdFor(CPU::class, "cpu")->nullable();
            $table->foreignIdFor(GPU::class, "gpu")->nullable();
            $table->foreignIdFor(Motherboard::class, "motherboard")->nullable();
            $table->foreignIdFor(RAM::class, "ram")->nullable();
            $table->foreignIdFor(Storage::class, "storage")->nullable();
            $table->foreignIdFor(PSU::class, "psu")->nullable();
            $table->foreignIdFor(User::class, "user");


            $table->string('name'); 
            $table->text('description')->nullable(); 
            $table->integer('total_tdp')->nullable(); 
            $table->decimal('total_price', 10, 2)->nullable();
            $table->integer('benchmarkScore')->nullable();

            $table->timestamps(); 
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_builds');
    }
};
