<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;

use App\News;
use DB;

use Illuminate\Http\Request;

class NewsController extends Controller
{

    public function listaNews(Request $request)
    {
     
       
        $lista =DB::table('news')
                    ->join('channels', 'news.channels_id', '=', 'channels.id')
                    ->select('news.*', 'channels.name as channel', 'channels.image as channel_logo', 'channels.type as channel_type')
                    ->where('news.status', '=', 'show') 
                    ->orderBy('data', 'desc')
                    ->paginate(15);
       
        
        $array = [];
        foreach($lista->items() as $key => $item) {
            $array[$key]['new'] = $item;
            $new = News::find($item->id);
            foreach( $new->tags as $tagskey => $tags) {
                $array[$key]['tags'][$tagskey] = $tags;
            }
        }
       
        $lista = [
            'data' =>  $array, 
        ];
        
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

    public function listaNewsUser(Request $request)
    {
       
        if($request->token){

            $user = DB::table('users')->where('api_token', '=',$request->token)->first();
            if($user){
                $array_channles = [];
                $user_channels = DB::table('user_channels')->where('users_id', '=', $user->id)->get();
                $user_tags = DB::table('user_tags')->where('users_id', '=', $user->id)->get();
               
                $lista =DB::table('news')
                ->join('channels', 'news.channels_id', '=', 'channels.id')
                ->select('news.*', 'channels.name as channel', 'channels.image as channel_logo', 'channels.type as channel_type');
                
                if(count($user_channels) > 0 ){
                    $lista->where(function($query) use ($user_channels) {
                    
                        //Filtra por canais
                        foreach($user_channels as $key => $item) {
                            $array_channles[$key] = $item->channels_id;
                        }
                        $query->whereIn('channels.id', $array_channles);
                    });
                }

                if(count($user_tags) > 0 ){
                    $lista->where(function($query) use ($user_tags) {
                        //Filtra por tags
                        $array_tags = [];
                        $array_news = [];

                        foreach($user_tags as $key => $item) {
                            $news = DB::table('news_tags')->where('tags_id', '=', $item->tags_id)->get();
                            // dd($news );
                            if(count($news) > 0 ){
                                foreach($news as $key => $new) {
                                    $array_news[$key] = $new->news_id;
                                    $query->orWhere('news.id','=', $new->news_id);
                                }
                            }
                        }
                    });
                }

                // ->whereIn('channels.id', $array_channles)
                // ->whereNotIn('news.id', $array_news)
                $lista->where('news.status', '=', 'show') 
                ->orderBy('data', 'desc');

                $lista = $lista->paginate(15);
              
            }else{
                $lista =DB::table('news')
                ->join('channels', 'news.channels_id', '=', 'channels.id')
                ->select('news.*', 'channels.name as channel', 'channels.image as channel_logo', 'channels.type as channel_type');
                $lista->where('news.status', '=', 'show') 
                ->orderBy('data', 'desc');

            }

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
       
        $array = [];
        foreach($lista->items() as $key => $item) {

            $array[$key]['new'] = $item;
            $new = News::find($item->id);
        
            foreach( $new->tags as $tagskey => $tags) {
                $array[$key]['tags'][$tagskey] = $tags;
            }
        }
      
        $lista = [
            'data' =>  $array, 
        ];
        
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

    public function listaNewsTagUser(Request $request)
    {
       
        if($request->token !== "false"){

            $user = DB::table('users')->where('api_token', '=',$request->token)->first();
            if($user){
                $array_channles = [];

                $user_channels = DB::table('user_channels')->where('users_id', '=', $user->id)->get();
                $user_tags = DB::table('user_tags')->where('users_id', '=', $user->id)->where('tags_id', '=', $request->id)->get();
            
                $lista =DB::table('news')
                ->join('channels', 'news.channels_id', '=', 'channels.id')
                ->select('news.*', 'channels.name as channel', 'channels.image as channel_logo', 'channels.type as channel_type');
                
                if(count($user_channels) > 0 ){
                    $lista->where(function($query) use ($user_channels) {
                    
                        //Filtra por canais
                        foreach($user_channels as $key => $item) {
                            $array_channles[$key] = $item->channels_id;
                        }
                        $query->whereIn('channels.id', $array_channles);
                    });
                }

                if(count($user_tags) > 0 ){
                    $lista->where(function($query) use ($user_tags) {
                        //Filtra por tags
                        $array_tags = [];
                        $array_news = [];

                        foreach($user_tags as $key => $item) {
                            $news = DB::table('news_tags')->where('tags_id', '=', $item->tags_id)->get();
                            // dd($news );
                            if(count($news) > 0 ){
                                foreach($news as $key => $new) {
                                    $array_news[$key] = $new->news_id;
                                    $query->orWhere('news.id','=', $new->news_id);
                                }
                            }
                        }
                    });
                }
                
                $lista->where('news.status', '=', 'show') 
                ->orderBy('data', 'desc');

                $lista = $lista->paginate(15);
              
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

        }else{
            $lista =DB::table('news')
                ->join('channels', 'news.channels_id', '=', 'channels.id')
                ->select('news.*', 'channels.name as channel', 'channels.image as channel_logo', 'channels.type as channel_type')
                ->where('news.status', '=', 'show') ;
                
                // $lista->where(function($query) use ($user_channels) {
                    
                //     //Filtra por canais
                //     foreach($user_channels as $key => $item) {
                //         $array_channles[$key] = $item->channels_id;
                //     }
                //     $query->whereIn('channels.id', $array_channles);
                // });

                $lista->orderBy('data', 'desc')
                ->paginate(15);

        }

        $array = [];
        foreach($lista->items() as $key => $item) {

            $array[$key]['new'] = $item;
            $new = News::find($item->id);
        
            foreach( $new->tags as $tagskey => $tags) {
                $array[$key]['tags'][$tagskey] = $tags;
            }
        }
      
        $lista = [
            'data' =>  $array, 
        ];
        
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

    public function listaNewsChannelUser(Request $request)
    {
   
        if($request->token !== "false"){

            $user = DB::table('users')->where('api_token', '=',$request->token)->first();
            if($user){
                $array_channles = [];

                $user_channels = DB::table('user_channels')->where('users_id', '=', $user->id)->where('channels_id', '=', $request->id)->get();
                $user_tags = DB::table('user_tags')->where('users_id', '=', $user->id)->get();
            
                $lista =DB::table('news')
                ->join('channels', 'news.channels_id', '=', 'channels.id')
                ->select('news.*', 'channels.name as channel', 'channels.image as channel_logo', 'channels.type as channel_type');
                
                if(count($user_channels) > 0 ){
                    $lista->where(function($query) use ($user_channels) {
                    
                        //Filtra por canais
                        foreach($user_channels as $key => $item) {
                            $array_channles[$key] = $item->channels_id;
                        }
                        $query->whereIn('channels.id', $array_channles);
                    });
                }

                if(count($user_tags) > 0 ){
                    $lista->where(function($query) use ($user_tags) {
                        //Filtra por tags
                        $array_tags = [];
                        $array_news = [];

                        foreach($user_tags as $key => $item) {
                            $news = DB::table('news_tags')->where('tags_id', '=', $item->tags_id)->get();
                            // dd($news );
                            if(count($news) > 0 ){
                                foreach($news as $key => $new) {
                                    $array_news[$key] = $new->news_id;
                                    $query->orWhere('news.id','=', $new->news_id);
                                }
                            }
                        }
                    });
                }
                
                $lista->where('news.status', '=', 'show') 
                ->orderBy('data', 'desc');

                $lista = $lista->paginate(15);
              
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

        }else{
            $lista =DB::table('news')
                ->join('channels', 'news.channels_id', '=', 'channels.id')
                ->select('news.*', 'channels.name as channel', 'channels.image as channel_logo', 'channels.type as channel_type')
                ->where('news.status', '=', 'show') 
                ->where('channels.id', '=', $request->id ) 
                ->orderBy('data', 'desc')
                ->paginate(15);
        }

        $array = [];
        foreach($lista->items() as $key => $item) {

            $array[$key]['new'] = $item;
            $new = News::find($item->id);
        
            foreach( $new->tags as $tagskey => $tags) {
                $array[$key]['tags'][$tagskey] = $tags;
            }
        }
      
        $lista = [
            'data' =>  $array, 
        ];
        
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

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
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
     * @param  \App\News  $news
     * @return \Illuminate\Http\Response
     */
    public function show(News $news)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\News  $news
     * @return \Illuminate\Http\Response
     */
    public function edit(News $news)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\News  $news
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, News $news)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\News  $news
     * @return \Illuminate\Http\Response
     */
    public function destroy(News $news)
    {
        //
    }
}
