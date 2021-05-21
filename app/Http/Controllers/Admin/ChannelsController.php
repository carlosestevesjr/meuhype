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

use App\Channels;
use App\Upload;

class ChannelsController extends Controller
{

    public function __construct()
	{
        $this->page_dados = array(
            'title' => 'Canal',
            'description' => 'Descrição',
            'route_controler' => 'channels',
            'route_view' => 'channels',
            'prefix_auth' => 'admin',
            'diretorio_aquivo' => 'arquivos',
            'diretorio_image' => 'channels'
        );
	}

    public function index(Request $request)
    {
        $search = "";
        $qtd = 10;
        
        $search = $request->input('search');
        $qtd = $request->input('qtd');
        
        $string =  '%' . $search . '%';
        $lista = Channels::where( 'name',  'LIKE',  $string )
                        ->orWhere( 'type',  'LIKE',  $string )
                        ->orderBy('name', 'Asc')
                        ->paginate($qtd);
        

        return view($this->page_dados['prefix_auth'] .'.pages.'. $this->page_dados['route_view'] .'.index' , compact('lista','search','qtd'))
                ->with('page_dados', $this->page_dados);
    }

    public function create()
    {
       
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.create' )
                ->with('page_dados', $this->page_dados);
    }

    public function store(Request $request)
    {
      
		//Validando os campos
		$validator = Validator::make($request->all(), [
				'name' => 'required|max:255',
                'order' => 'required',
                // 'hash' => 'required|unique:channels',
				// 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
			],
			$messages = [
				// 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
				'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
                'name.required' => 'O campo nome deve ser preenchido.',
                'hash.required' => 'O campo hash deve ser preenchido.',
                'order.required' => 'O campo ordem deve ser preenchido.',
			]
		);

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/create')
                    ->withErrors($validator)
                    ->withInput();
        }else{
            // Cadastrando um novo Registro
            $insert = new Channels;
            $insert->hash = $request->input('hash');
            $insert->name = $request->input('name');
            $insert->slug = Str::slug($request->input('name'));
            $insert->description = $request->input('description');
            $insert->description_short = $request->input('description_short');
            $insert->type = $request->input('type');
            $insert->facebook = $request->input('facebook');
            $insert->twitter = $request->input('twitter');
            $insert->instagram = $request->input('instagram');
            $insert->youtube = $request->input('youtube');
            $insert->link = $request->input('link');
            $insert->url_crawler = $request->input('url_crawler');
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

        $item = Channels::find($id);

        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.show', compact('item','uploads'))
                ->with('page_dados', $this->page_dados);
    }

    public function edit($id)
    {
        $item = Channels::find($id);
        
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.edit', compact('item'))
                ->with('page_dados', $this->page_dados);
    }

    public function update(Request $request, $id)
    {
        //Validando os campos
		$validator = Validator::make($request->all(), [
                'name' => 'required|max:255',
                'order' => 'required',
                'hash' => 'required',
				// 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
			],
			$messages = [
                // 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
				'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
                'name.required' => 'O campo nome deve ser preenchido.',
                'hash.required' => 'O campo hash deve ser preenchido.',
                'order.required' => 'O campo ordem deve ser preenchido.',
			]
		);

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/'.$id.'/edit')
                    ->withErrors($validator)
                    ->withInput();
        }else{
           
            // Cadastrando um novo Registro
            $insert = Channels::find($id);
            $insert->name = $request->input('name');
            $insert->hash = $request->input('hash');
            $insert->slug = Str::slug($request->input('name'));
            $insert->description = $request->input('description');
            $insert->description_short = $request->input('description_short');
            $insert->type = $request->input('type');
            $insert->facebook = $request->input('facebook');
            $insert->twitter = $request->input('twitter');
            $insert->instagram = $request->input('instagram');
            $insert->youtube = $request->input('youtube');
            $insert->link = $request->input('link');
            $insert->url_crawler = $request->input('url_crawler');
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

        $item = Channels::find($id);

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
