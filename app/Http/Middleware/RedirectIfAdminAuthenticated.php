<?php

namespace App\Http\Middleware;

use Closure;

//Auth Facade
use Auth;


class RedirectIfAdminAuthenticated
{

    public function handle($request, Closure $next)
    {
        //If request comes from logged in user, he will
        //be redirect to home page.
        if (Auth::guard()->check()) {
            return redirect('/home');
        }

        //If request comes from logged in admin, he will
        //be redirected to admin's home page.
        if (Auth::guard('admin')->check()) {
            return redirect('/admin/home');
        }

        return $next($request);
    }
}
