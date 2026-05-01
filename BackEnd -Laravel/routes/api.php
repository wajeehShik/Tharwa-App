<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\DebtController;
use App\Http\Controllers\Api\ExpenseController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('/login', [AuthController::class, 'login']);


Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('expenses', ExpenseController::class);
    Route::apiResource('debts', DebtController::class);
    Route::post('debts/{debt}/payments', [DebtController::class, 'addPayment']);
    Route::get('debts/{debt}/payments', [DebtController::class, 'getPayments']);
    
});