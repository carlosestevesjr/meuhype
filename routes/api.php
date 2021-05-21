<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::group(['prefix' => 'v1', 'middleware' => ['cors']], function () {
    
    Route::group(['namespace'=>'AuthAPI'], function () {
        // Register
        Route::post('/register','AuthController@postRegister');

        // Login
        Route::post('/login','AuthController@postLogin');
     
        // Protected APIToken Middleware
        Route::group(['middleware'=>'APIToken'], function () {
            // Logout
            Route::post('/logout','AuthController@postLogout');
        });
    });
    
    Route::group(['namespace'=> 'API','middleware'=>'APIToken'], function () {

        // Route::resources([
        //     'movies' => 'MovieController',
        //     'news' => 'NewsController',
        //     'channels' => 'ChannelController',
        //     'actors' => 'ActorController',
        //     'trailers' => 'TrailerController',
        // ]);
       
    });

    Route::group(['namespace'=> 'API'], function () {

        //Tags 
        Route::get('lista-tags-crawler/{busca?}','TagsCrawlerController@listaTagsCrawler');

        //Canais 
        Route::get('lista-canais/{busca?}','ChannelController@ListaCanais');

        //News
        Route::get('lista-news/{id?}','NewsController@ListaNews');

        Route::resources([
            'cronjob' => 'CronJobController',
        ]);
    });

});

