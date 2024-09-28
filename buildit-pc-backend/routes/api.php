<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\BuildController;
use App\Models\CPU;

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});
Route::get("/build/{id}", [BuildController::class, "read"]);
Route::post("/build/{name}",function (Request $req){
    $cpu = new CPU;
    $cpu->name = $req->name;
    $cpu->save();
    return response("OK");
});
