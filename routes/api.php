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

    Route::group(['namespace'=> 'AuthAPI'], function () {
        //Token Notification
        Route::post('set-token-push','AuthController@setTokenPush');
    });

    Route::group(['namespace'=> 'API'], function () {
        
        //Contato
        Route::post('contato','ContactController@contato');

        //Tags 
        Route::get('lista-tags/{busca?}','TagsController@listaTags');

        
        Route::get('lista-tags-recentes','TagsController@listaTagsRecentes');

        Route::get('lista-tags-user/{token}','TagsController@listaTagsUser');
        Route::post('set-tag/','TagsController@postSetTag');
        Route::post('unset-tag/','TagsController@postUnsetTag');
        
        //Canais 
        Route::get('lista-canais/{busca?}','ChannelController@listaCanais');
        
        Route::get('lista-canais-user/{token}','ChannelController@listaCanaisUser');
        Route::post('set-canal/','ChannelController@postSetCanal');
        Route::post('unset-canal/','ChannelController@postUnsetCanal');
        
        //News
        Route::get('lista-news/{id?}','NewsController@listaNews');
        Route::post('lista-news-search','NewsController@listaNewsSearch');
        Route::get('lista-news-user/{token}','NewsController@listaNewsUser');
        Route::get('lista-news-tag-user/{id}/{token}','NewsController@listaNewsTagUser');
        Route::get('lista-news-channel-user/{id}/{token}','NewsController@listaNewsChannelUser');

        Route::resources([
            'cronjob' => 'CronJobController',
        ]);
    });

});

