<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Storage extends Model
{
    use HasFactory;
    protected $table = "storage";
    protected $primaryKey = "id";
    protected $fillable = ["brand","model","size","unit_size","interface","readspeed","writespeed"];
    public $timestamps = false;
}
