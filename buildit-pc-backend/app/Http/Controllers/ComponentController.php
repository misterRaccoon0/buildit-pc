<?php

namespace App\Http\Controllers;

use App\Models\CPU;
use App\Models\GPU;
use App\Models\Motherboard;
use App\Models\PSU;
use App\Models\RAM;
use App\Models\Storage;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;




class ComponentController extends Controller
{
    public function read(Request $request){

        $componentClass = [
            "cpu" => "c_p_u_s",
            "gpu" => "g_p_u_s",
            "motherboard" => "motherboards",
            "psu" => "p_s_u_s",
            "ram" => "r_a_m_s",
            "storage" => "storages"
        ][$request->name];
        if($componentClass === null)
        return response("Not Found", 404);
        // $res = CPU::where("id", $request->id);
        ;
        // DB::query("SELECT * FROM c_p_u_s")->where("id", (string)$request->id)->get()->toJson();
        return response(DB::table($componentClass)->where("id","=", $request->id)->get()->toJson(),202);
    }
    public function delete(Request $request){
        $componentClass = [
            "cpu" => "c_p_u_s",
            "gpu" => "g_p_u_s",
            "motherboard" => "motherboards",
            "psu" => "p_s_u_s",
            "ram" => "r_a_m_s",
            "storage" => "storages"
        ][$request->componentName];
        
        if($componentClass === null)
        return response("Not Found", 404);
    if(DB::table($componentClass)->where(
        "id","=", $request->id
    )->exists() ===false)return response("not ok",404);
        DB::table($componentClass)->where("id","=", $request->id)->delete();
        return response("ok",200);
    }
    public function gpuPut(Request $request){
       if(DB::table("g_p_u_s")->exists() === false)
        return response("gpu does not exist",status: 404);
        DB::update("UPDATE g_p_u_s SET model = ?,brand = ?,vram = ?,bus = ?,clock = ?,memoryclock = ?,gddr =?,benchmark = ?,tdp =? WHERE id = ?",[$request->model,$request->brand, $request->vram, $request->bus,$request->clock, $request->memclock,$request->gddr, $request->benchmark,  $request->tdp, $request->id]);
        return response("updated",200);
    }
    public function gpuPost(Request $request){
        
        
        // DB::table($componentClass)->insert("INSERT INTO g_p_u_s(model,brand,vram,bus,clock,memoryclock,gddr,benchmark,tdp) VALUES(?,?,?,?,?,?,?,?,?)", [$request->model,$request->brand,(int)$request->vram,$request->bus,$request->clock,$request->memoryclock,$request->gddr,(int)$request->benchmark,$request->tdp]);
        DB::insert("INSERT INTO g_p_u_s(model,brand,vram,bus,clock,memoryclock,gddr,benchmark,tdp) VALUES(?,?,?,?,?,?,?,?,?)",[$request->model,$request->brand, $request->vram, $request->bus,$request->clock, $request->memclock,$request->gddr, $request->benchmark,  $request->tdp]);
        // DB::table($componentClass)->insert(["model" => $request->model,"brand" => $request->brand, "vram" => $request->vram, "bus" => $request->bus,"clock" =>$request->clock, "memoryclock" => $request->memclock,"gddr" => $request->gddr, "benchmark" => $request->benchmark, "tdp" => $request->tdp]);
        return response("posted", 200);
    }
}
