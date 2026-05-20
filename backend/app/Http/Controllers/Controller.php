<?php

namespace App\Http\Controllers;

use App\Models\Protocol;
use Illuminate\Http\Request;

class ProtocolController extends Controller
{
    /**
     * Get a list of all active TACRU emergency protocols.
     */
    public function index()
    {
        // Fetch all protocol records directly out of our MySQL container
        $protocols = Protocol::all();

        // Send them straight to the network stream as an organized JSON response
        return response()->json($protocols);
    }
}