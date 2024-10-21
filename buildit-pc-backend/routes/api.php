<?php

use App\Http\Controllers\BuildController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UserPostController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ComponentController;
use App\Http\Controllers\TokenController;

//Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
//    return $request->user();
//});


// guarded route
Route::middleware('auth:sanctum')->group(function(){
    // route /token/*
    Route::prefix('/token')->group(function(){
        Route::get('/check',[TokenController::class, 'authenticate']);
        Route::post('/login',[TokenController::class, 'login']);
        Route::post('/logout',[TokenController::class, 'logout']);
        Route::get('/refresh',[TokenController::class, 'refresh']);
    });

    // Route /build/*
    Route::prefix('/build')->group(function(){
        Route::get("/{build_hash}", [BuildController::class,"get"]);
        Route::post('/', [BuildController::class, 'create']);
        Route::put('/',[BuildController::class, 'update']);
        Route::put('/publish',[BuildController::class,'setPublish']);
        Route::delete('/',[BuildController::class, 'destroy']);
    });

});
// route /user/*
Route::prefix('/user')->group(function(){
    Route::post('/register',[UserController::class]);
    Route::post('/login',[UserController::class, 'login']);
});


// route /post/*
Route::prefix('/post')->group(function(){
    Route::get('/',[UserPostController::class, 'get']);
    Route::post('/rate', [UserPostController::class, 'rate']);

    // route /post/comment/*
    Route::prefix('/comment')->group(function(){

        Route::get('/', [CommentController::class, 'getComment']);
        // guarded route
        Route::middleware('auth:sanctum')->group(function(){
            Route::post('/',[CommentController::class, 'comment']);
            Route::put('/',[CommentController::class, 'update']);
            Route::delete('/',[CommentController::class, 'destroy']);
        });
    });
});



// route /component/*
Route::prefix('/component')->group(function(){
    Route::get(
        "/{component_name}/{id}",
        [ComponentController::class, "read"]
    );
    Route::get('/motherboard/support', []);
});

// route /admin/*
Route::prefix('/admin')->group(function(){
    // route /admin/component/*
    Route::prefix('/component')->group(function(){
        Route::post(
            "/{component_name}",
            [ComponentController::class,"store"]
        );
        Route::put(
            "/{component_name}/{id}",
            [ComponentController::class, "update"]
        );
        Route::delete(
            "/{component_name}/{id}",
            [ComponentController::class,"delete"]
        );
    });
});






