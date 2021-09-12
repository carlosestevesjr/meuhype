@extends('admin.layouts')

@section('content')

<div class="title-block">
    <h3 class="title">{{ $page_dados['title'] }} - Criar </h3>
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
                <div class="card-body">
                    <form method="post"  action="{{ URL::asset( $prefix_admin.'/'.$page_dados['route_controler']) }}" role="form" class="form" enctype="multipart/form-data">
                        <div class="form-row">
                            <div class="form-group col-12 col-lg-12">
                                <label>Title</label>
                                <input type="text" name="title" class="form-control" placeholder="" value="{{ old('title') }}" >
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-12 col-lg-6">
                                <label>Hora Inicial</label>
                                <input type="time" name="time_initial" class="form-control" placeholder="" value="{{ old('time_initial') }}" >
                            </div>
                            <div class="form-group col-12 col-lg-6">
                                <label>Tipo De Crawler</label>
                                <select name="type" class="form-control">
                                    <option value="spotify">Spotify</option>
                                    <option value="site">Site</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-12 col-lg-12">
                                <h5>Tag Crawler</h5>
                                @foreach($tags as $tag)
                                    <div class=" form-check form-check-inline ">
                                        <div class="form-control mb-1">
                                            <input class="form-check-input" type="radio" id="_{{$tag->id}}" name="tags_id" value="{{ $tag->id }}">
                                            <label class="form-check-label" for="_{{$tag->id}}"> {{ $tag->title }}</label><br>
                                        </div>
                                    </div>
                                @endforeach
                            </div>
                           
                            <div class="form-group col-12 col-lg-12">
                                <label>Descrição</label>
                                <textarea name="description" id="description" class="form-control textarea" rows="10">{{ old('description') }}</textarea>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-12 col-lg-6">
                                <label>Ordem</label>
                                <input type="text" name="order" class="form-control boxed" placeholder="" value="{{ old('order') }}">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-12 col-lg-6">
                                <label>Status</label>
                                <select name="status" id="status" class="form-control">
                                        <option value="active" selected >Ativo</option>
                                        <option value="hidden" >Bloqueado</option>
                                    </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-12">
                                {{ csrf_field() }}
                                <button type="submit" class="btn btn-success">
                                    Salvar
                                </button>
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

</script>

@endpush
