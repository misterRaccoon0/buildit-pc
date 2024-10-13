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
        Schema::create('cpu', function (Blueprint $table) {
            $table->id();
            $table->char("model",96);
            $table->char("name", 255);
            $table->char("brand",64);
            $table->integer("cores");
            $table->integer("threads");
            $table->char("clockspeed");
            $table->integer("benchmark");
            $table->text("socket");
            $table->integer("tdp");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cpu');
    }
};
