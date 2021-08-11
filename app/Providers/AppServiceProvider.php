<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

use Illuminate\Support\Facades\View;

use App\Config;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        View::share('prefix_admin', 'admin');

        $config = Config::get();

        if(count($config) > 0){
            $config = $config->first();
            $color = $config->color_painel;
            $title = $config->title;
        }else{
            $color = 'custom';
            $title = 'Site';
        }

        View::share('config_color', $color );
        View::share('site_name', $title );

        //Itens das configurações
        $config = Config::find(1);
        View::share('config_site', $config );
    }
}
