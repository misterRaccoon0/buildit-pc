<?php

namespace App\Http\Controllers;

use App\Models\UserComment;
use Illuminate\Http\Request;

class CommentController extends Controller
{
    public function show(Request $request){
        $db_fetch = UserComment::where('url_hash', $request->url_hash);
        if(!$db_fetch->exists())
            return response()->json([], 404);
        $fetchLimit = $request->validate([
            'initial' => 'nullable|integer',
            'limit' => 'required|integer'
        ]);
        $fetchLimit['initial'] ??= 0;
        $db_fetch = UserComment::all()->range($fetchLimit['initial'], $fetchLimit['initial'] + $fetchLimit['limit']);
        return $db_fetch;
    }
    public function create(Request $request){
        $comment_arr = $request->vaidate([
            'url_hash' => 'required',
            'content' => 'required'
        ]);
        $comment_arr['user_id'] = $request->user()->id;
        $comment = UserComment::create($comment_arr);
        $comment->save();
        return ['message' => 'comment posted.'];

    }
    public function edit(Request $request){
        $user = $request->user();
        $comment = UserComment::where('user_id', $user->id)->where('id',$request->comment_id);
        if(!$comment->exists())
            return response()->json(["message"=>"comment does not exist"], 404);
        $comment->update(["content" => $request->comment]);
        $comment->save();
        return [];

    }
    public function destroy(Request $request){
        $user = $request->user();
        $comment = UserComment::where('user_id', $user->id)->where('id',$request->comment_id);
        if(!$comment->exists())
            return response()->json(["message"=>"comment does not exist"], 404);
        $comment->first()->delete();
        $comment->save();
        return [];
    }

}
