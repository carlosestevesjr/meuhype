<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'MultiAuth') }}</title>

    <meta name="description" content="">

    <!-- Styles -->
    <!-- <link href="{{ asset('/css/app.css') }}" rel="stylesheet"> -->
    <link href="{{ asset('css/modular-admin-html-1.1.0/dist/css/vendor.css') }}" rel="stylesheet">
    <link href="{{ asset('css/modular-admin-html-1.1.0/dist/css/app-'.$config_color.'.css') }}" rel="stylesheet">

    <link href="{{ asset('/css/styles-admin.css') }}" rel="stylesheet">

    <!-- Scripts -->
    <script>
        window.Laravel = <?php echo json_encode([
            'csrfToken' => csrf_token(),
        ]); ?>
    </script>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="auth">
                <div class="auth-container">
                    <div class="card">
                        <header class="auth-header">
                            <h1 class="auth-title">
                                <div class="logo">
                                    <span class="l l1"></span>
                                    <span class="l l2"></span>
                                    <span class="l l3"></span>
                                    <span class="l l4"></span>
                                    <span class="l l5"></span>
                                </div>
                                PAINEL ADMIN
                            </h1>
                        </header>
                        <div class="auth-content">
                            <p class="text-xs-center">LOGIN PARA CONTINUAR</p>
                            <form id="login-form" role="form" method="POST" action="{{ url($prefix_admin.'/login') }}">
                                <div class="form-group{{ $errors->has('email') ? ' has-error' : '' }}">
                                    <label for="username">E-mail</label>
                                    <input id="email" type="email" class="form-control underlined" name="email" value="{{ old('email') }}" required autofocus>
                                    @if ($errors->has('email'))
                                        <span class="alert" role="alert" style="font-size:10px;">
                                            <strong>{{ $errors->first('email') }}</strong>
                                        </span>
                                    @endif
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input id="password" type="password" class="form-control underlined" name="password" required>
                                    @if ($errors->has('password'))
                                        <span class="alert" role="alert" style="font-size:10px;">
                                            <strong>{{ $errors->first('password') }}</strong>
                                        </span>
                                    @endif
                                </div>
                                <div class="form-group">
                                    <!-- <label for="remember">
                                        <input class="checkbox" id="remember" type="checkbox">
                                        <span>Remember me</span>
                                    </label> -->
                                    <a href="{{ url($prefix_admin.'/password/reset') }}" class="forgot-btn pull-left">Esqueceu sua senha?</a>
                                </div>
                                <div class="form-group">
                                    {{ csrf_field() }}
                                    <button type="submit" class="btn btn-block btn-primary">Login</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="text-xs-center">
                        <a href="{{ url('/') }}" class="btn btn-secondary rounded btn-sm">
                            <i class="fa fa-arrow-left"></i> voltar ao site
                        </a>
                    </div>
                </div>
            </div>
            <!-- Reference block for JS -->
            <div class="ref" id="ref">
                <div class="color-primary"></div>
                <div class="chart">
                    <div class="color-primary"></div>
                    <div class="color-secondary"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <!-- <script src="/js/app.js"></script> -->
    <script src="{{ asset('/js/jquery-3.2.1.min.js') }}"></script>
    <script src="{{ asset('admin/modular-admin-html-1.1.0/dist/js/vendor.js') }}"></script>
    <script src="{{ asset('admin/modular-admin-html-1.1.0/dist/js/app.js') }}"></script>
</body>
</html>
