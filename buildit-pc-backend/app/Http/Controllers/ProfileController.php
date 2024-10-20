<?php

namespace App\Http\Controllers;

use App\Http\Requests\ProfileUpdateRequest;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Illuminate\View\View;
use Illuminate\Http\JsonResponse;

class ProfileController extends Controller
{
    /**
     * Display the user's profile form.
     */
    public function edit(Request $request): View
    {
        return view('profile.edit', [
            'user' => $request->user(),
        ]);
    }

    /**
     * Update the user's profile information.
     */
    public function update(ProfileUpdateRequest $request): JsonResponse
    {
        // Retrieve the authenticated user
        $user = $request->user();
    
        // Update user's name and email from validated data
        $user->name = $request->input('name');   // Update name
        $user->email = $request->input('email'); // Update email
    
        // Check if the email has changed and reset email verification if necessary
        if ($user->isDirty('email')) {
            $user->email_verified_at = null; // Reset email verification if the email has changed
        }
    
        // Handle profile image upload if a new image is provided
        if ($request->hasFile('image')) {
            // Validate the uploaded image
            $request->validate([
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048', // Image validation
            ]);
    
            // Store the uploaded image and get its path
            $imagePath = $request->file('image')->store('images/profile', 'public');
            
            // Update the user's image_url with the new image path
            $user->image_url = 'storage/' . $imagePath; 
        }
    
        // Save the updated user information to the database
        $user->save();
    
        // Return a success response with the updated user information
        return response()->json(['message' => 'Profile updated successfully', 'user' => $user], 200);
    }
    /**
     * Delete the user's account.
     */
    public function destroy(Request $request): RedirectResponse
    {
        $request->validateWithBag('userDeletion', [
            'password' => ['required', 'current_password'],
        ]);

        $user = $request->user();

        Auth::logout();

        $user->delete();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return Redirect::to('/');
    }

    public function getProfile(Request $request)
    {
        if (!Auth::check()) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }
    
        return response()->json([
            'name' => Auth::user()->name,
            'email' => Auth::user()->email,
            'image_url' => Auth::user()->image_url,
        ]);
    }
}
