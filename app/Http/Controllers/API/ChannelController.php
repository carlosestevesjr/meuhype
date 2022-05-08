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

    public function listaCanais(Request $request)
    {
        // $lista = DB::table('channels')->orderBy('name', 'Asc')->get();
        
        $lista = Channels::query()
                            ->where('name', 'LIKE', "%{$request->busca}%") 
                            ->orderBy('name', 'Asc')
                            ->paginate(10);

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
