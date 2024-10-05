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
    private static $components =
          [
            "cpu" => CPU::class,
            "gpu" => GPU::class,
            "motherboard" => Motherboard::class,
            "psu" => PSU::class,
            "ram" => RAM::class,
            "storage" => Storage::class,
        ];
    public function read(Request $request){
        $componentClass = ComponentController::$components[$request->component_name];
        $component = $componentClass::where("id",$request->id);
        if (!$component->exists()){
            return response("Component does not exist.", 404);
        }
        return $component->first()->toJson();
    }
    public function delete(Request $request){
        $componentClass = ComponentController::$components[$request->component_name];
        $component = $componentClass::where("id",$request->id);
        if (!$component->exists())
            return response("Component not found", 404);
        $component->delete();
        return response("component successfully deleted.", 200);
    }
    public function store(Request $request){
        $componentClass = ComponentController::$components[$request->component_name];
        $componentClass::insert($request->json()->all());
        return response(json_encode($request->json()->all()),200);
    }
    public function update(Request $request){
        $componentClass = ComponentController::$components[$request->component_name];
        $component = $componentClass::where("id", $request->id);
        if (!$component->exists())
            return response("Component not found", 404);
        $component->update($request->json()->all());
        return response($component->first()->toJson(),200);
    }








    public function getCPU(Request $request)
    {

        $components = CPU::all(); 
    
        $components = $components->map(function ($component) {
            $component->cpuName = "{$component->brand} {$component->name} {$component->model}";            
            $component->specs = "{$component->cores} Cores | {$component->threads} Threads | {$component->clockspeed} | Socket: {$component->socket}";
    
            return $component;
        });
    
        return response()->json($components);
    }

    public function getGPU(Request $request)
    {

        $components = GPU::all();
    
        $components = $components->map(function ($component) {
            $component->gpuName = "{$component->brand} {$component->model}";
            
            $component->specs = "{$component->vram} vram | {$component->gddr} | {$component->clock} | {$component->bus}";
    
            return $component;
        });
    
        return response()->json($components);
    }

    public function getMOBO(Request $request)
    {

        $components = Motherboard::all();
    
        $components = $components->map(function ($component) {
            $component->moboName = "{$component->brand} {$component->model}";
            
            $component->specs = "{$component->socket} | {$component->chipset} | {$component->ramsupport} | {$component->bus} | {$component->storageinterface}";
    
            return $component;
        });
    
        return response()->json($components);
    }

    public function getRAM(Request $request)
    {

        $components = RAM::all();
    
        $components = $components->map(function ($component) {
            $component->ramName = "{$component->model}";
            
            $component->specs = "{$component->size} | {$component->speed} | {$component->gen} | CL {$component->cl}";
    
            return $component;
        });
    
        return response()->json($components);
    }

    public function getSTORAGE(Request $request)
    {

        $components = Storage::all();
    
        $components = $components->map(function ($component) {
            $component->storageName = "{$component->brand} {$component->model}";
            
            $component->specs = "{$component->size} {$component->unit_size} | {$component->readspeed} | {$component->writespeed} | {$component->interface}";
    
            return $component;
        });
        
        return response()->json($components);
    } 

    public function getPSU(Request $request)
    {
        $components = PSU::all();
    
        $components = $components->map(function ($component) {
            $component->psuName = "{$component->brand} {$component->model} {$component->watts}";
            
            $component->specs = "{$component->watts} | {$component->rating}";
    
            return $component;
        });
        
        return response()->json($components);
    } 
}
