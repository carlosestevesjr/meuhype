<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;


//Auth facade
use Auth;
use Validator;
use File;
use Session;

use App\CrawlerConfigs;
use App\Tags;
use App\Channels;
use App\Upload;


class CrawlerConfigsController extends Controller
{

    public function __construct()
	{
        $this->page_dados = array(
            'title' => 'Configurações do Crawler',
            'description' => 'Descrição',
            'route_controler' => 'crawler-configs',
            'route_view' => 'crawler_configs',
            'prefix_auth' => 'admin',
            'diretorio_aquivo' => 'arquivos',
            'diretorio_image' => 'fotos'
        );
        
	}

    public function edit($id)
    {
        $tags = Tags::where( 'status',  '=','active')->orderBy('title', 'Asc')->get();
        $channels = Channels::orderBy('name', 'Asc')->get();
        $item = CrawlerConfigs::find($id);
        
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.edit', compact('item','channels','tags'))
                ->with('page_dados', $this->page_dados);
    }

    public function update(Request $request, $id)
    {
      
        //Validando os campos
		$validator = Validator::make($request->all(), [
                'array_canais_ativos' => 'required',
                'qtd_noticias_por_canal' => 'required',
				// 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
			],
			$messages = [
                'array_canais_ativos.required' => 'O campo Canais Ativos deve ser preenchido.',
                'qtd_noticias_por_canal.required' => 'O campo Quantidade de notícias por Canal deve ser preenchido.',
                // 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
				// 'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
			]
		);
       
        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/'.$id.'/edit')
                    ->withErrors($validator)
                    ->withInput();
        }else{
          
            // Cadastrando um novo Registro
            $insert = CrawlerConfigs::find($id);
            $insert->qtd_noticias_por_canal = $request->input('qtd_noticias_por_canal');
            $insert->array_canais_ativos = $request->input('array_canais_ativos');
           
            $condition = $insert->save();
            if($condition){
                $request->session()->flash('message','Editado com sucesso !');
            }
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/'.$id.'/edit');
        }
    }
}
