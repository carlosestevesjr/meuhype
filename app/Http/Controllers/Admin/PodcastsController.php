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

use App\Podcasts;
use App\Channels;
use App\Tags;
use App\Upload;

use DB;

class PodcastsController extends Controller
{

    public function __construct()
	{
        $this->page_dados = array(
            'title' => 'Podcasts',
            'description' => 'Descrição',
            'route_controler' => 'podcasts',
            'route_view' => 'podcasts',
            'prefix_auth' => 'admin',
            'diretorio_aquivo' => 'arquivos',
            'diretorio_image' => 'podcasts'
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
        $lista =DB::table('podcasts')
                    ->join('channels', 'podcasts.channels_id', '=', 'channels.id')
                    ->select(
                        'podcasts.*',
                        DB::raw('channels.name as canal'),
                        DB::raw('channels.type as tipo_canal'),
                        DB::raw('podcasts.title as poscat_title'),
                        DB::raw('podcasts.hash as poscat_hash'),
                        DB::raw('podcasts.id as podcast_id'),
                        DB::raw('channels.id as channels_id')
                        // DB::raw('(SELECT news.hash FROM news WHERE news.hash = podcasts.hash  ) as news_hash')
                    )
                   
                    // ->select(
                    //     'news.*',
                    //     DB::raw('count(*) as user_count, status')
                    // )
                    ->where( 'podcasts.title',  'LIKE',  $string )
                    ->orWhere( 'channels.type',  'LIKE',  $string )
                    ->orWhere( 'channels.name',  'LIKE',  $string )
                    ->orderBy('podcasts.id', 'desc')
                    ->paginate($qtd);
                    // dd($lista);
        

        $tags_crauleando = DB::select('
            SELECT 
                T.title as tags_title,
                C.id as crawler_id,
                C.tags_id as crawler_tags_id,
                C.title as crawler_title
            FROM tags AS T
            JOIN crawler AS C ON C.tags_id = T.id
            WHERE C.tags_id != 0 AND C.status = "active"
            GROUP BY crawler_tags_id 
            ORDER BY tags_title ASC
        ');

        $tags = DB::select('
            SELECT 
                T.title as tags_title
            FROM tags AS T
            WHERE T.status = "active"
            ORDER BY tags_title ASC
        ');
        // dd($lista);

        return view($this->page_dados['prefix_auth'] .'.pages.'. $this->page_dados['route_view'] .'.index' , compact('lista','search','qtd','tags','tags_crauleando'))
                ->with('page_dados', $this->page_dados);
    }

    public function create()
    {
        $canais  = Podcasts::orderBy('name', 'Asc')->get();
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.create', compact('canais','hash_canais') )
                ->with('page_dados', $this->page_dados);
    }

    public function store(Request $request)
    {
        $canais  = Podcasts::find($request->input('channels_id'));
        $campos = [];
        if($canais){
            
            $campos = $request->all();
            $campos['hash'] = Str::slug($request->input('title').'-'.$canais->hash);
            // dd($campos);
        }else{
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/create')
                            ->withErrors(['O campo canal deve ser preenchido'])
                            ->withInput();
        }
       
		//Validando os campos
		$validator = Validator::make( $campos , [
				'title' => 'required|max:255',
                'hash' => 'required|unique:news',
                'id_channel' => 'require',
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
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/create')
            ->withErrors($validator)
            ->withInput();
        }else{
            // Cadastrando um novo Registro
            $insert = new Podcasts;
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
                $request->session()->flash('message','Cadastrado com sucesso !');
            }
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler']);
        }
    }

    public function show($id)
    {
        $item = Podcasts::find($id);
        $canais = Channels::orderBy('name', 'Asc')->get();
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.show', compact('item','uploads','canais'))
                ->with('page_dados', $this->page_dados);
    }

    public function edit($id)
    {
        $item = Podcasts::find($id);
        $canais  = Channels::orderBy('name', 'Asc')->get();
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.edit', compact('item','canais'))
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
            $insert = Podcasts::find($id);
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

        $item = Podcasts::find($id);

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
