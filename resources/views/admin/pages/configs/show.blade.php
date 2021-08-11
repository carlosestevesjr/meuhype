@extends('admin.layouts')

@section('content')
<article class="content item-editor-page">
    <div class="title-block">
        <h1 class="title"> {{ $page_dados["title"] }} - Ver </h1>
        <p class="title-description">{{ $page_dados["description"] }}</p>
    </div>
    <div class="">
        <a href="{{ url($prefix_admin.'/'.$page_dados['route_controler']) }}" class="btn btn-primary"><em class="fa fa-angle-double-left"></em> voltar</a>
        <a href="{{ url($prefix_admin.'/'.$page_dados['route_controler'].'/create') }}" class="btn btn-primary"><em class="fa fa-file-text-o"></em> novo registro</a>
    </div>

    <div class="card card-block">
        <div class="form-group row">
            <label class="col-sm-2 form-control-label text-xs-right">Titulo:</label>
            <div class="col-sm-10">
                <input type="text" name="title" class="form-control boxed" placeholder="" readonly value="{{ $item->title }}" >
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 form-control-label text-xs-right">Descrição Curta:</label>
            <div class="col-sm-10">
                <textarea name="description_short" id="description_short" class="form-control" maxlength="255" rows="5" readonly>{{ $item->description_short }}</textarea>
                <p style="color:red;"><small class="caracteres"></small></p>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 form-control-label text-xs-right">Conteúdo:</label>
            <div class="col-sm-10">
                <textarea name="description" id="description" class="form-control textarea" rows="10" readonly>{{ $item->description }}</textarea>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 form-control-label text-xs-right">Logo:</label>
            <div class="col-sm-10">
                <div class="images-container">
                    @if($item->image_logo)
                    <div class="image-container">
                        <a href="{{ url($item->image_logo) }}" class="fancybox">
                            <img src="{{ url($item->image_logo) }}" class="image-tm" style="max-width:100%;">
                        </a>
                    </div>
                    @endif
                </div>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 form-control-label text-xs-right">Facebook:</label>
            <div class="col-sm-10">
                <input type="text" name="facebook" class="form-control boxed" placeholder="" readonly value="{{ $item->facebook }}">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 form-control-label text-xs-right">Twitter:</label>
            <div class="col-sm-10">
                <input type="text" name="twitter" class="form-control boxed" placeholder="" readonly value="{{ $item->twitter }}">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 form-control-label text-xs-right">Instagram:</label>
            <div class="col-sm-10">
                <input type="text" name="instagram" class="form-control boxed" placeholder="" readonly value="{{ $item->instagram }}">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 form-control-label text-xs-right">Youtube:</label>
            <div class="col-sm-10">
                <input type="text" name="youtube" class="form-control boxed" placeholder="" readonly value="{{ $item->youtube }}">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 form-control-label text-xs-right">Vímeo:</label>
            <div class="col-sm-10">
                <input type="text" name="vimeo" class="form-control boxed" placeholder="" readonly value="{{ $item->vimeo }}">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 form-control-label text-xs-right">Linkedin:</label>
            <div class="col-sm-10">
                <input type="text" name="linkedin" class="form-control boxed" placeholder="" readonly value="{{ $item->linkedin }}">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 form-control-label text-xs-right">Cor do Painel:</label>
            <div class="col-sm-10">
                <input type="text" name="color-painel" class="form-control boxed" placeholder="" readonly value="{{ $item->color_painel }}" >
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 form-control-label text-xs-right">Keywords:</label>
            <div class="col-sm-10">
                <input type="text" name="keywords" class="form-control boxed" placeholder="" readonly value="{{ $item->keywords }}" >
            </div>
        </div>
    </div>
</article>

@endsection

@push('scripts-page')

<!-- Fancybox -->
<script src="{{ asset('packages/fancybox/dist/jquery.fancybox.js') }}" type="text/javascript"></script>
<link href="{{ asset('packages/fancybox/dist/jquery.fancybox.css') }}" media="all" rel="stylesheet">

<!-- Tinymce -->
<script src="{{ asset('packages/tinymce/tinymce.min.js') }}"></script>


<script type="text/javascript">
$(document).ready(function(){
    $("a.fancybox").fancybox();
    // TinyMCE init
    tinymce.init({
      selector: '.textarea',
      language : 'pt_BR',
      height: 300,
      image_advtab: true,
      content_css: [
        '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
        '//www.tinymce.com/css/codepen.min.css'
      ]
     });
});

</script>

@endpush
