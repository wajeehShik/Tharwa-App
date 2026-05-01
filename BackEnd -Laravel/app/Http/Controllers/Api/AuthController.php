<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{public function login(Request $request)
{
    $fields = $request->validate([
        'email' => 'required|string|email',
        'password' => 'required|string'
    ]);

    $user = User::where('email', $fields['email'])->first();

    if (!$user || !Hash::check($fields['password'], $user->password)) {
        return response([
            'message' => 'بيانات تسجيل الدخول غير صحيحة'
        ], 401);
    }
    $token = $user->createToken('myapptoken')->plainTextToken;
    return response([
        'user' => $user,
        'token' => $token
    ], 201);
}
}
