<?php

namespace App\Http\Controllers;

use App\Models\UserComment;
use Illuminate\Http\Request;

class CommentController extends Controller
{
    public function create(Request $request){
        $user = $request->user();
        $comment = UserComment::create();
        if(!$comment->exists())
            return response(["message"=>"comment does not exist"], 404);
        $comment->first()->delete();
        $comment->save();
        return [];

    }
    public function edit(Request $request){
        $user = $request->user();
        $comment = UserComment::where('user_id', $user->id)->where('id',$request->comment_id);
        if(!$comment->exists())
            return response(["message"=>"comment does not exist"], 404);
        $comment->update(["comment" => $request->comment);
        $comment->save();
        return [];

    }
    public function destroy(Request $request){
        $user = $request->user();
        $comment = UserComment::where('user_id', $user->id)->where('id',$request->comment_id);
        if(!$comment->exists())
            return response(["message"=>"comment does not exist"], 404);
        $comment->first()->delete();
        $comment->save();
        return [];
    }

}
