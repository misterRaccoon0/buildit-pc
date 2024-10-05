<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class UserBuild extends Model
{
    use HasFactory;
    protected $table = "user_build";
    public $timestamps = false;
}
