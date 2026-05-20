<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProtocolController; // <-- Import your controller here

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// Keep your old test route if it's there, and add this right under it:
Route::get('/test-message', function () {
    return response()->json(['message' => 'Hello from your Laravel Docker backend!']);
});

// This opens up the live URL pipeline: http://localhost/api/protocols
Route::get('/protocols', [ProtocolController::class, 'index']);