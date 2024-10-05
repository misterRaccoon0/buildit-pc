<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GPU extends Model
{
    use HasFactory;
    protected $table = "gpu";
    protected $primaryKey = "id";
    public $timestamps = false;
}
