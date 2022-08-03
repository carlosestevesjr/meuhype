<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;

use Validator;
use File;
use Session;
use DB;

use App\Channels;
use App\UserChannels;

use Illuminate\Http\Request;

class ChannelController extends Controller
{

    public function listaChannels(Request $request)
    {
        // $lista = DB::table('channels')->orderBy('name', 'Asc')->get();

        $qtd =20;
        if($request->input('qtd')){
            $qtd = $request->input('qtd');
        }

        $page = 1;
        if($request->input('page')){
            $page = ($request->input('page') == 0 ) ? $request->input('page') + 1 : $request->input('page');
        }
       
        $busca_total_registros = DB::select("
            SELECT 
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                CH.slug AS channel_slug
            
            FROM channels CH
            WHERE CH.status = 'active'
            ORDER BY 
                CH.name ASC
        ");  

        $inicio = ($qtd*$page) - $qtd; 
        $numPaginas = ceil(count($busca_total_registros) / $qtd); 
        
        $busca_canais = DB::select("
            SELECT 
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                CH.slug AS channel_slug
            
            FROM channels CH
            WHERE CH.status = 'active'
            ORDER BY 
                CH.name ASC
            LIMIT $inicio , $qtd
        ");  
       
        if($request->input('apiToken') && $request->input('apiToken') != ""){
            $user = DB::select("
                SELECT 
                *
                FROM users U
                WHERE U.api_token = '".$request->input('apiToken')."'
            ");  
           
            if($user){
                $user_channels = DB::table('user_channels')->where('users_id', '=', $user[0]->id)->get();
                $array_user_channels = [];
                foreach($user_channels as $key => $item){
                    $array_user_channels[$key] = $item->channels_id;
                }
               
                foreach($busca_canais as $key => $item) {
                    $select = in_array($item->channels_id, $array_user_channels);
                    if($select){
                        $item->select = 1;
                    }else{
                        $item->select = 0;
                    }
                }
            }
        }

        $result = $busca_canais;
        $base_route = '/api/v1/lista-channels';
        return $this->ResponseAPI( 
            [
                "current_page" => $page,
                'dados' => $result, 
                "first_page_url" => url( $base_route."?page=1&qtd=".$qtd),
                "from" => ($inicio > 1) ? $inicio : $inicio + 1,
                "last_page" => $numPaginas,
                "last_page_url" => url( $base_route."?page=".$numPaginas."&qtd=".$qtd),
                "next_page_url" =>  ($page + 1 <= $numPaginas ) ? url( $base_route."?page=".($page + 1)."&qtd=".$qtd): null,
                "path" => url( $base_route),
                "per_page" => $qtd,
                "prev_page_url" => ($page > 1) ? url( $base_route."?page=".($page -1)."&qtd=".$qtd): null,
                "to" => intval($inicio) + count($result),
                "total" => count($busca_total_registros)
            ]
            ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '000'
        );
       
    }

    public function listaChannelsSearch(Request $request)
    {
        // $lista = DB::table('channels')->orderBy('name', 'Asc')->get();

        $search = "";
        $v_search = $request->input('search');
        if($request->input('search')){
            $search = "AND CH.name LIKE '%$v_search%'";
        }

        $qtd =20;
        if($request->input('qtd')){
            $qtd = $request->input('qtd');
        }

        $page = 1;
        if($request->input('page')){
            $page = ($request->input('page') == 0 ) ? $request->input('page') + 1 : $request->input('page');
        }
       
        $busca_total_registros = DB::select("
            SELECT 
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                CH.slug AS channel_slug
            
            FROM channels CH
            WHERE CH.status = 'active'
            $search
            ORDER BY 
                CH.name ASC
        ");  

        $inicio = ($qtd*$page) - $qtd; 
        $numPaginas = ceil(count($busca_total_registros) / $qtd); 
        
        $busca_channels = DB::select("
            SELECT 
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                CH.slug AS channel_slug
            
            FROM channels CH
            WHERE CH.status = 'active'
            $search
            ORDER BY 
                CH.name ASC
            LIMIT $inicio , $qtd
        "); 
        
        if($request->input('apiToken') && $request->input('apiToken') != ""){
            $user = DB::select("
                SELECT 
                *
                FROM users U
                WHERE U.api_token = '".$request->input('apiToken')."'
            ");  
           
            if($user){
                $user_channels = DB::table('user_channels')->where('users_id', '=', $user[0]->id)->get();
                $array_user_channels = [];
                foreach($user_channels as $key => $item){
                    $array_user_channels[$key] = $item->channels_id;
                }
               
                foreach($busca_channels as $key => $item) {
                    $select = in_array($item->channels_id, $array_user_channels);
                    if($select){
                        $item->select = 1;
                    }else{
                        $item->select = 0;
                    }
                }
            }
        }
       
        $result = $busca_channels;
        $base_route = '/api/v1/lista-channels-search';
        $v_search = str_replace(' ', '+', $v_search);
        return $this->ResponseAPI( 
            [
                "current_page" => $page,
                'dados' => $result, 
                "first_page_url" => url( $base_route."?page=1&qtd=".$qtd."&search=".$v_search),
                "from" => ($inicio > 1) ? $inicio : $inicio + 1,
                "last_page" => $numPaginas,
                "last_page_url" => url( $base_route."?page=".$numPaginas."&qtd=".$qtd."&search=".$v_search),
                "next_page_url" =>  ($page + 1 <= $numPaginas ) ? url( $base_route."?page=".($page + 1)."&qtd=".$qtd."&search=".$v_search): null,
                "path" => url( $base_route),
                "per_page" => $qtd,
                "prev_page_url" => ($page > 1) ? url( $base_route."?page=".($page -1)."&qtd=".$qtd."&search=".$v_search): null,
                "to" => intval($inicio) + count($result),
                "total" => count($busca_total_registros)
            ]
            ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '000'
        );
       
    }
    public function postSetCanal(Request $request)
    {
        $user = DB::select("
            SELECT 
            *
            FROM users U
            WHERE U.api_token = '".$request->input('apiToken')."'
        ");  

        //Busca id paramter
        $id_paramter = DB::select("
                            SELECT 
                                C.id AS id
                            FROM channels C
                            WHERE C.slug = '".$request->input('channels_id')."'
                            LIMIT 1
                        "); 
                        
        if(count($id_paramter)> 0){
            $param_tag_id = $id_paramter[0]->id;
        }else{
            $param_tag_id = 0;
        }
        
        if($user){
           
            $user_channles = DB::table('user_channels')->where('users_id', '=',$user[0]->id)->where('channels_id', '=', $param_tag_id )->first();
           
            if(!$user_channles){
              
                $insert = new UserChannels;
                $insert->users_id = $user[0]->id;
                $insert->channels_id = $param_tag_id;
                $condition = $insert->save();
                if($condition){
                    return $this->ResponseAPI( 
                        [
                            'dados' =>[
                                'message' => 'Cannal selecionado com sucesso.'
                            ], 
                        ]
                        ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '001'
                    );
                }
            }else{
                return $this->ResponseAPI( 
                    [
                        'dados' =>[
                            'message' => 'Cannal já foi selecionado anteriormente.'
                        ], 
                    ]
                    ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '001'
                );
            }
        }else{
            return $this->ResponseAPI( 
                [
                    'dados' =>[
                        'message' => 'Token não exite.'
                    ], 
                ]
                ,"O recurso solicitado foi processado e retornado com sucesso.", 401, '999'
            );
        }
      
    }

    public function postUnsetCanal(Request $request)
    {
        $user = DB::select("
            SELECT 
            *
            FROM users U
            WHERE U.api_token = '".$request->input('apiToken')."'
        ");  

        //Busca id paramter
        $id_paramter = DB::select("
                            SELECT 
                                C.id AS id
                            FROM channels C
                            WHERE C.slug = '".$request->input('channels_id')."'
                            LIMIT 1
                        "); 
                        
        if(count($id_paramter)> 0){
            $param_tag_id = $id_paramter[0]->id;
        }else{
            $param_tag_id = 0;
        }
        
        if($user){
            $item = UserChannels::where('channels_id', '=',$param_tag_id)->first();
            
            if( $item ){
                $item_delete = UserChannels::find($item->id);
                $condition_delete = $item_delete->delete();
                if($condition_delete){
                    return $this->ResponseAPI( 
                        [
                            'dados' =>[
                                'message' => 'Deletado com sucesso.'
                            ], 
                        ]
                        ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '001'
                    );
                }
            }

            return $this->ResponseAPI( 
                [
                    'dados' =>[
                        'message' => 'Cannal não encontrado.'
                    ], 
                ]
                ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '001'
            );
           
        }else{
            return $this->ResponseAPI( 
                [
                    'dados' =>[
                        'message' => 'Token não exite.'
                    ], 
                ]
                ,"O recurso solicitado foi processado e retornado com sucesso.", 401, '999'
            );
        }
       
    }


}
