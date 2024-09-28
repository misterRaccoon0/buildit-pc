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
        DB::query("SELECT * FROM c_p_u_s")->where("id", (int)$request->id);
        return response($componentClass,202);
    }

}
