<?php

use App\Http\Controllers\BuildController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\ProfileController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ComponentController;
use App\Http\Controllers\TokenController;

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});


Route::middleware('auth:sanctum')->group(function () {
    Route::get('/profile', [ProfileController::class, 'getProfile']);
    Route::post('/profile/update', [ProfileController::class, 'update']);  
});


Route::post("/token/register",[TokenController::class,'register']);
Route::middleware("auth:sanctum")->get("/token/login",[TokenController::class,'login']);

Route::post("/user/login",[UserController::class,"authenticate"]);
Route::post("/user/register",[UserController::class,"store"]);

Route::get("/component/{component_name}/{id}", [ComponentController::class, "read"]);

Route::middleware('auth:sanctum')->group(function () {
    Route::get("/component/cpu", [ComponentController::class, "getCPU"]);
    Route::get("/component/gpu", [ComponentController::class, "getGPU"]);
    Route::get("/component/mobo", [ComponentController::class, "getMOBO"]);
    Route::get("/component/ram", [ComponentController::class, "getRAM"]);
    Route::get("/component/storage", [ComponentController::class, "getSTORAGE"]);
    Route::get("/component/psu", [ComponentController::class, "getPSU"]);
});

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/builds/index', [BuildController::class, 'index']); 
    Route::post('/builds/create', [BuildController::class, 'store']); 
    Route::get('/builds/{id}', [BuildController::class, 'read']);
    Route::delete('/builds/delete/{id}', [BuildController::class, 'destroy']);
    Route::put('/builds/edit/{id}', [BuildController::class, 'update']);

    //Route::get('builds/{buildID}/storage', [BuildController::class, 'getStorageSpecs']);
});

Route::post('/upload', [ImageUploadController::class, 'upload']);


Route::get("/build/{id}", [BuildController::class,"read"]);

Route::post("/component/{component_name}", [ComponentController::class,"store"]);
Route::put("/component/{component_name}/{id}", [ComponentController::class, "update"]);
Route::delete("/component/{component_name}/{id}",[ComponentController::class,"delete"]);


