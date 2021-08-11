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
use DB;

use App\Crawler;
use App\Tags;
use App\Upload;

class CrawlerController extends Controller
{

    public function __construct()
	{
        $this->page_dados = array(
            'title' => 'Crawler',
            'description' => 'Descrição',
            'route_controler' => 'crawler',
            'route_view' => 'crawler',
            'prefix_auth' => 'admin',
            'diretorio_aquivo' => 'arquivos',
            'diretorio_image' => 'crawler'
        );
	}

    public function index(Request $request)
    {
        $search = "";
        $qtd = 10;
        
        $search = $request->input('search');
        if($request->input('qtd')){
            $qtd = $request->input('qtd');
        }
        
        $string =  '%' . $search . '%';
        $lista =DB::table('crawler')
                    ->where( 'crawler.title', 'LIKE', $string )
                    ->select(
                        'crawler.*',
                        (DB::raw("(SELECT tags.title FROM tags WHERE tags.id = crawler.tags_id ) AS tags_name"))
                    )
                    // ->where('tags_name', 'LIKE',  $string )
                    ->orderBy('crawler.title', 'desc')
                    ->paginate($qtd);
                    // dd($lista);

        return view($this->page_dados['prefix_auth'] .'.pages.'. $this->page_dados['route_view'] .'.index' , compact('lista','search','qtd'))
                ->with('page_dados', $this->page_dados);
    }

    public function create()
    {
        $tags = Tags::where( 'status',  '=','active')->orderBy('title', 'Asc')->get();
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.create' , compact('tags'))
                ->with('page_dados', $this->page_dados);
    }

    public function store(Request $request)
    {
		//Validando os campos
		$validator = Validator::make($request->all(), [
				'title' => 'required|max:255',
                'time_initial' => 'required|min:5',
                'type' => 'required',
               
                // 'tags_id' => 'required',
				// 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
			],
			$messages = [
                'title.required' => 'O campo titulo deve ser preenchido.',
                'time_initial.required' => 'O campo Hora Inicial deve ser preenchido.',
                'time_final.required' => 'O campo Hora Final deve ser preenchido.',
                'type.required' => 'O campo Tipo deve ser preenchido.',
				// 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
				'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
			]
		);

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/create')
                    ->withErrors($validator)
                    ->withInput();
        }else{
            // Cadastrando um novo Registro
            $insert = new Crawler;
            $insert->title = $request->input('title');
            $insert->time_initial = $request->input('time_initial');
            $insert->tags_id = $request->input('tags_id');
            $insert->description = $request->input('description');
            $insert->status = $request->input('status');
            $insert->type = $request->input('type');
            $insert->order = $request->input('order');

            $condition = $insert->save();
            if($condition){
                $request->session()->flash('message','Cadastrado com sucesso !');
            }
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler']);
        }
    }

    public function show($id)
    {

        $item = Crawler::find($id);

        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.show', compact('item'))
                ->with('page_dados', $this->page_dados);
    }

    public function edit($id)
    {
        $tags = Tags::where( 'status',  '=','active')->orderBy('title', 'Asc')->get();
        $item = Crawler::find($id);
        
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.edit', compact('item','tags'))
                ->with('page_dados', $this->page_dados);
    }

    public function update(Request $request, $id)
    {
        //Validando os campos
		$validator = Validator::make($request->all(), [
                'title' => 'required|max:255',
                'time_initial' => 'required|min:5',
                'type' => 'required',
                // 'tags_id' => 'required',
				// 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
			],
			$messages = [
                'title.required' => 'O campo titulo deve ser preenchido.',
                'time_initial.required' => 'O campo Hora Inicial deve ser preenchido.',
                'time_final.required' => 'O campo Hora Final deve ser preenchido.',
                'type.required' => 'O campo Tipo deve ser preenchido.',
                // 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
				'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
			]
		);

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/'.$id.'/edit')
                    ->withErrors($validator)
                    ->withInput();
        }else{
           
            // Cadastrando um novo Registro
            $insert = Crawler::find($id);
            $insert->title = $request->input('title');
            $insert->time_initial = $request->input('time_initial');
            $insert->tags_id = $request->input('tags_id');
            $insert->description = $request->input('description');
            $insert->status = $request->input('status');
            $insert->type = $request->input('type');
            $insert->order = $request->input('order');
           
            $condition = $insert->save();
            if($condition){
                $request->session()->flash('message','Editado com sucesso !');
            }
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler']);
        }
    }

    public function destroy($id)
    {

        $item = Crawler::find($id);

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
