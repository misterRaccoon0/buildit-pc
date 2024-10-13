<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GPU extends Model
{
    use HasFactory;
    protected $table = "gpu";
    protected $primaryKey = "id";
    protected $fillable = ["model","brand","vram","bus","clock","memoryclock","gddr","benchmark", "tdp"];
    public $timestamps = false;
    protected function casts() : array {
        return [
        "benchmark" => "integer",
        "tdp" => "integer",
        ];
    }
}
