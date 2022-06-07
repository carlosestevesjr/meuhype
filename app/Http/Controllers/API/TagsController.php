<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;

use Validator;
use File;
use Session;
use DB;

use App\Tags;
use App\UserTags;

use Illuminate\Http\Request;

class TagsController extends Controller
{
  
    public function listaTags(Request $request)
    {

        $qtd = 15;
        if($request->input('qtd')){
            $qtd = $request->input('qtd');
        }

        $page = 1;
        if($request->input('page')){
            $page = ($request->input('page') == 0 ) ? $request->input('page') + 1 : $request->input('page');
        }
       
        $busca_total_registros = DB::select("
            SELECT 
                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image
            
            FROM tags T
            WHERE T.status = 'active' 
            ORDER BY 
                T.title ASC
        ");  

        $inicio = ($qtd*$page) - $qtd; 
        $numPaginas = ceil(count($busca_total_registros) / $qtd); 
    
        $busca_tags = DB::select("
            SELECT 
                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image
               
            FROM tags T
            WHERE T.status = 'active' 
            ORDER BY 
                T.title ASC
            LIMIT $inicio , $qtd
        ");  
        
        $result = $busca_tags;
        $base_route = '/api/v1/lista-tags';
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

    public function listaTagsSearch(Request $request)
    {

        $qtd = 15;
        if($request->input('qtd')){
            $qtd = $request->input('qtd');
        }

        $page = 1;
        if($request->input('page')){
            $page = ($request->input('page') == 0 ) ? $request->input('page') + 1 : $request->input('page');
        }

        $search = "";
        $v_search = $request->input('search');
        if($request->input('search')){
            $search = "AND T.title LIKE '%$v_search%'";
        }
       
        $busca_total_registros = DB::select("
            SELECT 
                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image
            
            FROM tags T
            WHERE T.status = 'active' 
            $search
            ORDER BY 
                T.title ASC
        ");  

        $inicio = ($qtd*$page) - $qtd; 
        $numPaginas = ceil(count($busca_total_registros) / $qtd); 
    
        $busca_tags = DB::select("
            SELECT 
                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image
               
            FROM tags T
            WHERE T.status = 'active' 
            $search
            ORDER BY 
                T.title ASC
            LIMIT $inicio , $qtd
        ");  
        
        $result = $busca_tags;
        $base_route = '/api/v1/lista-tags-search';
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

    public function listaTagsRecentes(Request $request)
    {
       
        $qtd = 1000;
        if($request->input('qtd')){
            $qtd = $request->input('qtd');
        }
       
        $dateInitial = date("Y-m-d");
        if($request->input('dateInitial') && $request->input('dateInitial') != ""){
            $dateInitial = $request->input('dateInitial');
        }

        $dateFinal = date('Y-m-d', strtotime("-60 day", strtotime($dateInitial)));
        if($request->input('dateFinal') && $request->input('dateFinal') != ""){
            $dateFinal = $request->input('dateFinal');
        }

        $busca_tags_recentes = DB::select("
            SELECT 
                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image,
                T.status AS tag_status,
                T.status AS tag_status
            
            FROM tags T
                INNER JOIN news_tags N_T 
                    ON T.id = N_T.tags_id 
                INNER JOIN news N
                    ON N_T.news_id = N.id 
            
            WHERE T.status = 'active' 
            AND N.data BETWEEN '$dateFinal' AND '$dateInitial'
            ORDER BY 
                 N.data DESC, N.id ASC
            LIMIT $qtd
        ");  

        $collection = collect( $busca_tags_recentes);
        $unique = $collection->unique('tag_name');
        $result = $unique->values()->all();
        
        return $this->successResponseAPI( 
            [
                "date_initial" =>  $dateInitial,
                "date_final" =>  $dateFinal,
                'dados' => $result, 
                "total" => count($result)
            ]
            ,"O recurso solicitado foi processado e retornado com sucesso.", 200
        );
    }

    public function listaTagsUser(Request $request)
    {
        
        if($request->token){
            $user = DB::table('users')->where('api_token', '=',$request->token)->first();
            if($user){
                $user_tags = DB::table('user_tags')->where('users_id', '=', $user->id)->get();
                $array_user_tags = [];
                foreach($user_tags as $key => $item) {
                    $array_user_tags[$key] = $item->tags_id;
                }
               
                $lista = Tags::query()
                            ->where('title', 'LIKE', "%{$request->busca}%") 
                            ->where('status', '=', "active") 
                            ->orderBy('title', 'Asc');
                          
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

        foreach($lista as $key => $item) {
            $select = in_array($item->id, $array_user_tags);
            
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

    public function postSetTag(Request $request)
    {
        $user = DB::table('users')->where('api_token', '=',$request->input('api_token'))->first();
        if($user){
            $user_tags = DB::table('user_tags')->where('users_id', '=',$user->id)->where('tags_id', '=',$request->input('tags_id'))->first();
          
            if(!$user_tags){
                $insert = new UserTags;
                $insert->users_id = $user->id;
                $insert->tags_id = $request->input('tags_id');
                $condition = $insert->save();
                if($condition){
                    $retorno = [
                        'code'  => '001',
                        'content' => [
                                        'message' => 'Tag selecionado com sucesso.',
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
                                    'message' => 'Tag já selecionado anteriormente.',
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

    public function postUnsetTag(Request $request)
    {
        $user = DB::table('users')->where('api_token', '=',$request->input('api_token'))->first();
        
        if($user){
            $item = UserTags::where('tags_id', '=', $request->tags_id)->first();
            if( $item ){
                $item_delete = UserTags::find($item->id);
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
                                'message' => 'Tag não encontrado.',
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
