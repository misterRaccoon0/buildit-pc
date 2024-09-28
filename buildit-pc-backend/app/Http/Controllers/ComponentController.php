<?php

namespace App\Http\Controllers;

use App\Models\CPU;
use App\Models\GPU;
use App\Models\Motherboard;
use App\Models\PSU;
use App\Models\RAM;
use App\Models\Storage;
use Illuminate\Http\Request;

class ComponentController extends Controller
{
    public function read(Request $request){
        $ComponentClass = [
            "cpu" => CPU::class,
            "gpu" => GPU::class,
            "motherboard" => Motherboard::class,
            "psu" => PSU::class,
            "ram" => RAM::class,
            "storage" => Storage::class
        ][$request->name];
        if($ComponentClass === null)
        return response("Not Found", 404);
        return $ComponentClass::where("id", $request->id);
    }
}
