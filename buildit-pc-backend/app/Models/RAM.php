<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RAM extends Model
{
    use HasFactory;
    protected $table = "ram";
    protected $primaryKey = "id";
    public $timestamps = false;
}
