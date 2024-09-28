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
        Schema::create('p_s_u_s', function (Blueprint $table) {
            $table->id();
            $table->char("brand",64);
            $table->char("model",64);
            $table->text("watts");
            $table->float("ratings");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('p_s_u_s');
    }
};
