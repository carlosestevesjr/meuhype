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
        $qtd =15;
        if($request->input('qtd')){
            $qtd = $request->input('qtd');
        }

        $page = 1;
        if($request->input('page')){
            $page = ($request->input('page') == 0 ) ? $request->input('page') + 1 : $request->input('page');
        }
       
        $busca_total_registros = DB::select("
            SELECT 
                N.id AS news_id
                
            FROM news N
                INNER JOIN channels CH 
                    ON CH.id = N.channels_id 
            
            WHERE N.status = 'show' 
            ORDER BY 
                N.data DESC, N.title ASC
        ");  

        $inicio = ($qtd*$page) - $qtd; 
        $numPaginas = ceil(count($busca_total_registros) / $qtd); 
        
        $busca_news = DB::select("
            SELECT 
                N.id AS news_id,
                N.title AS news_title,
                N.image AS news_image,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type

            FROM news N
                INNER JOIN channels CH 
                    ON CH.id = N.channels_id 
            
            WHERE N.status = 'show'
            ORDER BY 
                N.data DESC, N.id ASC
            LIMIT $inicio , $qtd
        ");  
       
        $array = [];
        foreach($busca_news as $key => $item) {
            $array[$key]['new'] = $item;
           
            $busca_tags = DB::select("
                SELECT 
                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image

                FROM news_tags N_T 
                    INNER JOIN tags T 
                        ON N_T.tags_id = T.id

                WHERE N_T.news_id = $item->news_id 
                GROUP BY N_T.news_id	
            ");

            foreach( $busca_tags as $tagskey => $tags) {
                $array[$key]['tags'][$tagskey] = $tags;
            }
           
        }
       
        $result = $array;
        $base_route = '/api/v1/lista-news';
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

    public function listaNewsSearch(Request $request)
    {
        $qtd =15;
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
            $search = "AND N.title LIKE '%$v_search%'";
        }
       
        $busca_total_registros = DB::select("
            SELECT 
                N.id AS news_id,
                N.title AS news_title,
                N.image AS news_image,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type
            
            FROM news N
                INNER JOIN channels CH 
                    ON CH.id = N.channels_id 
            
            WHERE N.status = 'show'
            $search
            ORDER BY 
                N.data DESC, N.id ASC
        ");  

        $inicio = ($qtd*$page) - $qtd; 
        $numPaginas = ceil(count($busca_total_registros) / $qtd); 
        
        $busca_news = DB::select("
            SELECT 
                N.id AS news_id,
                N.title AS news_title,
                N.image AS news_image,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type
               
            FROM news N
                INNER JOIN channels CH 
                    ON CH.id = N.channels_id 
            
            WHERE N.status = 'show'
            $search
            ORDER BY 
                N.data DESC, N.id ASC
            LIMIT $inicio , $qtd
        ");  
       
        $array = [];

       
        foreach($busca_news as $key => $item) {
            $array[$key]['new'] = $item;
            
            $busca_tags = DB::select("
                SELECT 
                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image

                FROM news_tags N_T 
                    INNER JOIN tags T 
                        ON N_T.tags_id = T.id

                WHERE N_T.news_id = $item->news_id 
                GROUP BY N_T.news_id	
            ");
            foreach( $busca_tags as $tagskey => $tags) {
                $array[$key]['tags'][$tagskey] = $tags;
            }
        }
       
        $result = $array;
        $base_route = '/api/v1/lista-news-search';
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

    public function listaNewsTag(Request $request)
    {
        $param_tag_id ="";
        if($request->tag_id){
            $param_tag_id = $request->tag_id;
        }

        $qtd =15;
        if($request->input('qtd')){
            $qtd = $request->input('qtd');
        }

        $page = 1;
        if($request->input('page')){
            $page = ($request->input('page') == 0 ) ? $request->input('page') + 1 : $request->input('page');
        }
       
        $busca_total_registros = DB::select("
            SELECT 
                N.id AS news_id,
                N.title AS news_title,
                N.image AS news_image,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type
            
            FROM news_tags N_T

                INNER JOIN news N 
                    ON N.id = N_T.news_id
                
                INNER JOIN channels CH 
                    ON CH.id = N.channels_id 
            
            WHERE N.status = 'show'
            AND N_T.tags_id IN ($param_tag_id)
            ORDER BY 
                N.data DESC, N.id ASC
        ");  

        $inicio = ($qtd*$page) - $qtd; 
        $numPaginas = ceil(count($busca_total_registros) / $qtd); 
        
        $busca_news = DB::select("
            SELECT 
                N.id AS news_id,
                N.title AS news_title,
                N.image AS news_image,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type
               
            FROM news_tags N_T

                INNER JOIN news N 
                    ON N.id = N_T.news_id
                
                INNER JOIN channels CH 
                    ON CH.id = N.channels_id 
            
            WHERE N.status = 'show'
            AND N_T.tags_id IN ($param_tag_id)
            ORDER BY 
                N.data DESC, N.id ASC
            LIMIT $inicio , $qtd
        ");  
       
        $array = [];
        foreach($busca_news as $key => $item) {
            $array[$key]['new'] = $item;
           
            $busca_tags = DB::select("
                SELECT 
                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image

                FROM news_tags N_T 
                    INNER JOIN tags T 
                        ON N_T.tags_id = T.id

                WHERE N_T.news_id = $item->news_id 
                GROUP BY N_T.news_id	
            ");

            foreach( $busca_tags as $tagskey => $tags) {
                $array[$key]['tags'][$tagskey] = $tags;
            }
        }
       
        $result = $array;
        $base_route = '/api/v1/lista-news-tag/'.$param_tag_id.'';
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
                            // echo $item->tags_id;

                            // dd($item);
                            // dd($news );
                            if(count($news) > 0 ){
                                foreach($news as $key => $new) {
                                    $array_news[$key] = $new->news_id;
                                    $query->orWhere('news.id','=', $new->news_id);
                                }
                                // $query->whereIn('news.id', $array_news);
                            }else{
                                $query->whereIn('news.id', [0]);
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

    public function listaNewsChannel(Request $request)
    {

        $param_channel_id ="";
        if($request->channel_id){
            $param_channel_id = $request->channel_id;
        }

        $qtd =15;
        if($request->input('qtd')){
            $qtd = $request->input('qtd');
        }

        $page = 1;
        if($request->input('page')){
            $page = ($request->input('page') == 0 ) ? $request->input('page') + 1 : $request->input('page');
        }
       
        $busca_total_registros = DB::select("
            SELECT 
                N.id AS news_id,
                N.title AS news_title,
                N.image AS news_image,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type
            
            FROM news N
                INNER JOIN channels CH 
                    ON CH.id = N.channels_id 
            
            WHERE N.status = 'show'
            AND N.channels_id IN ($param_channel_id)
            ORDER BY 
                N.data DESC, N.id ASC
        ");  

        $inicio = ($qtd*$page) - $qtd; 
        $numPaginas = ceil(count($busca_total_registros) / $qtd); 
        
        $busca_news = DB::select("
            SELECT 
                N.id AS news_id,
                N.title AS news_title,
                N.image AS news_image,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type
               
            FROM news N
                INNER JOIN channels CH 
                    ON CH.id = N.channels_id 
            
            WHERE N.status = 'show'
            AND N.channels_id IN ($param_channel_id)
            ORDER BY 
                N.data DESC, N.id ASC
            LIMIT $inicio , $qtd
        ");  
       
        $array = [];
        foreach($busca_news as $key => $item) {
            $array[$key]['new'] = $item;
           
            $busca_tags = DB::select("
                SELECT 
                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image

                FROM news_tags N_T 
                    INNER JOIN tags T 
                        ON N_T.tags_id = T.id

                WHERE N_T.news_id = $item->news_id 
                GROUP BY N_T.news_id	
            ");

            foreach( $busca_tags as $tagskey => $tags) {
                $array[$key]['tags'][$tagskey] = $tags;
            }
        }
       
        $result = $array;
        $base_route = '/api/v1/lista-news-channel/'.$param_channel_id.'';
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

        return 
        $lista =DB::table('news')
        ->join('channels', 'news.channels_id', '=', 'channels.id')
        ->select('news.*', 'channels.name as channel', 'channels.image as channel_logo', 'channels.type as channel_type');
        $news_tags = DB::table('news_tags')->where('tags_id', '=', $request->id)->get();
        $user = DB::table('users')->where('api_token', '=',$request->token)->first();
        if($user){
            $user_channels = DB::table('user_channels')->where('users_id', '=', $user->id)->get();
            $user_tags = DB::table('user_tags')->where('users_id', '=', $user->id)->where('tags_id', '=', $request->id)->get();

        }else{
            $user_channels = 0;
            $user_tags = 0;
        }
       
        if(($request->token !== "false") && (count($user_channels) > 0 && count($user_tags) > 0 )){
             
            //Se o usuário selecionar Tags e não canais
            if(count($user_channels) <= 0 ){
                // dd('sdasdsd');
                $lista->where(function($query) use ($user_channels, $request) {
                    $array_channles = [];
                    //Filtra por canais
                    $query->orWhere('channels.id','=', $request->id);
                });
                
                $lista->where(function($query) use ($news_tags) {
                    
                    //Filtra por tags
                    $array_news = [];
                    foreach($news_tags as $key => $item) {
                        $array_news[$key] = $item->news_id;
                        $query->orWhere('news.id','=', $item->news_id);
                    }
                    
                    // $query->whereIn('news.id', $array_news);

                });
                
                $lista = $lista->where('news.status', '=', 'show') 
                ->orderBy('data', 'desc')->paginate(15);
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

                $retorno =  [
                    'code'  => '000',
                    'content' => [
                                    'dados' =>  $lista, 
                                ],
                    'date'         => date("Y-m-d"),
                    'hour'         => date("H:i:s"),
                ];
                return response()->json($retorno , 200);

            }else {
                
                $lista->where(function($query) use ($user_channels, $request) {
                    $array_channles = [];
                    //Filtra por canais
                    $query->orWhere('channels.id', $request->id);
                });

                $lista->where(function($query) use ( $news_tags, $request) {
                    //Filtra por tags
                    $array_tags = [];
                    $array_news = [];
                    // dd($news_tags);
                    foreach($news_tags as $key => $item) {
                        $array_news[$key] = $item->news_id;
                        $query->orWhere('news.id','=', $item->news_id);
                    }
                    // $query->whereIn('news.id', $array_news);
                });

                $lista = $lista->where('news.status', '=', 'show') 
                ->orderBy('data', 'desc')->paginate(15);
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

                $retorno =  [
                    'code'  => '000',
                    'content' => [
                                    'dados' =>  $lista, 
                                ],
                    'date'         => date("Y-m-d"),
                    'hour'         => date("H:i:s"),
                ];
                return response()->json($retorno , 200);
            }
        

        }else{

            $lista->where(function($query) use ($request) {
                $array_channles = [];
                //Filtra por canais
                $query->orWhere('channels.id', $request->id);
            });

            $lista = $lista->where('news.status', '=', 'show') 
            ->orderBy('data', 'desc')->paginate(15);
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
            $retorno =  [
                'code'  => '000',
                'content' => [
                                'dados' =>  $lista, 
                            ],
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return response()->json($retorno , 200);

        }
    }

}
