@extends('admin.layouts')

@section('content')

<article class="content dashboard-page">
    <div class="title-block">
        <h1 class="title"> {{ $page_dados["title"] }} </h1>
        <p class="title-description">{{ $page_dados["description"] }}</p>
    </div>

    
    <a href="{{ url($prefix_admin.'/'.$page_dados['route_controler'].'/create') }}" class="btn btn-primary"><em class="fa fa-file-text-o"></em> novo registro</a>

    <div class="message_alert"></div>

    @if(Session::has('message'))
        <ul class="alert alert-success notification">
            <li>{{ Session::get('message') }}</li>
        </ul>
    @endif

    @if(Session::has('message_error'))
        <ul class="alert alert-success notification">
            <li>{{ Session::get('message_error') }}</li>
        </ul>
    @endif

    <section class="section">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-block">
                        <section class="example">
                            <div class="table-responsive">
                                <table id="table" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <tr>
                                                <th>Id</th>
                                                <th>Title</th>
                                                <th>Data de atualização</th>
                                                <th>Ações</th>
                                            </tr>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>Id</th>
                                            <th>Title</th>
                                            <th>Data de atualização</th>
                                            <th>Ações</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        @foreach($lista as $item)
                                        <tr class="even pointer" <?php if($item->status == 'hidden'){ echo 'style="background:#F25959; color:#fff;" '; } ?>>
                                            <td>{{ $item->id }}</td>
                                            <td>{{ $item->title }}</td>
                                            <td>{{ date("d/m/Y \a\s H:i", strtotime($item->updated_at)) }}</td>
                                            <td>
                                                <a href="{{ URL::asset('admin/'.$page_dados['route_controler'].'/'.$item->id) }}" class="btn btn-success" title="Ver"><em class="fa fa-book"></em></a>
                                                <a href="{{ URL::asset('admin/'.$page_dados['route_controler'].'/'.$item->id.'/edit') }}" class="btn btn-success" title="Editar"><em class="fa fa-pencil"></em></a>
                                                <a href="{{ URL::asset('admin/'.$page_dados['route_controler'].'/'.$item->id) }}" class="btn btn-danger method_destroy" data-method="DELETE" title="Excluir"><em class="fa fa-trash-o"></em></a>
                                            </td>
                                        </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                            </div>
                        </section>
                    </div>
                </div>
            </div>
        </div>
    </section>
</article>

@endsection

@push('scripts-page')

<!-- DataTables -->
<link href="{{ asset('packages/datatables-1.10.15/media/css/dataTables.bootstrap4.min.css') }}" rel="stylesheet">
<link href="{{ asset('packages/datatables-1.10.15/media/css/dataTables.material.min.css') }}" rel="stylesheet">
<script src="{{ asset('packages/datatables-1.10.15/media/js/jquery.dataTables.min.js') }}"></script>

<script type="text/javascript">
$('document').ready(function(){

    $('#table').DataTable( {
        "order": [[ 1, "desc" ]],
        "oLanguage": {
            "sUrl": "{{ asset('packages/datatables-1.10.15/language/Portuguese.json') }}"
        },
        "pagingType": "full_numbers",

    } );

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
                    //alert('Deletado com sucesso ! Atualize a página.');
                    $('.message_alert').html(
                        '<ul class="alert alert-success notification">'+
                            '<li>Deletado com sucesso ! Atualize sua página para ver as atualizações.</li>'+
                        '</ul>'
                    );
                }
                if(data == 'erro'){
                    //alert('Não foi possivel deletar');
                    $('.method_destroy').show();
                    $('.message_alert').html(
                        '<ul class="alert alert-danger notification">'+
                            '<li>Não foi possivel deletar</li>'+
                        '</ul>'
                    );
                }
                if(data == 'sem_permissao'){
                    //alert('Não foi possivel deletar');
                    $('.method_destroy').show();
                    $('.message_alert').html(
                        '<ul class="alert alert-danger notification">'+
                            '<li>Sem Permissão Para Deletar !</li>'+
                        '</ul>'
                    );
                }
            })

            // using the fail promise callback
            .fail(function(data) {
                //alert('Não foi possivel deletar');
                $('.method_destroy').show();
                $('.message_alert').html(
                    '<ul alert alert-danger notification>'+
                        '<li>Não foi possivel deletar </li>'+
                    '</ul>'
                );
                // show any errors
                // best to remove for production
                //sconsole.log(data);
            });
        }

        return false;

    });
});
</script>

@endpush
