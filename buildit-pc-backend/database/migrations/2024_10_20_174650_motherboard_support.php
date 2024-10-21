<?php

use App\Models\CPU;
use App\Models\GPU;
use App\Models\Motherboard;
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

        Schema::create('cpu_support', function(Blueprint $table){
            $table->id();
            $table->foreignIdFor(CPU::class, 'cpu_id')
                ->nullable()
                ->constrained(app(CPU::class)->getTable());
            $table->foreignIdFor(Motherboard::class, 'motherboard_id')
                ->nullable()
                ->constrained(app(Motherboard::class)->getTable());
        });

        Schema::create('gpu_support', function(Blueprint $table){
            $table->id();
            $table->foreignIdFor(GPU::class, 'gpu_id')
                ->nullable()
                ->constrained(app(GPU::class)->getTable());
            $table->foreignIdFor(Motherboard::class, 'motherboard_id')
                ->nullable()
                ->constrained(app(Motherboard::class)->getTable());
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists([
            'cpu_support',
            'gpu_support'
        ]);
    }
};
