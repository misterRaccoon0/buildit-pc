<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Hash;
class TokenController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $token = $request->user()->createToken(Str::random(10));
        return ["token" => $token->plainTextToken];
    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request)
    {

        return $request->user();
    }

    public function register(Request $request){
        if(User::where('email',$request->email)->exists())return ['message' => 'user already exist.'];
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
        return $request->user();
    }


    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
