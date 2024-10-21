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
                'image_url' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            ]);
    
            // Handle image upload
            if ($request->hasFile('image_url')) {
                $imagePath = $request->file('image_url')->store('images/profile', 'public');
                $validatedData['image_url'] = 'storage/' . $imagePath; 
            }
    
            // Create the user build
            $userBuild = UserBuild::create($validatedData);
    
            return response()->json($userBuild, 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->validator->errors()], 422);
        } catch (\Exception $e) {
            \Log::error('Error storing user build: ' . $e->getMessage());
            return response()->json(['error' => 'Failed to create user build'], 500);
        }
    }



    public function index()
    {
        $user = auth()->user();
    
        $builds = UserBuild::with(['cpu', 'gpu', 'motherboard', 'ram', 'storage', 'psu'])
            ->where('user_id', $user->id)
            ->get();
    
        return response()->json($builds);
    }

    public function getBuildDetails($buildID)
    {
        try {
            $build = Build::with(['cpu', 'gpu', 'motherboard', 'ram', 'storage', 'psu'])->findOrFail($buildID);

            $buildDetails = [
                'id' => $build->id,
                'name' => $build->name,
                'image_url' => $build->image_url,
                'cpu' => $build->cpu->name,
                'gpu' => $build->gpu->name,
                'motherboard' => $build->motherboard->name,
                'ram' => $build->ram->name,
                'storage' => $build->storage->name,
                'psu' => $build->psu->name,
                'cpu_benchmark' => $build->cpu->benchmark,
                'gpu_benchmark' => $build->gpu->benchmark,
                //'date_created' => $build->created_at->toDateString(),
            ];

            return response()->json($buildDetails, 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to fetch build details', 'error' => $e->getMessage()], 500);
        }
    }

    public function destroy(int $id)
    {
        try {
            $build = UserBuild::findOrFail($id);
            $build->delete();
    
            return response()->json(['message' => 'Build deleted successfully'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to delete build', 'error' => $e->getMessage()], 500);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            $validatedData = $request->validate([
                'name' => 'nullable|string|max:255',
                'description' => 'nullable|string',
                'image_url' => 'nullable|url', 
            ]);

            // Find the build by its ID
            $build = UserBuild::findOrFail($id);

            if (isset($validatedData['name'])) {
                $build->name = $validatedData['name'];
            }

            if (isset($validatedData['description'])) {
                $build->description = $validatedData['description'];
            }

            if (isset($validatedData['image_url'])) {
                $build->image_url = $validatedData['image_url'];
            }

            $build->save();

            return response()->json(['message' => 'Build updated successfully', 'build' => $build], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Failed to update build', 'error' => $e->getMessage()], 500);
        }
    }

}

    
