<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PSU extends Model
{
    use HasFactory;
    protected $table = "psu";
    protected $primaryKey = "id";
    protected $fillable = ["brand","model","watts","rating"];
    public $timestamps = false;
}
