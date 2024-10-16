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
        $user = $request->user();
        $token = $user->createToken(Str::random(10));
        return ["token" => $token->plainTextToken];
    }
    public function check(Request $request)
    {
        return $request->user();
    }
    public function login(Request $request){
        $user = $request->user();
        Auth::login($user,$user->remember_token);
        return $request->user();
    }
    public function destroy(Request $request)
    {
        Auth::logout($request->user());
        return ['message' => 'logged out successfully'];
    }
}
