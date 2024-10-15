<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CPU extends Model
{
    use HasFactory;
    protected $primaryKey = "id";
    protected $table = "cpus";
    protected $fillable = ["name","model","brand","cores","threads","clockspeed","benchmark","socket", "tdp"];
    public $timestamps = false;
    protected function casts() : array {
        return [
        "cores" => "integer",
        "threads" => "integer",
        "tdp" => "integer",
        "benchmark" => "integer"];
    }
}
