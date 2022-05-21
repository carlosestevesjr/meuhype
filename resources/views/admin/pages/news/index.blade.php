@extends('admin.layouts')

@section('content')

<div class="row mb-2 mb-xl-3">
    <div class="col-auto d-none d-sm-block">
        <h3><strong>{{ $page_dados["title"] }}</strong></h3>
        <p class="title-description">{{ $page_dados["description"] }}</p>
    </div>

    <div class="col-auto ml-auto text-right mt-n1">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb bg-transparent p-0 mt-1 mb-0">
                <li class="breadcrumb-item"><a href="#">AdminKit</a></li>
                <li class="breadcrumb-item"><a href="#">Dashboards</a></li>
                <li class="breadcrumb-item active" aria-current="page">Analytics</li>
            </ol>
        </nav>
    </div>
</div>

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
    <div class="alert alert-success alert-dismissible" role="alert">
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
            </div>
            <p>
                <a class="btn btn-danger" data-toggle="collapse" href="#tags-crawleando" role="button" aria-expanded="false" aria-controls="tags-crawleando">
                    Tags Crawleando
                </a>
                <button class="btn btn-danger" type="button" data-toggle="collapse" data-target="#todas-tags" aria-expanded="false" aria-controls="todas-tags">
                    Todas as Tags
                </button>
            </p>
            <div class="collapse" id="tags-crawleando">
                <div class="card">
                    <div class="float-left p-2">
                        <h3>Tags Crawleando</h3>
                    
                        @foreach($tags_crawleando as $tag)
                            <a class="btn btn-dark" href="{{URL::asset($prefix_admin.'/'.$page_dados['route_controler'].'?search='.$tag->tags_title) }}">
                                #{{$tag->tags_title}}
                            </a>
                        @endforeach
                        <a class="btn btn-info" href="{{URL::asset($prefix_admin.'/'.$page_dados['route_controler'].'?search=') }}">
                            Limpar
                        </a>
                    </div>
                </div>
            </div>
            <div class="collapse" id="todas-tags">
                <div class="card" >
                    <div class="float-left p-2">
                        <h3>Todas as Tags</h3>
                        @foreach($tags as $tag)
                            <a class="btn btn-outless" href="{{URL::asset($prefix_admin.'/'.$page_dados['route_controler'].'?search='.$tag->tags_title) }}">
                                #{{$tag->tags_title}}
                            </a>
                        @endforeach
                        <a class="btn btn-info" href="{{URL::asset($prefix_admin.'/'.$page_dados['route_controler'].'?search=') }}">
                            Limpar
                        </a>
                    </div>
                </div>
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
                <div class="card">
                    <div class="col-12 col-xl-12">
                        {{-- Pagination --}}
                        <div class="d-flex justify-content-center">
                        {{-- {!! $lista->links() !!} --}}
                        {!! $lista->appends(['sort' => 'science-stream','search' => $search, 'qtd' => $qtd])->links() !!}
                    </div>
                </div>
                <table id="table" class="table table-sm table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <tr>
                                <th>Id</th>
                                <th>Titulo</th>
                                <th>Image</th>
                                <th>Data Fornecedor</th>
                                <th>Canal</th>
                                <th>Tipo Canal</th>
                                <th>Data de atualização</th>
                                <th>Ações</th>
                            </tr>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th>Id</th>
                            <th>Titulo</th>
                            <th>Image</th>
                            <th>Data Fornecedor</th>
                            <th>Canal</th>
                            <th>Tipo Canal</th>
                            <th>Data de atualização</th>
                            <th>Ações</th>
                        </tr>
                    </tfoot>
                    <tbody>
                        @foreach($lista as $item)
                        <tr class="even pointer" <?php if($item->status == 'hidden'){ echo 'style="background:#F25959; color:#fff;" '; } ?>>
                            <td>{{ $item->id }}</td>
                            <td width="25%"><strong>{{ $item->title }}</strong></td>
                            <td>
                                <a href="{{ url($item->image) }}" class="fancybox">
                                    <img src="{{ url($item->image) }}" height="60px" class="image">
                                </a>
                            </td>
                            <td>{{ date("d/m/Y", strtotime($item->data)) }}</td>
                            <td>{{ $item->canal }}</td>
                            <td>{{ $item->tipo_canal }}</td>
                            <td>{{ date("d/m/Y \a\s H:i", strtotime($item->updated_at)) }}</td>
                            <td>
                                <a href="{{ $item->link }}" target="_blank" class="btn btn-info btn-sm" title="Ver Post"><i class="align-middle fas fa-link"></i></a>
                                <a href="{{ URL::asset('admin/'.$page_dados['route_controler'].'/'.$item->id) }}" class="btn btn-info btn-sm" title="Ver"><i class="align-middle fas fa-eye"></i></a>
                                <a href="{{ URL::asset('admin/'.$page_dados['route_controler'].'/'.$item->id.'/edit') }}" class="btn btn-success btn-sm" title="Editar"><i class="align-middle fas fa-pencil-alt"></i></a>
                                <a href="{{ URL::asset('admin/'.$page_dados['route_controler'].'/'.$item->id) }}" class="btn btn-danger btn-sm method_destroy" data-method="DELETE" title="Excluir"><i class="align-middle fas fa-trash-alt"></i></a>
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
