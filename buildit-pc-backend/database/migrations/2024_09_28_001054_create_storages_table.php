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
        Schema::create('storage', function (Blueprint $table) {
            $table->id();
            $table->float("size");
            $table->enum("unitsize",["kb","mb","gb","tb","pb"]);
            $table->char("brand",64);
            $table->char("model",64);
            $table->text("interface");
            $table->float("readspeed");
            $table->float("writespeed");
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
