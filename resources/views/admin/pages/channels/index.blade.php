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
                <table id="table" class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <tr>
                                <th>Id</th>
                                <th>Nome</th>
                                <th>Tipo</th>
                                <th>Data de atualização</th>
                                <th>Ações</th>
                            </tr>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th>Id</th>
                            <th>Nome</th>
                            <th>Tipo</th>
                            <th>Data de atualização</th>
                            <th>Ações</th>
                        </tr>
                    </tfoot>
                    <tbody>
                        @foreach($lista as $item)
                        <tr class="even pointer" <?php if($item->status == 'hidden'){ echo 'style="background:#F25959; color:#fff;" '; } ?>>
                            <td>{{ $item->id }}</td>
                            <td>{{ $item->name }}</td>
                            <td>{{ $item->type }}</td>
                            <td>{{ date("d/m/Y \a\s H:i", strtotime($item->updated_at)) }}</td>
                            <td>
                                <a href="{{ URL::asset('admin/'.$page_dados['route_controler'].'/'.$item->id) }}" class="btn btn-info btn-sm" title="Ver"><i class="align-middle fas fa-eye"></i></a>
                                <a href="{{ URL::asset('admin/'.$page_dados['route_controler'].'/'.$item->id.'/edit') }}" class="btn btn-success btn-sm" title="Editar"><i class="align-middle fas fa-pencil-alt"></i></a>
                                <!-- <a href="{{ URL::asset('admin/'.$page_dados['route_controler'].'/'.$item->id) }}" class="btn btn-danger btn-sm method_destroy" data-method="DELETE" title="Excluir"><i class="align-middle fas fa-trash-alt"></i></a> -->
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

<!-- DataTables -->
<link href="{{ asset('packages/datatables-1.10.15/media/css/dataTables.bootstrap4.min.css') }}" rel="stylesheet">
<link href="{{ asset('packages/datatables-1.10.15/media/css/dataTables.material.min.css') }}" rel="stylesheet">
<script src="{{ asset('packages/datatables-1.10.15/media/js/jquery.dataTables.min.js') }}"></script>

<script type="text/javascript">
$('document').ready(function(){

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
