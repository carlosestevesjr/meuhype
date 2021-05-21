@extends('admin.layouts')

@section('content')
<article class="content item-editor-page">
    <div class="title-block">
        <h3 class="title">{{ $page_dados['title'] }} - Editar <span class="sparkline bar" data-type="bar"></span> </h3>
    </div>
    <div class="">
        <!-- <a href="{{ url($prefix_admin.'/'.$page_dados['route_controler']) }}" class="btn btn-primary"><em class="fa fa-angle-double-left"></em> voltar</a> -->
        <!-- <a href="{{ url($prefix_admin.'/'.$page_dados['route_controler'].'/create') }}" class="btn btn-primary"><em class="fa fa-file-text-o"></em> novo registro</a> -->
    </div>
    @if (count($errors) > 0)
        <ul class="alert alert-danger notification">
            @foreach ($errors->all() as $error)
                <li>{{ $error }}</li>
            @endforeach
        </ul>
    @endif
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
    <div class="card card-block">
        <h1>{{ $item->title }}</h1>
    </div>
    <div class="card card-block">
        <form method="post" action="{{ URL::asset($prefix_admin.'/'.$page_dados['route_controler'].'/'.$item->id ) }}" role="form" class="form" enctype="multipart/form-data">
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Titulo:</label>
                <div class="col-sm-10">
                    <input type="text" name="title" class="form-control boxed" placeholder="" value="{{ $item->title }}" >
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Descrição Curta:</label>
                <div class="col-sm-10">
                    <textarea name="description_short" id="description_short" class="form-control" maxlength="255" rows="5">{{ $item->description_short }}</textarea>
                    <p style="color:red;"><small class="caracteres"></small></p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Conteúdo:</label>
                <div class="col-sm-10">
                    <textarea name="description" id="description" class="form-control textarea" rows="10">{{ $item->description }}</textarea>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Logo:</label>
                <div class="col-sm-10">
                    <div class="images-container">
                        @if($item->image)
                        <div class="image-container">
                            <a href="{{ url($item->image) }}" class="fancybox">
                                <img src="{{ url($item->image) }}" class="image-tm" style="max-width:100%;">
                            </a>
                        </div>
                        @endif
                    </div>
                    <input type="file" name="image" id="image" class="inputfile inputfile-1" data-multiple-caption="{count} arquivos selecionados"/>
                    <label for="image"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="17" viewBox="0 0 20 17"><path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"/></svg> <span>arquivo&hellip;</span></label>
                    <p class="help-block">Tamanho da imagem: 560x300px 2M</p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Email 1:</label>
                <div class="col-sm-10">
                    <input type="text" name="email1" class="form-control boxed" placeholder="" value="{{ $item->email1 }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Email 2:</label>
                <div class="col-sm-10">
                    <input type="text" name="email2" class="form-control boxed" placeholder="" value="{{ $item->email2 }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Telefone 1:</label>
                <div class="col-sm-10">
                    <input type="text" name="tel1" class="form-control boxed"  id="tel1" placeholder="" value="{{ $item->tel1 }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right" >Telefone 2:</label>
                <div class="col-sm-10">
                    <input type="text" name="tel2" class="form-control boxed" id="tel2" placeholder="" value="{{ $item->tel2 }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Facebook:</label>
                <div class="col-sm-10">
                    <input type="text" name="facebook" class="form-control boxed" placeholder="" value="{{ $item->facebook }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Twitter:</label>
                <div class="col-sm-10">
                    <input type="text" name="twitter" class="form-control boxed" placeholder="" value="{{ $item->twitter }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Instagram:</label>
                <div class="col-sm-10">
                    <input type="text" name="instagram" class="form-control boxed" placeholder="" value="{{ $item->instagram }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Youtube:</label>
                <div class="col-sm-10">
                    <input type="text" name="youtube" class="form-control boxed" placeholder="" value="{{ $item->youtube }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Vímeo:</label>
                <div class="col-sm-10">
                    <input type="text" name="vimeo" class="form-control boxed" placeholder="" value="{{ $item->vimeo }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Linkedin:</label>
                <div class="col-sm-10">
                    <input type="text" name="linkedin" class="form-control boxed" placeholder="" value="{{ $item->linkedin }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Cor do Painel:</label>
                <div class="col-sm-10">
                    <select name="color-painel" id="status" class="form-control">
                        <option value="blue" <?php if( $item->color_painel == 'blue' ) echo "selected" ?>>Azul</option>
                        <option value="green" <?php if( $item->color_painel == 'green' ) echo "selected" ?>>Verde</option>
                        <option value="orange" <?php if( $item->color_painel == 'orange' ) echo "selected" ?>>Laranja</option>
                        <option value="purple" <?php if( $item->color_painel == 'purple' ) echo "selected" ?>>Roxo</option>
                        <option value="red" <?php if( $item->color_painel == 'red' ) echo "selected" ?>>Vermelho</option>
                        <option value="seagreen" <?php if( $item->color_painel == 'seagreen' ) echo "selected" ?>>Verde água</option>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Keywords:</label>
                <div class="col-sm-10">
                    <input type="text" name="keywords" class="form-control boxed" placeholder="" value="{{ $item->keywords }}" >
                </div>
            </div>
            <div class="row">
                <div class="col-md-10 col-md-offset-2">
                    {{ csrf_field() }}
                    <input name="_method" type="hidden" value="PUT">
                    <button type="submit" class="btn btn-primary">
                        Salvar
                    </button>
                </div>
            </div>
        </form>
    </div>

</article>
<!-- /.modal -->
<div class="modal fade" id="confirm-modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title"><i class="fa fa-warning"></i> Alerta</h4>
            </div>
            <div class="modal-body">
                <p>Tem certeza que deseja fazer isso ?</p>
            </div>
            <div class="modal-footer"> <button type="button" class="btn btn-primary" data-dismiss="modal">Sim</button> <button type="button" class="btn btn-secondary" data-dismiss="modal">Não</button> </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
@endsection

@push('scripts-page')


<!-- Fancybox -->
<script src="{{ asset('packages/fancybox/dist/jquery.fancybox.js') }}" type="text/javascript"></script>
<link href="{{ asset('packages/fancybox/dist/jquery.fancybox.css') }}" media="all" rel="stylesheet">


<!-- Tinymce -->
<script src="{{ asset('packages/tinymce/tinymce.min.js') }}"></script>


<!-- FIle Input customfileInputs -->
<script>(function(e,t,n){var r=e.querySelectorAll("html")[0];r.className=r.className.replace(/(^|\s)no-js(\s|$)/,"$1js$2")})(document,window,0);</script>

<link href="{{ asset('packages/customfileInputs/css/normalize.css') }}" rel="stylesheet">
<link href="{{ asset('packages/customfileInputs/css/component.css') }}" rel="stylesheet">
<!--[if IE]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

<!-- remove this if you use Modernizr -->

<script src="{{ asset('packages/customfileInputs/js/custom-file-input.js') }}"></script>

<!-- Masked Input -->
<script src="{{ asset('packages/maskedinput/jquery.maskedinput.min.js') }}"></script>


<script type="text/javascript">

    $(document).ready(function(){

        $("#tel1").mask("(99) 9999-9999?9");

        $("#tel2").mask("(99) 9999-9999?9");

		$("a.fancybox").fancybox();

        // TinyMCE init
        tinymce.init({
          selector: '.textarea',
          language : 'pt_BR',
          height: 300,
          plugins: [
            'advlist autolink lists link image charmap print preview hr anchor pagebreak',
            'searchreplace wordcount visualblocks visualchars code fullscreen',
            'insertdatetime media nonbreaking save table contextmenu directionality',
            'emoticons template paste textcolor colorpicker textpattern imagetools toc help'
          ],
          toolbar1: 'undo redo | insert | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image',
          toolbar2: 'print preview media | forecolor backcolor emoticons | codesample help',
          image_advtab: true,
          templates: [
            { title: 'Test template 1', content: 'Test 1' },
            { title: 'Test template 2', content: 'Test 2' }
          ],
          content_css: [
            '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
            '//www.tinymce.com/css/codepen.min.css'
          ]
         });
    });
</script>

@endpush
