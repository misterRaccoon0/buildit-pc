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
        'benchmarkScore'
    ];

    public function cpu()
    {
        return $this->belongsTo(CPU::class, 'cpu');
    }

    public function gpu()
    {
        return $this->belongsTo(GPU::class, 'gpu');
    }

    public function motherboard()
    {
        return $this->belongsTo(Motherboard::class, 'motherboard');
    }

    public function ram()
    {
        return $this->belongsTo(RAM::class, 'ram');
    }

    public function storage()
    {
        return $this->belongsTo(Storage::class, 'storage');
    }

    public function psu()
    {
        return $this->belongsTo(PSU::class, 'psu');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

}
