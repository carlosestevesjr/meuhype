@extends('admin.layouts')

@section('content')

<h1 class="h3 mb-3">{{ $page_dados["title"] }}</h1>
<p class="title-description">{{ $page_dados["description"] }}</p>

@if(Session::has('message'))
    <div class="alert alert-success alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">×</span>
        </button>
        <div class="alert-icon">
            <i class="far fa-fw fa-bell"></i>
        </div>
        <div class="alert-message">
            <strong>{{ Session::get('message') }}</strong>
        </div>
    </div>
@endif

@if(Session::has('message_error'))
    <div class="alert alert-danger alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">×</span>
        </button>
        <div class="alert-icon">
            <i class="far fa-fw fa-bell"></i>
        </div>
        <div class="alert-message">
            <strong>{{ Session::get('message_error') }}</strong>
        </div>
    </div>
@endif

<div class="message-ajax"></div>

<div class="container-fluid p-0">
    <div class="row">
        <div class="col-12 col-xl-12">
            <div class="p-2">
                <a href="{{ URL::asset($prefix_admin.'/'.$page_dados['route_controler'].'/create') }}" class="btn btn-primary ">
                    Novo Registro
                </a>
                <form method="get" action="{{ route('tags.crawler-imdb') }}" target="_blank" class="form-inline d-inline-flex ml-2">
                    <label for="imdb-limit" class="sr-only">Quantidade de novas tags</label>
                    <input id="imdb-limit" type="number" name="limit" value="30" min="1" max="100" class="form-control mr-1" style="width:90px;" title="Quantidade de novas tags">
                    <button type="submit" class="btn btn-success" title="Importar filmes e séries populares do IMDb">
                        <i class="fas fa-cloud-download-alt"></i> Importar do IMDb
                    </button>
                </form>
                <a href="{{ route('tags.optimize-images') }}" target="_blank" rel="noopener" class="btn btn-info ml-2" title="Verificar e otimizar as imagens das tags já cadastradas">
                    <i class="fas fa-compress-arrows-alt"></i> Otimizar imagens
                </a>
            </div>
            <div class="card">
                <form action="{{ URL::asset($prefix_admin.'/'.$page_dados['route_controler']) }}"  class="form-inline d-none d-sm-inline-block">
                    <div class="input-group input-group-navbar p-2 float-right">
                        <input type="text" name="search" value="{{$search}}" class="form-control" placeholder="Buscar…" aria-label="Search" >
                        <div class="input-group-append">
                            <button type="submit" class="btn" type="button">
                                <i class="align-middle" data-feather="search"></i>
                            </button>
                        </div>
                    </div>
                    <!-- Example single danger button -->
                    <div class="form-group p-2 float-right">
                        <select name="qtd" class="form-control" onchange="this.form.submit()">
                            <option value="10" <?= $qtd=="10" ? 'selected' : '';?> >10</option>
                            <option value="15" <?= $qtd=="15" ? 'selected' : '';?> >15</option>
                            <option value="30" <?= $qtd=="30" ? 'selected' : '';?> >30</option>
                            <option value="100" <?= $qtd=="100" ? 'selected' : '';?> >100</option>
                            <option value="500" <?= $qtd=="500" ? 'selected' : '';?> >500</option>
                        </select>
                    </div>
                    <div class="clearfix"></div>
                </form>
                <table id="table" class="table table-sm table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Title</th>
                            <th>Imagem</th>
                            <th>Arquivo</th>
                            <th>IMDb</th>
                            <th>Avaliação</th>
                            <th>Popularidade</th>
                            <th>Data de atualização</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th>Id</th>
                            <th>Title</th>
                            <th>Imagem</th>
                            <th>Arquivo</th>
                            <th>IMDb</th>
                            <th>Avaliação</th>
                            <th>Popularidade</th>
                            <th>Data de atualização</th>
                            <th>Ações</th>
                        </tr>
                    </tfoot>
                    <tbody>
                        @foreach($lista as $item)
                        <tr class="even pointer" <?php if($item->status == 'hidden'){ echo 'style="background:#F25959; color:#fff;" '; } ?>>
                            <td>{{ $item->id }}</td>
                            <td>{{ $item->title }}</td>
                            <td class="text-center">
                                @if($item->image)
                                    <a href="{{ url($item->image) }}" class="fancybox" title="{{ $item->title }}">
                                        <img src="{{ url($item->image) }}" alt="Cartaz de {{ $item->title }}" width="56" height="80" loading="lazy" style="width:56px; height:80px; object-fit:cover; border-radius:4px;">
                                    </a>
                                @else
                                    <span aria-label="Sem imagem">-</span>
                                @endif
                            </td>
                            <td class="text-center">
                                @if($item->image_size_bytes)
                                    <strong>{{ number_format($item->image_size_bytes / 1024, 1, ',', '.') }} KB</strong><br>
                                    <small>{{ $item->image_width }}x{{ $item->image_height }} px</small>
                                @else
                                    <span title="Execute a otimização para calcular">Não verificado</span>
                                @endif
                            </td>
                            <td class="text-center">
                                @if($item->imdb_url)
                                    <a href="{{ $item->imdb_url }}" target="_blank" rel="noopener" class="btn btn-warning btn-sm" title="Abrir {{ $item->title }} no IMDb"><i class="fas fa-external-link-alt"></i></a>
                                @else
                                    <span aria-label="Sem link do IMDb">-</span>
                                @endif
                            </td>
                            <td class="text-center">{{ $item->imdb_rating !== null ? number_format($item->imdb_rating, 1, ',', '.') : '-' }}</td>
                            <td class="text-center">{{ $item->imdb_popularity ? '#'.$item->imdb_popularity : '-' }}</td>
                            <td>{{ date("d/m/Y \a\s H:i", strtotime($item->updated_at)) }}</td>
                            <td>
                                <a href="{{ URL::asset('admin/'.$page_dados['route_controler'].'/'.$item->id) }}" class="btn btn-info btn-sm" title="Ver"><i class="align-middle" data-feather="eye"></i></a>
                                <a href="{{ URL::asset('admin/'.$page_dados['route_controler'].'/'.$item->id.'/edit') }}" class="btn btn-success btn-sm" title="Editar"><i class="align-middle" data-feather="edit-2"></i></a>
                                <a href="{{ URL::asset('admin/'.$page_dados['route_controler'].'/'.$item->id) }}" class="btn btn-danger btn-sm method_destroy" data-method="DELETE" title="Excluir"><i class="align-middle" data-feather="trash-2"></i></a>
                            </td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>           
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12 col-xl-12">
            {{-- Pagination --}}
            <div class="d-flex justify-content-center">
            {{-- {!! $lista->links() !!} --}}
            {!! $lista->appends(['sort' => 'science-stream','search' => $search, 'qtd' => $qtd])->links() !!}
        </div>
    </div>
</div>

@endsection

@push('scripts-page')

<!-- Fancybox -->
<script src="{{ asset('packages/fancybox/dist/jquery.fancybox.js') }}" type="text/javascript"></script>
<link href="{{ asset('packages/fancybox/dist/jquery.fancybox.css') }}" media="all" rel="stylesheet">

<!-- DataTables -->
<link href="{{ asset('packages/datatables-1.10.15/media/css/dataTables.bootstrap4.min.css') }}" rel="stylesheet">
<link href="{{ asset('packages/datatables-1.10.15/media/css/dataTables.material.min.css') }}" rel="stylesheet">
<script src="{{ asset('packages/datatables-1.10.15/media/js/jquery.dataTables.min.js') }}"></script>

<script type="text/javascript">
$('document').ready(function(){

    $("a.fancybox").fancybox();

    $(".method_destroy").click(function() {
        var r = confirm('Tem certeza que deseja excluir esse item ?');
        if (r == true) {

            url = $(this).attr('href');
            method = $(this).attr('data-method');
            $(this).hide();
            $.ajax({
                type        : 'DELETE', // define the type of HTTP verb we want to use (POST for our form)
                url         : url, // the url where we want to POST
                data: { "_token": "{{ csrf_token() }}" },
                // dataType    : 'json' // what type of data do we expect back from the server
            })
            // using the done promise callback
            .done(function(data) {
                if(data == 'deletado'){
                    $('.message-ajax').html(    '<div class="alert alert-success alert-dismissible" role="alert">'+
                                                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close">'+
                                                        '<span aria-hidden="true">×</span>'+
                                                    '</button>'+
                                                    '<div class="alert-icon">'+
                                                        '<i class="far fa-fw fa-bell"></i>'+
                                                    '</div>'+
                                                    '<div class="alert-message">'+
                                                        '<strong>Deletado com sucesso ! Atualize sua página para ver as atualizações.</strong>'+
                                                    '</div>'+
                                                '</div>'
                                            );
                }
                if(data == 'erro'){
                    $('.method_destroy').show();
                    $('.message-ajax').html(    '<div class="alert alert-danger alert-dismissible" role="alert">'+
                                                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close">'+
                                                        '<span aria-hidden="true">×</span>'+
                                                    '</button>'+
                                                    '<div class="alert-icon">'+
                                                        '<i class="far fa-fw fa-bell"></i>'+
                                                    '</div>'+
                                                    '<div class="alert-message">'+
                                                        '<strong>Não foi possivel deletar.</strong>'+
                                                    '</div>'+
                                                '</div>'
                                            );
                }
                if(data == 'sem_permissao'){
                    $('.method_destroy').show();
                    $('.message-ajax').html(    '<div class="alert alert-danger alert-dismissible" role="alert">'+
                                                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close">'+
                                                        '<span aria-hidden="true">×</span>'+
                                                    '</button>'+
                                                    '<div class="alert-icon">'+
                                                        '<i class="far fa-fw fa-bell"></i>'+
                                                    '</div>'+
                                                    '<div class="alert-message">'+
                                                        '<strong>Sem Permissão Para Deletar !</strong>'+
                                                    '</div>'+
                                                '</div>'
                                            );
                   
                }
            })

            // using the fail promise callback
            .fail(function(data) {
                $('.method_destroy').show();
                $('.message-ajax').html(    '<div class="alert alert-danger alert-dismissible" role="alert">'+
                                                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close">'+
                                                        '<span aria-hidden="true">×</span>'+
                                                    '</button>'+
                                                    '<div class="alert-icon">'+
                                                        '<i class="far fa-fw fa-bell"></i>'+
                                                    '</div>'+
                                                    '<div class="alert-message">'+
                                                        '<strong>Não foi possivel deletar.</strong>'+
                                                    '</div>'+
                                                '</div>'
                                        );
            });
        }

        return false;

    });
});
</script>

@endpush
