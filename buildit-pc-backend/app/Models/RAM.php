<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RAM extends Model
{
    use HasFactory;
    protected $table = "ram";
    protected $primaryKey = "id";
    protected $fillable = ["model","size","speed","gen","cl","tdp"];
    public $timestamps = false;
}
