<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\UserBuild;
use Illuminate\Http\Request;

class BuildController extends Controller
{
    public function get(string $build_hash){
        return UserBuild::all()->where('build_hash', $build_hash)->first();
    }
    public function set(Request $request){
        return User::where('id',2)->first();
    }
    public function update(Request $request){
        $user = $request->user();
        $build = UserBuild::all()->where('user_id', $user->id);
        if (!$build->exists())
            return response(['message' => 'build does not exist']);
        $build_update = $request->validate([

        ]);

        $build = $build->first();
        $build->update($build_update);
        $build->save();
        return ['updated build'];
    }
    public function delete(Request $request){
        $user = $request->user();
        $build = UserBuild::all()->where('user_id', $user->id)->where('build_hash', $request->build_hash);
        if(!$build->exists())
            return response(['message' => 'build does not exist'], 404);

        $build->first()->delete();
        $build->save();
        return ['message' => 'build successfully deleted'];


    }
    public function setPublish(Request $request){
        $user = $request->user();
        $build = UserBuild::all()->where("user_id", $user->id)->where("build_hash",$request->build_hash);
        if(!$build->exists())
            return response(['message' => 'build does not exist'], 404);
        $build->update(['isPublic' => (boolean)$request->set_public]);
        $build->save();
        return ['message' => 'build '.($build->isPublic?'':'un').'published'];
    }
}
