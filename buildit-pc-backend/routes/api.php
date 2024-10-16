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

// route /token/*
Route::middleware('auth:sanctum')->prefix('/token')->group(function(){
    Route::get('/check',[TokenController::class, 'authenticate']);
    Route::post('/login',[TokenController::class, 'login']);

});
// route /user/*
Route::prefix('/user')->group(function(){
    Route::post('/register',[UserController::class]);
    Route::post('/login',[UserController::class, 'login']);
});

// route /admin/*
Route::prefix('/admin')->group(function(){

    Route::get("/component/{component_name}/{id}", [ComponentController::class, "read"]);
    Route::post("/component/{component_name}", [ComponentController::class,"store"]);
    Route::put("/component/{component_name}/{id}", [ComponentController::class, "update"]);
    Route::delete("/component/{component_name}/{id}",[ComponentController::class,"delete"]);
});

Route::get("/build/{url_hash}", [BuildController::class,"read"]);
