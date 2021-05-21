@extends('admin.layouts')

@section('content')
<article class="content item-editor-page">
    <div class="title-block">
        <h1 class="title"> {{ $page_dados["title"] }} - Criar </h1>
        <p class="title-description">{{ $page_dados["description"] }}</p>
    </div>
    <div class="">
        <a href="{{ url($prefix_admin.'/'.$page_dados['route_controler']) }}" class="btn btn-primary"><em class="fa fa-angle-double-left"></em> voltar</a>
        <a href="{{ url($prefix_admin.'/'.$page_dados['route_controler'].'/create') }}" class="btn btn-primary"><em class="fa fa-file-text-o"></em> novo registro</a>
    </div>
    @if (count($errors) > 0)
        <ul class="alert alert-danger notification">
            @foreach ($errors->all() as $error)
                <li>{{ $error }}</li>
            @endforeach
        </ul>
    @endif

    <form method="post" action="{{ URL::asset( $prefix_admin.'/'.$page_dados['route_controler']) }}" role="form" enctype="multipart/form-data">
        <div class="card card-block">
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Titulo:</label>
                <div class="col-sm-10">
                    <input type="text" name="title" class="form-control boxed" value="{{ old('title') }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Descrição Curta:</label>
                <div class="col-sm-10">
                    <textarea name="description_short" id="description_short" class="form-control" maxlength="255" rows="5" >{{ old('description_short') }}</textarea>
                    <p style="color:red;"><small class="caracteres"></small></p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Conteúdo:</label>
                <div class="col-sm-10">
                    <textarea name="description" id="description" class="form-control textarea" rows="10" >{{ old('description') }}</textarea>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Logo:</label>
                <div class="col-sm-10">
                    <input type="file" name="image-log" id="image" class="inputfile inputfile-1" data-multiple-caption="{count} files selected" />
                    <label for="image"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="17" viewBox="0 0 20 17"><path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"/></svg> <span>arquivo&hellip;</span></label>
                    <p class="help-block">Tamanho da imagem: 560x300px 2M</p>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Email 1:</label>
                <div class="col-sm-10">
                    <input type="text" name="email1" class="form-control boxed" placeholder="" value="{{ old('email1') }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Email 2:</label>
                <div class="col-sm-10">
                    <input type="text" name="email2" class="form-control boxed" placeholder="" value="{{ old('email2') }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Telefone 1</label>
                <div class="col-sm-10">
                    <input type="text" name="tel1" class="form-control boxed" placeholder="" value="{{ old('tel1') }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Telefone 2</label>
                <div class="col-sm-10">
                    <input type="text" name="tel2" class="form-control boxed" placeholder="" value="{{ old('tel2') }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Facebook:</label>
                <div class="col-sm-10">
                    <input type="text" name="facebook" class="form-control boxed" placeholder="" value="{{ old('facebook') }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Twitter:</label>
                <div class="col-sm-10">
                    <input type="text" name="twitter" class="form-control boxed" placeholder="" value="{{ old('twitter') }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Instagram:</label>
                <div class="col-sm-10">
                    <input type="text" name="instagram" class="form-control boxed" placeholder="" value="{{ old('instagram') }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Youtube:</label>
                <div class="col-sm-10">
                    <input type="text" name="youtube" class="form-control boxed" placeholder="" value="{{ old('youtube') }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Vímeo:</label>
                <div class="col-sm-10">
                    <input type="text" name="vimeo" class="form-control boxed" placeholder="" value="{{ old('vimeo') }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Linkedin:</label>
                <div class="col-sm-10">
                    <input type="text" name="linkedin" class="form-control boxed" placeholder="" value="{{ old('linkedin') }}">
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Cor do Painel:</label>
                <div class="col-sm-10">
                    <select name="color-painel" id="status" class="form-control">
                        <option value="blue" selected>Azul</option>
                        <option value="green">Verde</option>
                        <option value="orange">Laranja</option>
                        <option value="purple">Roxo</option>
                        <option value="red">Vermelho</option>
                        <option value="seagreen">Verde água</option>
                    </select>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 form-control-label text-xs-right">Keywords:</label>
                <div class="col-sm-10">
                    <input type="text" name="keywords" class="form-control boxed" placeholder="" value="{{ old('keywords') }}">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-10 col-md-offset-2">
                {{ csrf_field() }}
                <button type="submit" class="btn btn-primary">
                    Salvar
                </button>
            </div>
        </div>
    </form>
</article>

@endsection

@push('scripts-page')

<!-- Tinymce -->
<script src="{{ asset('packages/tinymce/tinymce.min.js') }}"></script>

<!-- Btn FIle customfileInputs-->
<link href="{{ asset('packages/customfileInputs/css/normalize.css') }}" rel="stylesheet">
<link href="{{ asset('packages/customfileInputs/css/component.css') }}" rel="stylesheet">
<!--[if IE]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<!-- remove this if you use Modernizr -->
<script>(function(e,t,n){var r=e.querySelectorAll("html")[0];r.className=r.className.replace(/(^|\s)no-js(\s|$)/,"$1js$2")})(document,window,0);</script>
<script src="{{ asset('packages/customfileInputs/js/custom-file-input.js') }}"></script>

<script type="text/javascript">
$(document).ready(function(){

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

     //Contador de caracteres
     $(document).on("input", "#description_short", function() {
         var limite = 254;
         var informativo = "caracteres restantes.";
         var caracteresDigitados = $(this).val().length;
         var caracteresRestantes = limite - caracteresDigitados;

         if (caracteresRestantes <= 0) {
             var comentario = $("textarea[name=description_short]").val();
             $("textarea[name=description_short]").val(comentario.substr(0, limite));
             $(".caracteres").text("0 " + informativo);
         } else {
             $(".caracteres").text(caracteresRestantes + " " + informativo);
         }
     });

});

</script>

@endpush
