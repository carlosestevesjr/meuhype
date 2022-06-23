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

use App\Notifications;
use App\TokenNotification;
use App\Tags;
use App\Channels;
use App\Upload;

use DB;

class NotificationsController extends Controller
{

    public function __construct()
	{
        $this->page_dados = array(
            'title' => 'Notificações',
            'description' => 'Descrição',
            'route_controler' => 'notifications',
            'route_view' => 'notifications',
            'prefix_auth' => 'admin',
            'diretorio_aquivo' => 'arquivos',
            'diretorio_image' => 'notifications'
        );
	}

    public function notificar(Request $request)
    {
        $channels_id = $request->input('channels_id');
        $tags_id = $request->input('tags_id');
        // $canais  = Channels::where( 'status',  '=','active')->orderBy('name', 'Asc')->get();
                // $tags = Tags::where( 'status',  '=','active')->orderBy('title', 'Asc')->get();
        $id = $request->input('id');
        if($id && $id != ""){
            
            $notifications = Notifications::where( 'id', '=' ,$id)->first();
            if($notifications != null){
               
                $qtd =100;
                $page = 1;
        
                $busca_total_registros = DB::select("
                    SELECT 
                    token_notification.token
                    FROM token_notification
                ");  
        
                $numPaginas = ceil(count($busca_total_registros) / $qtd);

                for ($x = 1; $x <= $numPaginas; $x++) {
                   
                    $inicio = ($qtd*$page) - $qtd;

                    $busca_tokens = DB::select("
                        SELECT 
                        token_notification.token
                        FROM token_notification
                        LIMIT $inicio , $qtd
                    ");  

                    $array_tokens = []; 

                    foreach($busca_tokens as $item){
                        array_push($array_tokens,$item->token);
                    }
                    $array_tokens = json_encode($array_tokens);
                    echo "<br>";
                    // echo "{\r\n  \"to\":". $array_tokens.",\r\n  \"title\":\"".$notifications->title."\",\r\n  \"body\": \"".$notifications->body."\"\r\n}";
                    // echo "<br>";
                    
                    $curl = curl_init();
                    curl_setopt_array($curl, array(
                        CURLOPT_URL => "https://exp.host/--/api/v2/push/send",
                        CURLOPT_RETURNTRANSFER => true,
                        CURLOPT_ENCODING => "",
                        CURLOPT_MAXREDIRS => 10,
                        CURLOPT_TIMEOUT => 30,
                        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                        CURLOPT_CUSTOMREQUEST => "POST",
                        CURLOPT_POSTFIELDS => "{\r\n  \"to\":". $array_tokens.",\r\n  \"title\":\"".$notifications->title."\",\r\n  \"body\": \"".$notifications->body."\"\r\n}",
                        CURLOPT_HTTPHEADER => array(
                            "cache-control: no-cache",
                            "content-type: application/json",
                            "postman-token: 8882059c-4f1d-7180-d8bf-1bcdb9d45724"
                        ),
                    ));
            
                    $response = curl_exec($curl);
                    $err = curl_error($curl);
            
                    curl_close($curl);
            
                    if ($err) {
                        echo "<br>";
                        echo "cURL Error #:" . $err;
                    } else {
                        $resposta = $response;
                    
                        print_r($resposta);
                    }
                    $page = $page + 1;
                    $this->pauseTime();
                }
                
            }
            
        }else{
            return "Não existe id";
        }
        
    }

    function pauseTime() {
        $sorteio = rand(1,5);

        if($sorteio == 1){
            return usleep(3056872);
        }else if($sorteio == 2){
            return usleep(1925713);
        }else if($sorteio == 3){
            return usleep(2004567);
        }else if($sorteio == 4){
            return usleep(3354781);
        }else if($sorteio == 5){
            return usleep(1000000);
        }
    }

    public function index(Request $request)
    {
        $search = "";
        $qtd = 10;
        
        $search = $request->input('search');
        $qtd = $request->input('qtd');
        
        $string =  '%' . $search . '%';
        $lista = Notifications::where( 'title',  'LIKE',  $string )
                        ->orderBy('title', 'Asc')
                        ->paginate($qtd);
        

        return view($this->page_dados['prefix_auth'] .'.pages.'. $this->page_dados['route_view'] .'.index' , compact('lista','search','qtd'))
                ->with('page_dados', $this->page_dados);
    }

    public function create()
    {
        $canais  = Channels::orderBy('name', 'Asc')->get();
        $tags = Tags::where( 'status',  '=','active')->orderBy('title', 'Asc')->get();
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.create', compact('canais','tags') )
                ->with('page_dados', $this->page_dados);
    }

    public function store(Request $request)
    {
      
		//Validando os campos
		$validator = Validator::make($request->all(), [
                'title' => 'required|max:255',
                'body' => 'required|max:255',
                'status' => 'required',
                // 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
            ],
        $messages = [
                // 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
                'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
                'title.required' => 'O campo title deve ser preenchido.',
                'body.required' => 'O campo body deve ser preenchido.',
                'status.required' => 'O campo status deve ser preenchido.',
            ]
        );

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/create')
                    ->withErrors($validator)
                    ->withInput();
        }else{
            // Cadastrando um novo Registro
            $insert = new Notifications;
            $insert->title = $request->input('title');
            $insert->body = $request->input('body');
            $insert->channels_id = $request->input('channels_id');
            $insert->tags_id = $request->input('tags_id');
            $insert->status = $request->input('status');

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

        $item = Notifications::find($id);

        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.show', compact('item'))
                ->with('page_dados', $this->page_dados);
    }

    public function edit($id)
    {
        $item = Notifications::find($id);
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
                'body' => 'required|max:255',
                'status' => 'required',
				// 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
			],
			$messages = [
                // 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
				'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
                'title.required' => 'O campo title deve ser preenchido.',
                'body.required' => 'O campo body deve ser preenchido.',
                'status.required' => 'O campo status deve ser preenchido.',
			]
		);

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/'.$id.'/edit')
                    ->withErrors($validator)
                    ->withInput();
        }else{
           
            // Cadastrando um novo Registro
            $insert = Notifications::find($id);
            $insert->title = $request->input('title');
            $insert->body = $request->input('body');
            $insert->channels_id = $request->input('channels_id');
            $insert->tags_id = $request->input('tags_id');
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

        $item = Notifications::find($id);

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
