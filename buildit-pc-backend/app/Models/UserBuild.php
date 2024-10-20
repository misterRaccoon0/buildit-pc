<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class UserBuild extends Model
{
    use HasFactory;
    protected $table = "user_build";
    protected $primaryKey = "id";

    public $timestamps = true; // set to true l8r
    
    protected $fillable = [
        'cpu', 
        'gpu', 
        'motherboard', 
        'ram', 
        'storage', 
        'psu', 
        'user_id', 
        'name', 
        'description', 
        'total_tdp', 
        'total_price', 
        'benchmarkScore',
        'image_url'
    ];

    
    public function cpu()
    {
        return $this->belongsTo(CPU::class, 'cpu')->select('id', 'brand', 'name', 'model'); 
    }

    public function gpu()
    {
        return $this->belongsTo(GPU::class, 'gpu')->select('id', 'brand', 'model');
    }

    public function motherboard()
    {
        return $this->belongsTo(Motherboard::class, 'motherboard')->select('id', 'brand', 'model');
    }

    public function ram()
    {
        return $this->belongsTo(RAM::class, 'ram')->select('id', 'model');
    }

    public function storage()
    {
        return $this->belongsTo(Storage::class, 'storage')->select('id', 'brand', 'model');
    }

    public function psu()
    {
        return $this->belongsTo(PSU::class, 'psu')->select('id', 'brand', 'model');
    }


}
