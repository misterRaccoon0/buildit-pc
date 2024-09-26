<?php

<<<<<<< HEAD
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
=======
use App\Http\Controllers\BuildController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ComponentController;
use App\Models\CPU;
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});
<<<<<<< HEAD
=======

Route::get("/component/{component_name}/{id}", [ComponentController::class, "read"]);
Route::get("/build/{id}", [BuildController::class,"read"]);
Route::post("/component/{component_name}", [ComponentController::class,"store"]);
Route::put("/component/{component_name}/{id}", [ComponentController::class, "update"]);
Route::delete("/component/{component_name}/{id}",[ComponentController::class,"delete"]);
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
