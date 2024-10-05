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
        Schema::create('motherboard', function (Blueprint $table) {
            $table->id();
            $table->char("brand",64);
            $table->char("model",96);
            $table->text("socket");
            $table->text("chipset");
            $table->text("bus");
            $table->integer("ramslot");
            $table->text("ramsupport");
            $table->text("storageinterface");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('motherboards');
    }
};
