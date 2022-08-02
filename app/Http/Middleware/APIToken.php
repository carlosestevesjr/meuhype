<?php

namespace App\Http\Middleware;

use Closure;
use DB;

use App\User;

class APIToken
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        return $next($request);
        // if($request->header('AuthorizationApi')){
        //     $user = DB::table('users')->where('api_token', '=', $request->header('AuthorizationApi'))->first();
            
        //     if($user){
        //         return $next($request);
        //     }else{
               
        //         $retorno =  [
        //             'code'  => '999',
        //             'content' => [
        //                             'message' => 'Token não exite.',
        //                         ],
        //             'date'         => date("Y-m-d"),
        //             'hour'         => date("H:i:s"),
        //         ];
        //         return response()->json($retorno , 200);
        //     }
            
        // }else{
            
        //     $retorno =  [
        //         'code'  => '999',
        //         'content' => [
        //                         'message' => 'Token não exite.',
        //                     ],
        //         'date'         => date("Y-m-d"),
        //         'hour'         => date("H:i:s"),
        //     ];
        //     return response()->json($retorno , 200);
        // }
    }
}
