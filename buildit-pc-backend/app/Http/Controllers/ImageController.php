<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ImageController extends Controller
{
    public function upload(Request $request)
    {
        $request->validate([
            'image' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);
    
        if ($request->hasFile('image')) {
            try {
                $path = $request->file('image')->store('images', 'public');
                return response()->json([
                    'success' => true,
                    'path' => Storage::url($path),
                ], 200);
            } catch (\Exception $e) {
                return response()->json([
                    'success' => false,
                    'error' => 'File upload failed. Please try again.',
                    'details' => $e->getMessage(),
                ], 500);
            }
        }
    
        return response()->json(['success' => false, 'error' => 'No file uploaded.'], 400);
    }
}