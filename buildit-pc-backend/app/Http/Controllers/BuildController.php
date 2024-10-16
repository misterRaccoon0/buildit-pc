<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\UserBuild;
use Illuminate\Http\Request;
use App\Models\CPU;
use App\Models\User;

class BuildController extends Controller
{
    public function read(int $id){

    }
    public function create(Request $request){

    }
    public function update(Request $request){

    }
    public function delete(int $id){

    }
    public function setPublish(Request $request){
        $user = $request->user();
        $build = UserBuild::where("user_id", $user->id)->where("build_hash",$request->build_hash);
        if($build->exists()){

        }
    }
}
