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
                  ->references('id')
                  ->on(app(CPU::class)->getTable())
                  ->cascadeOnUpdate()
                  ->nullOnDelete();
            $table->foreignIdFor(GPU::class,"gpu_id")
                  ->nullable()
                  ->references('id')
                  ->on(app(GPU::class)->getTable())
                  ->cascadeOnUpdate()
                  ->nullOnDelete();
            $table->foreignIdFor(Motherboard::class,"motherboard_id")
                  ->nullable()
                  ->references('id')->on(app(Motherboard::class)->getTable())
                  ->cascadeOnUpdate()
                  ->nullOnDelete();
            $table->foreignIdFor(RAM::class,"ram_id")
                  ->nullable()
                  ->references('id')
                  ->on(app(RAM::class)->getTable())
                  ->cascadeOnUpdate()
                  ->nullOnDelete();
            $table->foreignIdFor(Storage::class,"storage_id")
                  ->nullable()
                  ->references('id')
                  ->on(app(Storage::class)->getTable())
                  ->cascadeOnUpdate()
                  ->nullOnDelete();
            $table->foreignIdFor(PSU::class,"psu_id")
                  ->references('id')
                  ->on(app(PSU::class)->getTable())
                  ->cascadeOnUpdate()
                  ->nullOnDelete();
            $table->foreignIdFor(User::class,"user_id")
                  ->references('id')
                  ->on(app(User::class)->getTable())
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
