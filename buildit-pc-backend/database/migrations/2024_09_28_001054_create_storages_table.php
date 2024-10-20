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
        Schema::create('storages', function (Blueprint $table) {
            $table->id();
            $table->integer("size");
            $table->enum("unitsize",["KB","MB","GB","TB","PB"]);
            $table->char("brand");
            $table->char("model");
            $table->text("interface");
            $table->char("readspeed");
            $table->char("writespeed");
            $table->integer("price");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('storages');
    }
};
