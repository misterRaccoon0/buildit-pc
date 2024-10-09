<?php

namespace App\Http\Controllers;

use App\Models\User;
use Hash;
use Illuminate\Hashing\BcryptHasher;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Str;
class UserController extends Controller
{
    public function authenticate(Request $request){
        $json_body = $request->json()->all();
        $user = User::where("email", $json_body["email"]);
        if(!$user->exists())
            return response("Account does not exist",404);

        if(Hash::check($json_body["password"],$user->first()->password)){
            return response("OK",200);
        }

        return response("login failed", 403);
    }
    public function store(Request $request){
        $json_body = $request->json()->all();
        if(User::where("email", $json_body["email"])->exists()){
            return response("Email already taken", 400);
        }
        $user = User::factory()->create(["name"=>$json_body["name"],"email"=>$json_body["email"],"password"=>Hash::make($json_body["password"])]);
        return response("ok");
        $token = $request->user()->createToken($request->name);
        return ["token" => $token->plainTextToken];
    }
}
