
<nav id="sidebar" class="sidebar">
    <div class="sidebar-content js-simplebar">
        <a class="sidebar-brand" href="index.html">
            <span class="align-middle">{{ $site_name }}</span>
        </a>
        <ul class="sidebar-nav">
            <!-- <li class="sidebar-header">
                Pages
            </li> -->
            <li class="sidebar-item <?php
                                        if(!empty($page_dados)){

                                            if(
                                                $page_dados["route_view"] == 'home'
                                            )
                                                { echo 'active' ;}
                                        }
                                        ?>">
                <a class="sidebar-link" href="{{ url($prefix_admin.'/home') }}">
                    <i class="align-middle" data-feather="sliders"></i> <span class="align-middle">Dashboard</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="#ui" data-toggle="collapse" class="sidebar-link collapsed">
                    <i class="align-middle" data-feather="clipboard"></i> <span class="align-middle">Crawler</span>
                </a>
            </li>
            <li>
                <ul id="ui" class="sidebar-dropdown list-unstyled collapse " data-parent="#sidebar">
                    <li class="sidebar-item"><a class="sidebar-link" href="{{ url($prefix_admin.'/crawler') }}">Crawler</a></li>
                    <li class="sidebar-item"><a class="sidebar-link" href="{{ url($prefix_admin.'/crawler-configs/1/edit') }}">Config Configurações</a></li>
                </ul>
            </li>
            <li class="sidebar-item">
                <a href="#ui" data-toggle="collapse" class="sidebar-link collapsed">
                    <i class="align-middle" data-feather="clipboard"></i> <span class="align-middle">Posts</span>
                </a>
            </li>
            <li>
                <ul id="ui" class="sidebar-dropdown list-unstyled collapse " data-parent="#sidebar">
                    <li class="sidebar-item"><a class="sidebar-link" href="{{ url($prefix_admin.'/news') }}">News</a></li>
                    <li class="sidebar-item"><a class="sidebar-link" href="{{ url($prefix_admin.'/podcasts') }}">Podcasts</a></li>
                    <li class="sidebar-item"><a class="sidebar-link" href="{{ url($prefix_admin.'/tags') }}">Tags</a></li>
                    <li class="sidebar-item"><a class="sidebar-link" href="{{ url($prefix_admin.'/channels') }}">Canais</a></li>
                </ul>
            </li>
            <li class="sidebar-item">
                <a href="#ui2" data-toggle="collapse" class="sidebar-link collapsed">
                    <i class="align-middle" data-feather="user"></i> <span class="align-middle">Adiministrativo</span>
                </a>
            </li>
            <li>
                <ul id="ui2" class="sidebar-dropdown list-unstyled collapse " data-parent="#sidebar">
                    <li class="sidebar-item"><a class="sidebar-link" href="{{ url($prefix_admin.'/admins') }}">Admin</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
