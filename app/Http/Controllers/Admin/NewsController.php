<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Http\Controllers\Controller;

//Auth facade
use Auth;
use Validator;
use File;
use Session;

use App\News;
use App\Tags;
use App\Channels;
use App\NewsTags;
use App\Upload;

use DB;

class NewsController extends Controller
{

    public function __construct()
	{
        $this->page_dados = array(
            'title' => 'News',
            'description' => 'Descrição',
            'route_controler' => 'news',
            'route_view' => 'news',
            'prefix_auth' => 'admin',
            'diretorio_aquivo' => 'arquivos',
            'diretorio_image' => 'news'
        );
	}

    public function index(Request $request)
    {
        $search = "";
        $qtd = 100;
        
        $search = $request->input('search');

        if($request->input('qtd')){
            $qtd = $request->input('qtd');
        }
        
        $string =  '%' . $search . '%';
        $lista =DB::table('news')
                ->join('channels', 'news.channels_id', '=', 'channels.id')
                ->select(
                    'news.*',
                    DB::raw('channels.name as canal'),
                    DB::raw('channels.type as tipo_canal')
                    // DB::raw('count(channels.id) as user_count')
                )
                ->where( 'title',  'LIKE',  $string )
                ->orWhere( 'channels.type',  'LIKE',  $string )
                ->orWhere( 'channels.name',  'LIKE',  $string )
                ->orderBy('data', 'desc')
                ->paginate($qtd);
                // dd($lista);
        
        $tags = DB::select('
            SELECT 
                T.title as tags_title
            FROM tags AS T
            WHERE T.status = "active"
            ORDER BY tags_title ASC
        ');

        return view($this->page_dados['prefix_auth'] .'.pages.'. $this->page_dados['route_view'] .'.index' , compact('lista','search','qtd','tags'))
                ->with('page_dados', $this->page_dados);
    }

    public function create()
    {
        $canais  = Channels::orderBy('name', 'Asc')->get();
        $tags = Tags::where( 'status',  '=','active')->orderBy('title', 'Asc')->get();
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.create', compact('canais','tags') )
                ->with('page_dados', $this->page_dados);
    }

    public function storeAjax(Request $request)
    {
        $canais  = Channels::find($request->input('channels_id'));
        $campos = [];
        if($canais){
            
            $campos = $request->all();
            $campos['hash'] = $request->input('hash');
            // dd($campos);
        }else{
            $retorno = [
                'code'         => '003',
                'error'        =>$request->input('channels_id'), 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            
            return $retorno;
        }
       
		//Validando os campos
		$validator = Validator::make( $campos , [
				'title' => 'required|max:255',
                'hash' => 'required|unique:news',
                'id_channel' => 'required',
                // 'link' => 'require',
                // 'order' => 'required',
				// 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
			],
			$messages = [
				// 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
				'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
                'title.required' => 'O campo title deve ser preenchido.',
                'id_channel.required' => 'O campo canal deve ser preenchido.',
                'hash.required' => 'O campo hash deve ser preenchido.',
                'hash.unique' => 'Essa noticia já foi cadastrada.',
                'link.required' => 'O campo link deve ser preenchido.',
                // 'order.required' => 'O campo ordem deve ser preenchido.',
			]
		);
        if ($validator->fails()) {
            $retorno = [
                'code'         => '003',
                'error'        => $validator->messages(), 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            
            return $retorno;
        }else{
            // Cadastrando um novo Registro
            $insert = new News;
            $insert->channels_id = $request->input('channels_id');
            $insert->hash = $campos['hash'];
            $insert->title = $request->input('title');
            $insert->slug = Str::slug($request->input('title'));
            $insert->description = $request->input('description');
            $insert->description_short = $request->input('description_short');
            $insert->data = $request->input('data');
            $insert->link = $request->input('link');
            $insert->keywords = $request->input('keywords');
            $insert->status = $request->input('status');
            $insert->order = $request->input('order');
            $insert->image = $request->input('image');
      
            $condition = $insert->save();
            if($condition){
                $retorno = [
                    'code'         => '001',
                    'message'        => 'Inserido com sucesso.',
                    'data'         => $insert->id ,
                    'date'         => date("Y-m-d"),
                    'hour'         => date("H:i:s"),
                ];
                
                return $retorno;
            }

            $retorno = [
                'code'         => '003',
                'message'        => 'Não possivel salvar',
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            
            return $retorno;
        }
    }


    public function store(Request $request)
    {
        $canais  = Channels::find($request->input('channels_id'));
        $tag  = Tags::find($request->input('tags_id'));
        $campos = [];
        // dd($request->all());
        if($canais && $tag){
            $campos = $request->all();
            $campos['hash'] = Str::slug($request->input('title').'-'.$canais->hash);
          
            // dd($campos);
        }else{
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/create')
                            ->withErrors(['O campo canal e tag deve ser preenchido '])
                            ->withInput();
        }
       
		//Validando os campos
		$validator = Validator::make( $campos , [
				'title' => 'required|max:255',
                'hash' => 'required|unique:news',
                'channels_id' => 'required',
                'tags_id' => 'required'
                // 'link' => 'require',
                // 'order' => 'required',
				// 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
			],
			$messages = [
				// 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
				'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
                'title.required' => 'O campo title deve ser preenchido.',
                'channels_id.required' => 'O campo canal deve ser preenchido.',
                'tags_id.required' => 'O campo Tag deve ser preenchido.',
                'hash.required' => 'O campo hash deve ser preenchido.',
                'hash.unique' => 'Essa noticia já foi cadastrada.',
                'link.required' => 'O campo link deve ser preenchido.'
                // 'order.required' => 'O campo ordem deve ser preenchido.',
			]
		);

        if ($validator->fails()) {
           
            $news = News::where( 'hash',  '=',  $campos['hash'] )->first();
                            
            if($news){
               
                $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $request->input('tags_id') )->first();
                if(!$news_tags){
                    $insert_news_tags = new NewsTags;
                    $insert_news_tags->news_id = $news->id;
                    $insert_news_tags->tags_id =  $request->input('tags_id');
                    $condition_insert_news_tags = $insert_news_tags->save();

                    if($condition_insert_news_tags){
                        return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/create')
                        ->withErrors(['Essa noticia já foi cadastrada porem a tag '.$tag->title.' foi vinculada a mesma.'])
                        ->withInput();
                    }
                }
            }
            
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/create')
            ->withErrors($validator)
            ->withInput();
        }else{
            // Cadastrando um novo Registro
            $insert = new News;
            $insert->channels_id = $request->input('channels_id');
            $insert->hash = $campos['hash'];
            $insert->title = $request->input('title');
            $insert->slug = Str::slug($request->input('title'));
            $insert->description = $request->input('description');
            $insert->description_short = $request->input('description_short');
            $insert->data = $request->input('data');
            $insert->link = $request->input('link');
            $insert->keywords = $request->input('keywords');
            $insert->status = $request->input('status');
            $insert->order = $request->input('order');
         
            //Image
            if ($request->file('image')) {
                $file = $request->file('image');
                $destinationPath = public_path().'/uploads/'. $this->page_dados['diretorio_image'] .'/';
                $filename =  date('Ymdhis'). '_' .  Str::studly($file->getClientOriginalName());
                $upload = $request->file('image')->move($destinationPath, $filename);
                $insert->image = '/uploads/'. $this->page_dados['diretorio_image'] .'/' . $filename;
            }

            $condition = $insert->save();
            if($condition){

                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $request->input('tags_id') )->first();
                            
                if(!$news_tags){
                    $insert_news_tags = new NewsTags;
                    $insert_news_tags->news_id = $insert->id;
                    $insert_news_tags->tags_id = $request->input('tags_id');
                    $insert_news_tags->save();
                }

                $request->session()->flash('message','Cadastrado com sucesso !');
            }
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler']);
        }
    }

    public function show($id)
    {

        $item = News::find($id);
        $canais  = Channels::orderBy('name', 'Asc')->get();
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.show', compact('item','uploads','canais'))
                ->with('page_dados', $this->page_dados);
    }

    public function edit($id)
    {
        $item = News::find($id);
        $canais  = Channels::orderBy('name', 'Asc')->get();
        $tags = Tags::where( 'status',  '=','active')->orderBy('title', 'Asc')->get();
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.edit', compact('item','canais','tags'))
                ->with('page_dados', $this->page_dados);
    }

    public function update(Request $request, $id)
    {
        //Validando os campos
		$validator = Validator::make($request->all(), [
                'title' => 'required|max:255',
				// 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
			],
			$messages = [
                // 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
				'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
                'title.required' => 'O campo title deve ser preenchido.',
                'hash.required' => 'O campo hash deve ser preenchido.',
			]
		);

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/'.$id.'/edit')
                    ->withErrors($validator)
                    ->withInput();
        }else{
           
            // Cadastrando um novo Registro
            $insert = News::find($id);
            $insert->channels_id = $request->input('channels_id');
            $insert->hash = $request->input('hash');
            $insert->title = $request->input('title');
            $insert->slug = Str::slug($request->input('title'));
            $insert->description = $request->input('description');
            $insert->description_short = $request->input('description_short');
            $insert->data = $request->input('data');
            $insert->link = $request->input('link');
            $insert->keywords = $request->input('keywords');
            $insert->status = $request->input('status');
            $insert->order = $request->input('order');
           
            //Image
            if ($request->file('image')) {
                //deleta o arquivo anterior
				//delete image existente
				if($insert->image){
		            $delete_arquivo1 = public_path().$insert->image;
		            File::delete($delete_arquivo1);
		        }

                $file = $request->file('image');
                $destinationPath = public_path().'/uploads/'. $this->page_dados['diretorio_image'] .'/';
                $filename =  date('Ymdhis'). '_' . Str::studly($file->getClientOriginalName());
                $upload = $request->file('image')->move($destinationPath, $filename);
                $insert->image = '/uploads/'. $this->page_dados['diretorio_image'] .'/' . $filename;
            }

            $condition = $insert->save();
            if($condition){
                $request->session()->flash('message','Editado com sucesso !');
            }
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler']);
        }
    }

    public function destroy($id)
    {

        $item = News::find($id);

        if (!$item) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler']);
        }

        if($item->image){
            $delete_arquivo2 = public_path().$item->image;
            File::delete($delete_arquivo2);
        }

        //File::delete($destination);
        $condition = $item->delete();

        if($condition){
            return 'deletado';
        }elseif($condition == false){
            return 'erro';
        }
    }
}
