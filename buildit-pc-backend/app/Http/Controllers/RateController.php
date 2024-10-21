<?php

namespace App\Http\Controllers;

use App\Models\UserPost;
use App\Models\UserRate;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class RateController extends Controller
{
    public function setRate(string $url_hash, float $rate){
        $user_post = UserPost::where('url_hash', $url_hash);
        if(!$user_post->exists())
            return response(['message' => 'post not found'], 404);
        $user = Auth::user();
        if(!$user_post->isPublic){
            return response(['message' => 'post is private.'], 403);
        }
        $user_rate = UserRate::where('user_id',$user->id)->where('url_hash', $url_hash);
        if(!$user_rate->exist()){
            $user_rate = UserRate::create([
                'user_id' => $user->id,
                'url_hash' => $url_hash,
                'rate' => $rate
            ]);
            $user_rate->save();
           return [];
        }
        $user_rate->first()->update(['rate' => $rate]);
        return [];
    }
    public function getRate(string $url_hash){
        return [];
    }
}
