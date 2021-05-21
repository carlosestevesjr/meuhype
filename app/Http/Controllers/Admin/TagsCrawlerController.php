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

use App\Tags;


class TagsCrawlerController extends Controller
{

    public function __construct()
	{
        $this->page_dados = array(
            'title' => 'Tags',
            'description' => 'Descrição',
            'route_controler' => 'tags',
            'route_view' => 'tags',
            'prefix_auth' => 'admin',
            'diretorio_aquivo' => 'arquivos',
            'diretorio_image' => 'fotos'
        );
	}

    public function index(Request $request)
    {
        $search = "";
        $qtd = 10;
        
        $search = $request->input('search');
        $qtd = $request->input('qtd');
        
        $string =  '%' . $search . '%';
        $lista = Tags::where( 'title',  'LIKE',  $string )
                        ->orderBy('title', 'Asc')
                        ->paginate($qtd);
        

        return view($this->page_dados['prefix_auth'] .'.pages.'. $this->page_dados['route_view'] .'.index' , compact('lista','search','qtd'))
                ->with('page_dados', $this->page_dados);
    }

    public function create()
    {
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.create')
                ->with('page_dados', $this->page_dados);
    }

    public function store(Request $request)
    {

		//Validando os campos
        $validator = Validator::make($request->all(), [
                'title' => 'required|max:255',
                // 'image' => 'file|required|max:500',
                // 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
            ],
            $messages = [
                // 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
                'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
                'title.unique'    => 'Esta tag já existe.',
                'title.required' => 'O campo nome deve ser preenchido.',
                // 'image.required' => 'Faça upload de uma imagem.',
            ]
        );

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/create')
                    ->withErrors($validator)
                    ->withInput();
        }else{

            // Cadastrando um novo Registro
			$insert = new Tags;
            $insert->title = $request->input('title');
            $insert->slug = Str::slug($request->input('title'));
            $insert->description = $request->input('description');
            $insert->description_short = $request->input('description_short');
            $insert->keywords = $request->input('keywords');
            $insert->order = $request->input('order');
            $insert->status = $request->input('status');

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
                $filename =  date('Ymdhis'). '_' . Str::studly( $file->getClientOriginalName());
                $upload = $request->file('image')->move($destinationPath, $filename);
                $insert->image = '/uploads/'. $this->page_dados['diretorio_image'] .'/' . $filename;
            }else{
                $insert->image = "";
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

        $item = Tags::find($id);
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.show', compact('item'))
                ->with('page_dados', $this->page_dados);
    }

    public function edit($id)
    {
        $item = Tags::find($id);
        // dd($item);
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.edit', compact('item'))
                ->with('page_dados', $this->page_dados);
    }

    public function update(Request $request, $id)
    {
        //Validando os campos
		$validator = Validator::make($request->all(), [
                'title' => 'required|max:255',
                // 'image' => 'file|required|max:500',
                // 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
            ],
            $messages = [
                // 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
                'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
                'unique'    => 'O email deve ser único.',
                'title.required' => 'O campo nome deve ser preenchido.',
                // 'image.required' => 'Faça upload de uma imagem.',
            ]
        );

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/'.$id.'/edit')
                    ->withErrors($validator)
                    ->withInput();
        }else{

            // Cadastrando um novo Registro
			$insert = Tags::find($id);
            $insert->title = $request->input('title');
            $insert->slug = Str::slug($request->input('title'));
            $insert->description = $request->input('description');
            $insert->description_short = $request->input('description_short');
            $insert->keywords = $request->input('keywords');
            $insert->order = $request->input('order');
            $insert->status = $request->input('status');
            
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
        $item = Tags::find($id);

        if (!$item) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler']);
        }

        if($item->image){
            $delete_arquivo1 = public_path().$item->image;
            File::delete($delete_arquivo1);
        }

        $condition = $item->delete();

        if($condition){
            return 'deletado';
        }elseif($condition == false){
            return 'erro';
        }
    }

}
