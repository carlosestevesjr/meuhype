<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

//Logged in users/Admin cannot access or send requests these pages
Route::group(['prefix'=>'admin','middleware' => 'admin_guest'], function() {
    Route::group(['namespace' => 'AdminAuth'], function(){
        Route::get('login', 'LoginController@showLoginForm');
        Route::post('login', 'LoginController@login');

        //Password reset routes
        Route::get('password/reset', 'ForgotPasswordController@showLinkRequestForm');
        Route::post('password/email', 'ForgotPasswordController@sendResetLinkEmail');
        Route::get('password/reset/{token}', 'ResetPasswordController@showResetForm');
        Route::post('password/reset', 'ResetPasswordController@reset');
    });
});

//Only logged in admins can access or send requests to these pages
Route::group(['prefix'=>'admin','middleware'=>'admin_auth'], function(){
   
    Route::group(['namespace' => 'AdminAuth'], function(){
        Route::get('register', 'RegisterController@showRegistrationForm');
        Route::post('register', 'RegisterController@register');
        Route::post('logout', 'LoginController@logout');
    });

    Route::group(['namespace' => 'Admin'], function(){

        //Configurações
        Route::resource('configs', 'ConfigController');

        //Admin
        Route::resource('admins', 'AdminController');

        //Channels
        Route::resource('channels', 'ChannelsController');

        //News
        Route::resource('news', 'NewsController');
        Route::post('news-ajax-create', 'NewsController@storeAjax');

        //Podcasts
        Route::resource('podcasts', 'PodcastsController');
        
        //Tag
        Route::resource('tags', 'TagsCrawlerController');
        // Route::post('tag-blog-ajax-update', 'TagBlogController@postAjaxUpdate');
        // Route::post('tag-blog-ajax-delete', 'TagBlogController@postAjaxDelete');

        //Crawler
        Route::resource('crawler', 'CrawlerController');

        //Crawler Config
        Route::resource('crawler-configs', 'CrawlerConfigsController');

    });

    //Home
    Route::get('/home', function(){
        return view('admin.home');
    });

  

});