<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
class UserController extends Controller
{
    public function login(Request $request){
        $user = $request->validate([
            "name" => ["required"],
            "password" ["required"]
        ]);
        $user = User::all()->where('name',$user['name']);
        if(!$user->exists())
            return response(['message' => 'user does not exist'],404);
        $token = $user->first()->createToken($request->userAgent."_token");
        return [
            "user" => $user,
            "token" => $token->plainTextToken
        ];
    }
    public function register(Request $request){
        $user = $request->validate([
            "name" => ['required'],
            'email' => ['required', 'email'],
            'password' => ['required']
        ]);
        if(User::all()->where("email", $user['email'])->exists()){
            return response("Email already taken", 400);
        }
        $user['password'] = Hash::make($user['password']);
        $user = User::factory()->create($user);
        $token = $request->user()->createToken($request->name);
        return ["token" => $token->plainTextToken];
    }
}
