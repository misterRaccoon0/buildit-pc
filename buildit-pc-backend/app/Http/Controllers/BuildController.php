<?php

namespace App\Http\Controllers;

use App\Models\UserBuild;
use Illuminate\Http\Request;
use App\Models\CPU;

class BuildController extends Controller
{
    public function read(int $id){

        $build = UserBuild::find ($id);

        if (!$build) { 
            return response()->json(['message' => 'Build not found'], 404);
        }

        return response()->json($build);;
    }

    public function store(Request $request)
    {
        try {
            $validatedData = $request->validate([
                'cpu' => 'required|exists:cpus,id',
                'gpu' => 'required|exists:gpus,id',
                'motherboard' => 'required|exists:motherboards,id',
                'ram' => 'required|exists:rams,id',
                'storage' => 'required|exists:storages,id',
                'psu' => 'required|exists:psus,id',
                'user_id' => 'required|exists:users,id',
                'name' => 'required|string|max:255',
                'description' => 'nullable|string',
                'total_tdp' => 'nullable|numeric',
                'total_price' => 'nullable|numeric',
                'benchmarkScore' => 'nullable|numeric',
            ]);
    
            $userBuild = UserBuild::create($validatedData);
    
            return response()->json($userBuild, 201);
        } catch (\Exception $e) {
            \Log::error('Error storing user build: '.$e->getMessage());
            return response()->json(['error' => 'Failed to create user build'], 500);
        }
    }


    public function index()
    {
        $user = auth()->user();
        $builds = UserBuild::where('user_id', $user->id)->get();

        return response()->json($builds);
    }
}

    
