<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserBuild extends Model
{
    use HasFactory;
    protected $table = "user_build";
    protected $primaryKey = "id";
    public $timestamps = false;
    protected $fillable = ['isPublic'];
}
