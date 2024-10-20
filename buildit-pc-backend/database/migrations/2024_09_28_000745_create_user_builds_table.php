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
            $table->foreignIdFor(CPU::class, 'cpu_id')
                  ->nullable()
                  ->constrained(
                      app(CPU::class)->getTable(),
                      'id'
                  )
                  ->cascadeOnUpdate()
                  ->nullOnDelete();
            $table->foreignIdFor(GPU::class,"gpu_id")
                  ->nullable()
                  ->constrained(
                      app(GPU::class)->getTable(),
                      'id'
                  )
                  ->cascadeOnUpdate()
                  ->nullOnDelete();
            $table->foreignIdFor(Motherboard::class,"motherboard_id")
                  ->nullable()
                  ->constrained(
                      app(Motherboard::class)->getTable(),
                      'id'
                  )
                  ->cascadeOnUpdate()
                  ->nullOnDelete();
            $table->foreignIdFor(RAM::class,"ram_id")
                  ->nullable()
                  ->constrained(
                      app(RAM::class)->getTable(),
                      'id'
                  )
                  ->cascadeOnUpdate()
                  ->nullOnDelete();
            $table->foreignIdFor(Storage::class,"storage_id")
                  ->nullable()
                  ->constrained(
                      app(Storage::class)->getTable(),
                      'id'
                  )
                  ->cascadeOnUpdate()
                  ->nullOnDelete();
            $table->foreignIdFor(PSU::class,"psu_id")
                  ->constrained(
                      app(PSU::class)->getTable(),
                      'id'
                  )
                  ->cascadeOnUpdate()
                  ->nullOnDelete();
            $table->foreignIdFor(User::class,"user_id")
                  ->constrained(
                      app(User::class)->getTable(),
                      'id'
                  )
                  ->nullOnDelete();
            $table->string('build_hash')->unique();
            $table->boolean('isPublic')->default(false);
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
