<?php

use App\Http\Controllers\BuildController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ComponentController;
use App\Models\CPU;

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});

Route::get("/component/{name}/{id}", [ComponentController::class, "read"]);
Route::get("/build/{id}", [BuildController::class,"read"]);
Route::post("/component/gpu/{model}/{brand}/{vram}/{bus}/{clock}/{memclock}/{gddr}/{benchmark}/{tdp}",[ComponentController::class,"gpuPost"]);
Route::put("/component/gpu/{id}/{model}/{brand}/{vram}/{bus}/{clock}/{memclock}/{gddr}/{benchmark}/{tdp}",[ComponentController::class,"gpuPut"]);
Route::delete("/component/{componentName}/{id}",[ComponentController::class,"delete"]);