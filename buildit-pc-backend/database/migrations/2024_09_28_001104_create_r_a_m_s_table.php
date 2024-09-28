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
        Schema::create('r_a_m_s', function (Blueprint $table) {
            $table->id();
            $table->integer("size");
            $table->text("speed");
            $table->char("model",64);
            $table->char("gen", 32);
            $table->text("cl");
            $table->text("tdp");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('r_a_m_s');
    }
};
