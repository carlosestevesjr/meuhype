<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;


//Auth facade
use Auth;
use Validator;
use File;
use Session;

use App\Page;
use App\Upload;

class PageController extends Controller
{

    public function __construct()
	{
        $this->page_dados = array(
            'title' => 'Páginas',
            'description' => 'Descrição',
            'route_controler' => 'pages',
            'route_view' => 'pages',
            'prefix_auth' => 'admin',
            'diretorio_aquivo' => 'arquivos',
            'diretorio_image' => 'fotos'
        );
	}


    public function index()
    {
        $lista = Page::get();
        return view($this->page_dados['prefix_auth'] .'.pages.'. $this->page_dados['route_view'] .'.index' , compact('lista'))
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
                'description' => 'required',
                'description_short' => 'required',
				'keywords' => 'required',
                'order' => 'required',
				// 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
			],
			$messages = [
				// 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
				'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
				'title.required' => 'O campo titulo deve ser preenchido.',
				'description.required' => 'O campo descrição deve ser preenchido.',
				'description_short.required' => 'O campo descrição curta deve ser preenchido.',
                'order.required' => 'O campo ordem deve ser preenchido.',
                'keywords.required' => 'O campo keywords deve ser preenchido.',
			]
		);

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/create')
                    ->withErrors($validator)
                    ->withInput();
        }else{
            // Cadastrando um novo Registro
			$insert = new Page;
            $insert->title = $request->input('title');
            $insert->slug = str_slug($request->input('title'));
			$insert->description = $request->input('description');
			$insert->description_short = $request->input('description_short');
			$insert->keywords = $request->input('keywords');
			$insert->status = $request->input('status');
            $insert->order = $request->input('order');

            //Image
            if ($request->file('image')) {
                $file = $request->file('image');
                $destinationPath = public_path().'/uploads/'. $this->page_dados['diretorio_image'] .'/';
                $filename =  date('Ymdhis'). '_' . studly_case($file->getClientOriginalName());
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

        $item = Page::find($id);
        $uploads = Upload::where('id_modulo', $item->id)->where('modulo', $this->page_dados['route_controler']  )->orderBy('id','DESC')->get();

        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.show', compact('item','uploads'))
                ->with('page_dados', $this->page_dados);
    }

    public function edit($id)
    {
        $item = Page::find($id);
        $uploads = Upload::where('id_modulo', $item->id)->where('modulo', $this->page_dados['route_controler'])->orderBy('id','DESC')->get();
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.edit', compact('item','uploads'))
                ->with('page_dados', $this->page_dados);
    }

    public function update(Request $request, $id)
    {
        //Validando os campos
		$validator = Validator::make($request->all(), [
				'title' => 'required|max:255',
                'description' => 'required',
                'description_short' => 'required',
				// 'image' => 'file|required|max:500',
                // 'image-capa' => 'file|required|max:500',
				'keywords' => 'required',
                'order' => 'required',
				// 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
			],
			$messages = [
				// 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
				'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
				'title.required' => 'O campo titulo deve ser preenchido.',
				'description.required' => 'O campo descrição deve ser preenchido.',
				'description_short.required' => 'O campo descrição curta deve ser preenchido.',
				// 'image.required' => 'Faça upload de uma imagem.',
                // 'image-capa.required' => 'Faça upload de uma imagem de capa.',
                'keywords.required' => 'O campo keywords deve ser preenchido.',
                'order.required' => 'O campo ordem deve ser preenchido.',
			]
		);

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/'.$id.'/edit')
                    ->withErrors($validator)
                    ->withInput();
        }else{
            // Cadastrando um novo Registro
			$insert = Page::find($id);
            $insert->title = $request->input('title');
            $insert->slug = str_slug($request->input('title'));
			$insert->description = $request->input('description');
			$insert->description_short = $request->input('description_short');
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
                $filename =  date('Ymdhis'). '_' . studly_case($file->getClientOriginalName());
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

        $item = Page::find($id);

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
