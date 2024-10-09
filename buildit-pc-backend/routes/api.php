<?php

use App\Http\Controllers\BuildController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ComponentController;
use App\Http\Controllers\TokenController;

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});


Route::middleware(["auth:sanctum"])->get("/token",[TokenController::class,"show"]);
Route::post("/token/create", [TokenController::class, "store"]);
Route::get("/user/login",[UserController::class,"authenticate"]);
Route::post("/user/register",[UserController::class,"store"]);

Route::get("/component/{component_name}/{id}", [ComponentController::class, "read"]);
Route::get("/build/{id}", [BuildController::class,"read"]);
Route::post("/component/{component_name}", [ComponentController::class,"store"]);
Route::put("/component/{component_name}/{id}", [ComponentController::class, "update"]);
Route::delete("/component/{component_name}/{id}",[ComponentController::class,"delete"]);


