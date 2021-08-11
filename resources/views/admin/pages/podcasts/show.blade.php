@extends('admin.layouts')

@section('content')

<div class="title-block">
    <h3 class="title">{{ $page_dados['title'] }} - Editar </h3>
    <p class="title-description">{{ $page_dados["description"] }}</p>
</div>
<div class="p-3">
    <a href="{{ url($prefix_admin.'/'.$page_dados['route_controler']) }}" class="btn btn-primary"><em class="fa fa-angle-double-left"></em> voltar</a>
    <a href="{{ url($prefix_admin.'/'.$page_dados['route_controler'].'/create') }}" class="btn btn-primary"><em class="fa fa-file-text-o"></em> novo registro</a>
</div>

@if (count($errors) > 0)
    <div class="alert alert-danger alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">×</span>
        </button>
        <div class="alert-icon">
            <i class="far fa-fw fa-bell"></i>
        </div>
        <div class="alert-message">
            @foreach ($errors->all() as $error)
                <div>
                    <strong>{{ $error }}</strong>
                </div>
            @endforeach
        </div>
    </div>
@endif

@if(Session::has('message'))
    <div class="alert alert-danger alert-dismissible" role="alert">
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

<div class="container-fluid p-0">
    <div class="row">
        <div class="col-12 col-xl-12">
            <div class="card">
                <div class="card-header">
                    <h2><strong>Hash: {{ $item->hash }}</strong></h2>
                </div>
                <div class="card-body">
                    <form>
                        <div class="form-row">
                            <div class="form-group col-12 col-lg-6">
                                <label>Titulo</label>
                                <input type="text" name="title" class="form-control" placeholder="" readonly value="{{ $item->title }}" >
                            </div>
                            <div class="form-group col-12 col-lg-6">
                                <label>Slug</label>
                                <input type="text" name="title" class="form-control" placeholder="" readonly value="{{ $item->slug }}" >
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-12 col-lg-12">
                                <label>Descrição Curta</label>
                                <textarea name="description_short" id="description_short" class="form-control" maxlength="255" readonly rows="3">{{ $item->description_short }}</textarea>
                                <p style="color:red;"><small class="caracteres"></small></p>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-12 col-lg-12">
                                <label>Descrição</label>
                                <textarea name="description" id="description" class="form-control textarea" readonly rows="10">{{ $item->description }}</textarea>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-12 col-lg-6">
                                <label >Foto</label>
                                <div class="box">
                                    @if($item->image)
                                    <div class="image-container">
                                        <a href="{{ url($item->image) }}" class="fancybox">
                                            <img src="{{ url($item->image) }}" height="100px" class="image">
                                        </a>
                                    </div>
                                    @endif
                                    <input type="file" name="image" id="image" class="inputfile inputfile-1" data-multiple-caption="{count} arquivos selecionados"/>
                                    <label for="image"> <i class="fas fa-upload"></i> <span>arquivo&hellip;</span></label>
                                    <p>Tamanho da imagem: 560x300px 2M</p>
                                </div>
                            </div>
                            <div class="form-group col-12 col-lg-6">
                                <label>Link</label>
                                <input type="text" name="link" class="form-control" placeholder="" readonly value="{{ $item->link }}" >
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-12 col-lg-6">
                                <label>Canais</label>
                                <select name="channel_id" readonly class="form-control">
                                    <option value="" >Nenhum</option>
                                    @foreach($canais as $canal)
                                        <option  value="{{ $canal->id }}" <?php if($canal->id == $item->channel_id){ echo 'selected';}?> >{{ $canal->name }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="form-group col-12 col-lg-6">
                                <label>Data</label>
                                <input type="text" name="data" class="form-control" placeholder="" readonly value="{{ $item->data }}" >
                            </div>
                      
                        </div>
                        <div class="form-row">
                            <div class="form-group col-12 col-lg-6">
                                <label>Keywords</label>
                                <input type="text" name="keywords" class="form-control" placeholder="" readonly value="{{ $item->keywords }}" >
                            </div>
                            <div class="form-group col-12 col-lg-6">
                                <label>Ordem</label>
                                <input type="text" name="order" class="form-control boxed" placeholder="" readonly value="{{ $item->order }}">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-12 col-lg-6">
                                <label>Status</label>
                                <select name="status" id="status" class="form-control">
                                    <option value="active" <?php if($item->status == 'active') echo "selected" ?>>Ativo</option>
                                    <option value="hidden" <?php if($item->status == 'hidden') echo "selected" ?>>Bloqueado</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
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
<script type="text/javascript">
    $(document).ready(function(){
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
</script>

@endpush
