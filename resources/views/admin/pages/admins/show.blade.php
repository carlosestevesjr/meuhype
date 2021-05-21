@extends('admin.layouts')

@section('content')

<div class="title-block">
    <h3 class="title">{{ $page_dados['title'] }} - Ver <span class="sparkline bar" data-type="bar"></span> </h3>
</div>
<div class="p-3">
    <a href="{{ url($prefix_admin.'/'.$page_dados['route_controler']) }}" class="btn btn-primary"><em class="fa fa-angle-double-left"></em> voltar</a>
    <a href="{{ url($prefix_admin.'/'.$page_dados['route_controler'].'/create') }}" class="btn btn-primary"><em class="fa fa-file-text-o"></em> novo registro</a>
</div>

<div class="container-fluid p-0">
    <div class="row">
        <div class="col-12 col-xl-12">
            <div class="card">
                <div class="card-header">
                    <h2><i class="fas fa-user m-2" style="color:#aaaaaa;"></i><strong>{{ $item->name }}</strong></h2>
                </div>
                <div class="card-body">
                    <form method="post" action="{{ URL::asset($prefix_admin.'/'.$page_dados['route_controler'].'/'.$item->id ) }}" role="form" class="form" enctype="multipart/form-data">
                        <div class="form-row">
                            <div class="form-group col-12 col-lg-6">
                                <label >Nome</label>
                                <input type="text" name="name" class="form-control" placeholder="" readonly value="{{ $item->name }}" >
                            </div>
                            <div class="form-group col-12 col-lg-6">
                                <label>Email</label>
                                <input type="text" name="email" class="form-control" placeholder="" readonly value="{{ $item->email }}" readonly>
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
                                </div>
                            </div>
                            <div class="form-group col-12 col-lg-6">
                                <label>Status</label>
                                <div>
                                    <select name="status" id="status" readyonly class="form-control">
                                        <option value="active" <?php if($item->status == 'active') echo "selected" ?>>Ativo</option>
                                        <option value="hidden" <?php if($item->status == 'hidden') echo "selected" ?>>Bloqueado</option>
                                    </select>
                                </div>
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

