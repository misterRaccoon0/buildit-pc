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
        $component = $componentClass::find($request->id);
        if (!$component->exists())
            return response("Component not found", 404);
        $component->update($request->json()->all());
        return response($component->first()->toJson(),200);
    }
}
