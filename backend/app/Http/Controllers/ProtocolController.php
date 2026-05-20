<?php

namespace App\Http\Controllers;

use App\Models\Protocol;
use Illuminate\Http\Request;

class ProtocolController extends Controller
{
    public function index()
    {
        $protocols = Protocol::all();
        return response()->json($protocols);
    }
}