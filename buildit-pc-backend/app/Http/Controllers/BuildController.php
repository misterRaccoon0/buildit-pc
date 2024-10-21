<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\UserBuild;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class BuildController extends Controller
{
    public function get(string $build_hash){
        // no isPublic constraint yet
        return UserBuild::where('build_hash', $build_hash)->first();
    }
    public function create(Request $request){
        $user = $request->user();

        $build = $request->validate([
            'cpu_id' => 'nullable|exists:cpu.id',
            'gpu_id' => 'nullable|exists:gpu.id',
            'psu_id' => 'nullable|exists:psu.id',
            'ram_id' => 'nullable|exists:ram.id',
            'motherboard_id' => 'nullable|exists:motherboard.id',
            'storage_id' => 'nullable|exists:storage_id'
        ]);
        $build['user_id'] = $user->id;
        $build_imp = implode('',$build);
        $build['build_hash'] = sha1($build_imp.((string)now()));
        while(UserBuild::where('build_hash', $build['build_hash'])->exists()){
            $build['build_hash'] = sha1($build_imp.(string)now().Str::random(5));
        }
        $build = UserBuild::create($build);
        $build->save();
        return ;
    }
    public function update(Request $request){
        $user = $request->user();
        $build = UserBuild::where('user_id', $user->id);
        if (!$build->exists())
            return response(['message' => 'build does not exist']);
        $build_update = $request->validate([
            'cpu_id' => 'nullable|exists:cpu.id',
            'gpu_id' => 'nullable|exists:gpu.id',
            'psu_id' => 'nullable|exists:psu.id',
            'ram_id' => 'nullable|exists:ram.id',
            'motherboard_id' => 'nullable|exists:motherboard.id',
            'storage_id' => 'nullable|exists:storage_id'
        ]);

        $build = $build->first();
        $build->update($build_update);
        $build->save();
        return ['updated build' => $build];
    }
    public function destroy(Request $request){
        $user = $request->user();
        $build = UserBuild::where('user_id', $user->id)->where('build_hash', $request->build_hash);
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
