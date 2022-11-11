<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;

use App\Apps;

use Illuminate\Http\Request;

class AppsController extends Controller
{
    public function apps(Request $request)
    {
        return '{
            "aplications": [{
                    "name": "@ce/resume-me",
                    "package": "@ce/resume-me",
                    "activeWhen": "/",
                    "exact": true
                },
                {
                    "name": "@ce/pokedex",
                    "package": "@ce/pokedex",
                    "activeWhen": "/pokedex",
                    "exact": true
                }
            ]
        
        }';
    }


}
