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

        // Protected APIToken Middleware
        Route::group(['middleware'=>'APIToken'], function () {
            // Logout
            Route::get('lista-news/{id?}','NewsController@listaNews');
        });

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

        //Apps
        Route::get('apps','AppsController@apps');

        //Contato
        Route::post('contato','ContactController@contato');

        //Tags 
        Route::get('tag-single/{tag_id}','TagsController@tagSingle');
        Route::get('lista-tags','TagsController@listaTags');
        Route::get('lista-tags-search','TagsController@listaTagsSearch');

        
        Route::get('lista-tags-recentes','TagsController@listaTagsRecentes');

        Route::get('lista-tags-user/{token}','TagsController@listaTagsUser');
        Route::post('set-tag/','TagsController@postSetTag');
        Route::post('unset-tag/','TagsController@postUnsetTag');
        
        //Canais 
        Route::get('channel-single/{channel_id}','ChannelController@channelSingle');
        Route::get('lista-channels-search','ChannelController@listaChannelsSearch');
        Route::get('lista-channels','ChannelController@listaChannels');
        
        Route::get('lista-canais-user/{token}','ChannelController@listaCanaisUser');
        Route::post('set-canal/','ChannelController@postSetCanal');
        Route::post('unset-canal/','ChannelController@postUnsetCanal');
        
        //News
        Route::get('lista-news-search','NewsController@listaNewsSearch');
        Route::get('lista-news-tag/{tag_id}','NewsController@listaNewsTag');
        Route::get('lista-news-channel/{channel_id}','NewsController@listaNewsChannel');
        
        Route::get('lista-news-user/{token}','NewsController@listaNewsUser');
        Route::get('lista-news-channel-user/{id}/{token}','NewsController@listaNewsChannelUser');

        Route::get('cronjob','CronJobController@index');
        Route::get('cronjob/resize','CronJobController@resize');
        Route::get('cronjob/{channel_id}/{}','CronJobController@index');
    });

});

