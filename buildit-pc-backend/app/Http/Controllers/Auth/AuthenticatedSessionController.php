<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
<<<<<<< HEAD
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;
=======
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7

class AuthenticatedSessionController extends Controller
{
    /**
<<<<<<< HEAD
     * Display the login view.
     */
    public function create(): View
    {
        return view('auth.login');
    }

    /**
     * Handle an incoming authentication request.
     */
    public function store(LoginRequest $request): RedirectResponse
=======
     * Handle an incoming authentication request.
     */
    public function store(LoginRequest $request): Response
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
    {
        $request->authenticate();

        $request->session()->regenerate();

<<<<<<< HEAD
        return redirect()->intended(route('dashboard', absolute: false));
=======
        return response()->noContent();
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
    }

    /**
     * Destroy an authenticated session.
     */
<<<<<<< HEAD
    public function destroy(Request $request): RedirectResponse
=======
    public function destroy(Request $request): Response
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
    {
        Auth::guard('web')->logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

<<<<<<< HEAD
        return redirect('/');
=======
        return response()->noContent();
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
    }
}
