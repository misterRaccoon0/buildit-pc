<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Motherboard extends Model
{
    use HasFactory;
    protected $table = "motherboard";
    protected $primaryKey = "id";
    protected $fillable = ["brand","model","socket","chipset","bus","ramslot","ramsupport","storageinterface"];
    public $timestamps = false;
}
