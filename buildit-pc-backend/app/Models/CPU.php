<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CPU extends Model
{
    use HasFactory;
    protected $table = "cpu";
    protected $primaryKey = "cpu_id";
    protected $fillable = ["name","model","brand","cores","threads","clockspeed","benchmark","socket", "TDP"];
    protected function casts() : array {
        return [
        "cores" => "integer",
        "threads" => "integer",
        "benchmark" => "integer"];
    }
}
