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
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

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
                CH.type AS channel_type
            
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
                CH.type AS channel_type
            
            FROM channels CH
            WHERE CH.status = 'active'
            $search
            ORDER BY 
                CH.name ASC
            LIMIT $inicio , $qtd
        ");  
       
        $result = $busca_channels;
        $base_route = '/api/v1/lista-channels-search';
        $v_search = str_replace(' ', '+', $v_search);
        return $this->successResponseAPI( 
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
            ,"O recurso solicitado foi processado e retornado com sucesso.", 200
        );
       
    }

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
                CH.type AS channel_type
            
            FROM channels CH
            WHERE CH.status = 'active'
            ORDER BY 
                CH.name ASC
        ");  

        $inicio = ($qtd*$page) - $qtd; 
        $numPaginas = ceil(count($busca_total_registros) / $qtd); 
        
        $busca_news = DB::select("
            SELECT 
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type
            
            FROM channels CH
            WHERE CH.status = 'active'
            ORDER BY 
                CH.name ASC
            LIMIT $inicio , $qtd
        ");  
       
        $result = $busca_news;
        $base_route = '/api/v1/lista-channels';
        return $this->successResponseAPI( 
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
            ,"O recurso solicitado foi processado e retornado com sucesso.", 200
        );
       
    }

    public function listaCanaisUser(Request $request)
    {
      
        if($request->token){
            $user = DB::table('users')->where('api_token', '=',$request->token)->first();
            
            if($user){
                $user_channels = DB::table('user_channels')->where('users_id', '=', $user->id)->get();
                $array_user_channels = [];
                foreach($user_channels as $key => $item) {
                    $array_user_channels[$key] = $item->channels_id;
                }
                $lista = Channels::query()
                            ->where('name', 'LIKE', "%{$request->busca}%") 
                            ->orderBy('name', 'Asc');
                           
                $lista = $lista->get();
              
            }else{
                $retorno =  [
                    'code'  => '999',
                    'content' => [
                                    'message' => 'Token não exite.',
                                ],
                    'date'         => date("Y-m-d"),
                    'hour'         => date("H:i:s"),
                ];
                return response()->json($retorno , 200);
            }
        }

        // dd($array_user_channels);
        foreach($lista as $key => $item) {
            $select = in_array($item->id, $array_user_channels);
            
            if($select){
                $item['select'] = 1;
            }else{
                $item['select'] = 0;
            }
        }

        if($lista){
            $retorno =  [
                'code'  => '000',
                'content' => [
                                'dados' =>  $lista, 
                            ],
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return response()->json($retorno , 200);
        }else{
            $retorno =  [
                'code'  => '000',
                'content' => [
                                'dados' =>  [], 
                            ],
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return response()->json($retorno , 200);
        }
    }

    public function postSetCanal(Request $request)
    {
        $user = DB::table('users')->where('api_token', '=',$request->input('api_token'))->first();
        if($user){
            $user_channles = DB::table('user_channels')->where('users_id', '=',$user->id)->where('channels_id', '=',$request->input('channels_id'))->first();
          
            if(!$user_channles){
                $insert = new UserChannels;
                $insert->users_id = $user->id;
                $insert->channels_id = $request->input('channels_id');
                $condition = $insert->save();
                if($condition){
                    $retorno = [
                        'code'  => '001',
                        'content' => [
                                        'message' => 'Cannal selecionado com sucesso.',
                                    ],
                        'date'         => date("Y-m-d"),
                        'hour'         => date("H:i:s"),
                    ];
                    return response()->json($retorno , 200);
                }
            }else{
                $retorno =  [
                    'code'  => '002',
                    'content' => [
                                    'message' => 'Cannal já selecionado anteriormente.',
                                ],
                    'date'         => date("Y-m-d"),
                    'hour'         => date("H:i:s"),
                ];
                return response()->json($retorno , 200);
            }
        }else{
            $retorno =  [
                'code'  => '999d',
                'content' => [
                                'message' => 'Token não exite.',
                            ],
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
        }
        return response()->json($retorno , 200);
    }

    public function postUnsetCanal(Request $request)
    {
        $user = DB::table('users')->where('api_token', '=',$request->input('api_token'))->first();
        
        if($user){
            $item = UserChannels::where('channels_id', '=', $request->channels_id)->first();
            if( $item ){
                $item_delete = UserChannels::find($item->id);
                $condition_delete = $item_delete->delete();
                if($condition_delete){
                    $retorno =  [
                        'code'  => '001',
                        'content' => [
                                        'message' => 'Deletado com sucesso.',
                                    ],
                        'date'         => date("Y-m-d"),
                        'hour'         => date("H:i:s"),
                    ];
                    return response()->json($retorno , 200);
                }
            }

            $retorno =  [
                'code'  => '999',
                'content' => [
                                'message' => 'Cannal não encontrado.',
                            ],
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return response()->json($retorno , 200);
        

        }else{
            $retorno =  [
                'code'  => '999',
                'content' => [
                                'message' => 'Token não exite.',
                            ],
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
        }
        return response()->json($retorno , 200);
    }


}
