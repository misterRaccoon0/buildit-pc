<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
<<<<<<< HEAD
=======
use Illuminate\Http\JsonResponse;
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;

class EmailVerificationNotificationController extends Controller
{
    /**
     * Send a new email verification notification.
     */
<<<<<<< HEAD
    public function store(Request $request): RedirectResponse
    {
        if ($request->user()->hasVerifiedEmail()) {
            return redirect()->intended(route('dashboard', absolute: false));
=======
    public function store(Request $request): JsonResponse|RedirectResponse
    {
        if ($request->user()->hasVerifiedEmail()) {
            return redirect()->intended('/dashboard');
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
        }

        $request->user()->sendEmailVerificationNotification();

<<<<<<< HEAD
        return back()->with('status', 'verification-link-sent');
=======
        return response()->json(['status' => 'verification-link-sent']);
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
    }
}
