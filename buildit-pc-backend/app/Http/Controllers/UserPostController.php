<?php

namespace App\Http\Controllers;

use App\Models\UserPost;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

class UserPostController extends Controller
{
    private static $sort_cols = [
        'popularity' => function($table){return $table->sortBy('views');},
        'dateNew' => function($table){return $table->sortBy('date');},
        'dateOld' => function($table){ return $table->sortBy('date');},
        'trend' => function(Model $table){return $table->sortBy('date')->sortBy('views');}
    ];

    public function fetchAll(Request $request){
        $params = $request->validate([
            'sort_by' => 'required',
            'initial' => 'nullable|integer',
            'limit' => 'required|integer'
        ]);
        $params['initial'] ??= 0;

        $sort_func = UserPostController::$sort_cols[$params['sort_by']] ?? UserPostController::$sort_cols['popularity'];

        $fetch = $sort_func(UserPost::all())->range($params['initial'], $params['initial'] + $params['limit']);

        return $fetch;


    }
    public function get(string $url_hash){
        $post = UserPost::where('url_hash', $url_hash);
        if(!$post->exists())
            return response()->json(['message' => 'post does not exist'], 404);
    }
    public function save(Request $request){

    }
    public function rate(Request $request){

    }
    public function delete(Request $request){

    }
}
