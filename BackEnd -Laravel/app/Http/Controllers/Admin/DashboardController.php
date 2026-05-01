<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index(){
        $users=User::select('id')->count();
    return view('dashboard',compact("users"));
    }
}


/***
 * ديون  dept
 * مصاريف  expencive
 * ادخار    saving
 */