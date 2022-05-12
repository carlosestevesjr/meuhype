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
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function listaTags(Request $request)
    {
        // $lista = DB::table('channels')->orderBy('name', 'Asc')->get();
        
        $lista = Tags::query()
                        // ->where('title', 'LIKE', "%{$request->busca}%") 
                        ->where('status', '=', "active") 
                        ->orderBy('title', 'Asc')
                        // ->limit(15)
                        ->paginate(25);

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
        // dd( $lista);
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


    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Channel  $channel
     * @return \Illuminate\Http\Response
     */
    public function show(Channel $channel)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Channel  $channel
     * @return \Illuminate\Http\Response
     */
    public function edit(Channel $channel)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Channel  $channel
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Channel $channel)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Channel  $channel
     * @return \Illuminate\Http\Response
     */
    public function destroy(Channel $channel)
    {
        //
    }
}
