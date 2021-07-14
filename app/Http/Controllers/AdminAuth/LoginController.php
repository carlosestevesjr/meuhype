<?php

namespace App\Http\Controllers\AdminAuth;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

//Class needed for login and Logout logic
use Illuminate\Foundation\Auth\AuthenticatesUsers;

//Auth facade
use Auth;

class LoginController extends Controller
{
    //Where to redirect admin after login.
    protected $redirectTo = '/admin/home';
    
    //Trait
    use AuthenticatesUsers;
    
   /**
   * Create a new controller instance.
   *
   * @return void
   */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }


    //Custom guard for admin
    protected function guard()
    {
      return Auth::guard('admin');
    }

    //Shows admin login form
    public function showLoginForm()
    {
       return view('admin.auth.login');
    }

    
}
