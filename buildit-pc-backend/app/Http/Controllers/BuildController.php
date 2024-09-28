<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CPU;

class BuildController extends Controller
{
    public function read(int $id){
        return CPU::where("cpu_id", $id );
    }
    public function create(Request $req){
        $cpu = new CPU;
        $cpu->name = $req->name;
        $cpu->save();
        printf("test");
        return response("ok");
    }
    public function edit(int $id, string $name){
        if($name === null){

        }
    }
}
