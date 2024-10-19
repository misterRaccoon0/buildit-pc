<?php

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
        Schema::create('gpu', function (Blueprint $table) {
            $table->id();
            $table->char("model",64);
            $table->char("brand",96);
            $table->integer("vram");
            $table->text("bus");
            $table->text("clock");
            $table->text("memoryclock");
            $table->text("gddr");
            $table->integer("benchmark");
            $table->text("tdp");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('g_p_u_s');
    }
};
