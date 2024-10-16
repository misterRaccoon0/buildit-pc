<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class TokenController extends Controller
{

    public function refresh(Request $request)
    {
        // unfinished
        $user = $request->user();
        $token = $user->createToken(Str::random(10));
        return ["token" => $token->plainTextToken];
    }
    public function authenticate(Request $request)
    {
        return $request->user();
    }

    public function register(Request $request){
        if(User::where('email',$request->email)->exists())
            return ['message' => 'user already exist.'];
        $json_body = $request->json()->all();
        $user = User::factory()->create([
            'name' => $json_body['name'],
            'email' => $json_body['email'],
            'password' => Hash::make($json_body['password'])
        ]);
        $token = $user->createToken($request->name."_token");
        return [
            'token' => $token->plainTextToken
        ];
    }
    public function login(Request $request){
        $user = $request->user();
        Auth::login($user,$user->remember_token);
        return $request->user();
    }
    public function logout(Request $request)
    {
        Auth::logout($request->user());
        return ['message' => 'logged out successfully'];
    }
}
