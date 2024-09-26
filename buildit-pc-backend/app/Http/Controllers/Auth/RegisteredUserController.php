<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Auth\Events\Registered;
<<<<<<< HEAD
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;
use Illuminate\View\View;
=======
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7

class RegisteredUserController extends Controller
{
    /**
<<<<<<< HEAD
     * Display the registration view.
     */
    public function create(): View
    {
        return view('auth.register');
    }

    /**
=======
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
     * Handle an incoming registration request.
     *
     * @throws \Illuminate\Validation\ValidationException
     */
<<<<<<< HEAD
    public function store(Request $request): RedirectResponse
=======
    public function store(Request $request): Response
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
    {
        $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'lowercase', 'email', 'max:255', 'unique:'.User::class],
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
<<<<<<< HEAD
            'password' => Hash::make($request->password),
=======
            'password' => Hash::make($request->string('password')),
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
        ]);

        event(new Registered($user));

        Auth::login($user);

<<<<<<< HEAD
        return redirect(route('dashboard', absolute: false));
=======
        return response()->noContent();
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
    }
}
