<?php

namespace Tests\Feature\Auth;

use App\Models\User;
use Illuminate\Auth\Notifications\ResetPassword;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Notification;
use Tests\TestCase;

class PasswordResetTest extends TestCase
{
    use RefreshDatabase;

<<<<<<< HEAD
    public function test_reset_password_link_screen_can_be_rendered(): void
    {
        $response = $this->get('/forgot-password');

        $response->assertStatus(200);
    }

=======
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
    public function test_reset_password_link_can_be_requested(): void
    {
        Notification::fake();

        $user = User::factory()->create();

        $this->post('/forgot-password', ['email' => $user->email]);

        Notification::assertSentTo($user, ResetPassword::class);
    }

<<<<<<< HEAD
    public function test_reset_password_screen_can_be_rendered(): void
    {
        Notification::fake();

        $user = User::factory()->create();

        $this->post('/forgot-password', ['email' => $user->email]);

        Notification::assertSentTo($user, ResetPassword::class, function ($notification) {
            $response = $this->get('/reset-password/'.$notification->token);

            $response->assertStatus(200);

            return true;
        });
    }

=======
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
    public function test_password_can_be_reset_with_valid_token(): void
    {
        Notification::fake();

        $user = User::factory()->create();

        $this->post('/forgot-password', ['email' => $user->email]);

<<<<<<< HEAD
        Notification::assertSentTo($user, ResetPassword::class, function ($notification) use ($user) {
=======
        Notification::assertSentTo($user, ResetPassword::class, function (object $notification) use ($user) {
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7
            $response = $this->post('/reset-password', [
                'token' => $notification->token,
                'email' => $user->email,
                'password' => 'password',
                'password_confirmation' => 'password',
            ]);

            $response
                ->assertSessionHasNoErrors()
<<<<<<< HEAD
                ->assertRedirect(route('login'));
=======
                ->assertStatus(200);
>>>>>>> 246fd81c10994b5f6e33909b93601f0cd96445b7

            return true;
        });
    }
}
