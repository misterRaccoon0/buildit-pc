<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    public function authenticate(Request $request){

        $credentials = $request->validate(
            [
                "email" => ["required", "email"],
                "password" ["required"]
            ]
        );

        if (Auth::attempt($credentials)){
            $request->session()->regenerate();
            return response("login ok", 200);
        }
        return response("login failed", 403);

    }
}
