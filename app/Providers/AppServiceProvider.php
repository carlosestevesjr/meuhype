<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

use Illuminate\Support\Facades\View;
use Illuminate\Support\Facades\URL;
use Illuminate\Pagination\Paginator;

use App\Config;
use Throwable;

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
        if ($this->app->environment('production')) {
            URL::forceRootUrl(config('app.url'));
            URL::forceScheme('https');
        }

        Paginator::useBootstrap();

        View::share('prefix_admin', 'admin');

        $color = 'custom';
        $title = 'Site';
        $configSite = null;

        try {
            $config = Config::get();

            if (count($config) > 0) {
                $config = $config->first();
                $color = $config->color_painel;
                $title = $config->title;
            }

            // Itens das configurações
            $configSite = Config::find(1);
        } catch (Throwable $exception) {
            //
        }

        View::share('config_color', $color );
        View::share('site_name', $title );
        View::share('config_site', $configSite );
    }
}
