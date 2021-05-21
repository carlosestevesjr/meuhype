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

use App\Admin;

class AdminController extends Controller
{
    protected $redirectPath = '/admin';
    public function __construct()
	{
        $this->page_dados = array(
            'title' => 'Usuários Administradores',
            'description' => 'Descrição',
            'route_controler' => 'admins',
            'route_view' => 'admins',
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
        $lista = Admin::where( 'name',  'LIKE',  $string )
                        ->orWhere( 'email',  'LIKE',  $string )
                        ->orderBy('name', 'Asc')
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
        if($request->input('password') == $request->input('password_confirmation')){
            $validator = Validator::make($request->all(), [
                    'name' => 'required|max:255',
                    'email' => 'required|email|max:255|unique:admins',
                    'password' => 'min:6|required_with:password_confirmation|same:password_confirmation',
                    'password_confirmation' => 'min:6',
                    // 'image' => 'file|required|max:500',
                    // 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
                ],
                $messages = [
                    // 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
                    'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
                    'unique'    => 'O email deve ser único.',
                    'name.required' => 'O campo nome deve ser preenchido.',
                    'email.required' => 'O campo email deve ser preenchido.',
                    'password.required' => 'O campo senha deve ser preenchido.',
                    'password_confirmation.required' => 'O campo confirmar senha deve ser preenchido.',
                    // 'image.required' => 'Faça upload de uma imagem.',
                ]
            );
        }else{
            $request->session()->flash('message','Senha e password estão diferentes!');
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/create')
                ->withInput();
        }

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/create')
                    ->withErrors($validator)
                    ->withInput();
        }else{
            // Cadastrando um novo Registro
			$insert = new Admin;
            $insert->name = $request->input('name');
            $insert->email = $request->input('email');
            $insert->password = bcrypt($request->input('password'));
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

        $item = Admin::find($id);
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.show', compact('item'))
                ->with('page_dados', $this->page_dados);
    }

    public function edit($id)
    {
        $item = Admin::find($id);
        // dd($item);
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.edit', compact('item'))
                ->with('page_dados', $this->page_dados);
    }

    public function update(Request $request, $id)
    {
        //Validando os campos
		$validator = Validator::make($request->all(), [
                'name' => 'required|max:255',
                // 'email' => 'required|email|max:255|unique:admins',
                // 'password' => 'required|min:6|confirmed',
                // 'image' => 'file|required|max:500',
				// 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
			],
			$messages = [
                // 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
                'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
                'unique'    => 'O email deve ser único.',
                'name.required' => 'O campo nome deve ser preenchido.',
                'email.required' => 'O campo email deve ser preenchido.',
                'image.required' => 'Faça upload de uma imagem.',
			]
		);

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/'.$id.'/edit')
                    ->withErrors($validator)
                    ->withInput();
        }else{
            // Cadastrando um novo Registro
			$insert = Admin::find($id);
            $insert->name = $request->input('name');
            // $insert->email = $request->input('email');
            $insert->status = $request->input('status');
            // $insert->password = bcrypt($request->input('password'));

            //Image
            // dd($request) ;

            if ($request->file('image')) {
                //deleta o arquivo anterior
				//delete image existente
				if($insert->image){
		            $delete_arquivo1 = public_path().$insert->image;
		            File::delete($delete_arquivo1);
		        }
                $file = $request->file('image');
                $destinationPath = public_path().'/uploads/'. $this->page_dados['diretorio_image'] .'/';
                $filename =  date('Ymdhis'). '_' .Str::studly($file->getClientOriginalName());
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
        $item = Admin::find($id);

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
