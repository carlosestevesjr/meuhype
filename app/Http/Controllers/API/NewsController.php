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

        //Se tiver user
        $sql_channels_users = "";
        $sql_tags_users = "";

        //Caso tenha usuário
        if($request->input('apiToken') && $request->input('apiToken') != ""){
            $user = DB::select("
                SELECT 
                *
                FROM users U
                WHERE U.api_token = '".$request->input('apiToken')."'
            ");  
           
            if($user){
                //Channels User
                $busca_channels_user = DB::select("
                    SELECT 
                        UC.channels_id AS channels_id
                    FROM user_channels UC
                    WHERE UC.users_id = '".$user[0]->id."'
                ");
                
                $array_channels_user = "";
                $array_channels_user_count = count($busca_channels_user);
                
                foreach($busca_channels_user as $key => $item) {
                    if($array_channels_user_count == $key + 1){
                        $array_channels_user .= (String)$item->channels_id;
                    }else{
                        $array_channels_user .= (String)$item->channels_id.",";
                    }
                }
               
                if($array_channels_user_count > 0){
                    $sql_channels_users = "AND CH.id IN ($array_channels_user)"; 
                }
               
                //Tags Users
                $busca_tags_user = DB::select("
                    SELECT 
                        UT.tags_id AS tags_id
                    FROM user_tags UT
                    WHERE UT.users_id = '".$user[0]->id."'
                ");
               
                $array_tags_user = "";
                $array_tags_user_count = count($busca_tags_user);
                foreach($busca_tags_user as $key => $item) {
                    if($array_tags_user_count == $key + 1){
                        $array_tags_user .= (String)$item->tags_id;
                    }else{
                        $array_tags_user .= (String)$item->tags_id.",";
                    }
                }
                
                if($array_tags_user_count > 0){
                    $sql_tags_users = "AND N_T.tags_id IN ($array_tags_user)"; 
                }
                
            }
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
            $sql_tags_users
            $sql_channels_users
            GROUP BY N.id
            ORDER BY 
                N.data DESC, N.id DESC
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
            $sql_tags_users
            $sql_channels_users
            GROUP BY N.id
            ORDER BY 
                N.data DESC, N.id DESC
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
            ");

            foreach( $busca_tags as $tagskey => $tags) {
                $array[$key]['tags'][$tagskey] = $tags;
            }
           
        }
       
        $result = $array;
        $base_route = '/api/v1/lista-news';
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

        //Se tiver user
        $sql_channels_users = "";
        $sql_tags_users = "";

        //Caso tenha usuário
        if($request->input('apiToken') && $request->input('apiToken') != ""){
            $user = DB::select("
                SELECT 
                *
                FROM users U
                WHERE U.api_token = '".$request->input('apiToken')."'
            ");  
            if($user){
                //Channels User
                $busca_channels_user = DB::select("
                    SELECT 
                        UC.channels_id AS channels_id
                    FROM user_channels UC
                    WHERE UC.users_id = '".$user[0]->id."'
                ");
                $array_channels_user = "";
                $array_channels_user_count = count($busca_channels_user);
                
                foreach($busca_channels_user as $key => $item) {
                    if($array_channels_user_count == $key + 1){
                        $array_channels_user .= (String)$item->channels_id;
                    }else{
                        $array_channels_user .= (String)$item->channels_id.",";
                    }
                }
                
                if($array_channels_user_count > 0){
                    $sql_channels_users = "AND CH.id IN ($array_channels_user)"; 
                }
                
                //Tags Users
                $busca_tags_user = DB::select("
                    SELECT 
                        UT.tags_id AS tags_id
                    FROM user_tags UT
                    WHERE UT.users_id = '".$user[0]->id."'
                ");
                
                $array_tags_user = "";
                $array_tags_user_count = count($busca_tags_user);
                foreach($busca_tags_user as $key => $item) {
                    if($array_tags_user_count == $key + 1){
                        $array_tags_user .= (String)$item->tags_id;
                    }else{
                        $array_tags_user .= (String)$item->tags_id.",";
                    }
                }
                
                if($array_tags_user_count > 0){
                    $sql_tags_users = "AND N_T.tags_id IN ($array_tags_user)"; 
                }
                
            }
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
            $sql_tags_users
            $sql_channels_users
            $search
            GROUP BY N.id
            ORDER BY 
                N.data DESC, N.id DESC
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
            $sql_tags_users
            $sql_channels_users
            $search
            GROUP BY N.id
            ORDER BY 
                N.data DESC, N.id DESC
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
            ");
            foreach( $busca_tags as $tagskey => $tags) {
                $array[$key]['tags'][$tagskey] = $tags;
            }
        }
       
        $result = $array;
        $base_route = '/api/v1/lista-news-search';
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

        //Se tiver user
        $sql_channels_users = "";
        $sql_tags_users = "AND N_T.tags_id IN ($param_tag_id)";

        //Caso tenha usuário
        if($request->input('apiToken') && $request->input('apiToken') != ""){
            $user = DB::select("
                SELECT 
                *
                FROM users U
                WHERE U.api_token = '".$request->input('apiToken')."'
            ");  
            if($user){
                //Channels User
                $busca_channels_user = DB::select("
                    SELECT 
                        UC.channels_id AS channels_id
                    FROM user_channels UC
                    WHERE UC.users_id = '".$user[0]->id."'
                ");
                $array_channels_user = "";
                $array_channels_user_count = count($busca_channels_user);
                
                foreach($busca_channels_user as $key => $item) {
                    if($array_channels_user_count == $key + 1){
                        $array_channels_user .= (String)$item->channels_id;
                    }else{
                        $array_channels_user .= (String)$item->channels_id.",";
                    }
                }
                
                if($array_channels_user_count > 0){
                    $sql_channels_users = "AND CH.id IN ($array_channels_user)"; 
                }
                
                //Tags Users
                $busca_tags_user = DB::select("
                    SELECT 
                        UT.tags_id AS tags_id
                    FROM user_tags UT
                    WHERE UT.users_id = '".$user[0]->id."'
                ");
                
                $array_tags_user = "";
                $array_tags_user_count = count($busca_tags_user);
                $exist_select_tags = false;
                foreach($busca_tags_user as $key => $item) {
                    //Verifica se existe a tag nas seleções do usuário
                    if ($item->tags_id == $param_tag_id)
                    {
                        $exist_select_tags = true;
                    }
                }
                
                if((!$exist_select_tags) && $array_tags_user_count > 0){
                    $sql_tags_users = "AND N_T.tags_id IN (0)"; 
                }
               
            }
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
            $sql_channels_users
            $sql_tags_users
            GROUP BY N.id
            ORDER BY 
                N.data DESC, N.id DESC
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
            $sql_channels_users
            $sql_tags_users
            GROUP BY N.id
            ORDER BY 
                N.data DESC, N.id DESC
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
            ");
           
            foreach( $busca_tags as $tagskey => $tags) {
                $array[$key]['tags'][$tagskey] = $tags;
            }
           
        }
       
        $result = $array;
        $base_route = '/api/v1/lista-news-tag/'.$param_tag_id.'';
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

        //Se tiver user
        $sql_channels_users = "AND N.channels_id IN ($param_channel_id)";
        $sql_tags_users = "";

        //Caso tenha usuário
        if($request->input('apiToken') && $request->input('apiToken') != ""){
            $user = DB::select("
                SELECT 
                *
                FROM users U
                WHERE U.api_token = '".$request->input('apiToken')."'
            ");  
            if($user){
                //Channels User
                $busca_channels_user = DB::select("
                    SELECT 
                        UC.channels_id AS channels_id
                    FROM user_channels UC
                    WHERE UC.users_id = '".$user[0]->id."'
                ");
                $array_channels_user = "";
                $array_channels_user_count = count($busca_channels_user);
                $exist_select_channels = false;
               
                foreach($busca_channels_user as $key => $item) {
                    //Verifica se existe a channels nas seleções do usuário
                    if ($item->channels_id == $param_channel_id)
                    {
                        $exist_select_channels = true;
                    }
                   
                }
                
                if((!$exist_select_channels) && $array_channels_user_count > 0){
                    $sql_channels_users = "AND N.channels_id IN (0)"; 
                }
                
                //Tags Users
                $busca_tags_user = DB::select("
                    SELECT 
                        UT.tags_id AS tags_id
                    FROM user_tags UT
                    WHERE UT.users_id = '".$user[0]->id."'
                ");
                
                $array_tags_user = "";
                $array_tags_user_count = count($busca_tags_user);
                foreach($busca_tags_user as $key => $item) {
                    if($array_tags_user_count == $key + 1){
                        $array_tags_user .= (String)$item->tags_id;
                    }else{
                        $array_tags_user .= (String)$item->tags_id.",";
                    }
                }
                
                if($array_tags_user_count > 0){
                    $sql_tags_users = "AND N_T.tags_id IN ($array_tags_user)"; 
                }
                
            }
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
            $sql_channels_users
            $sql_tags_users
            GROUP BY N.id
            ORDER BY 
                N.data DESC, N.id DESC
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
            $sql_channels_users
            $sql_tags_users
            GROUP BY N.id
            ORDER BY 
                N.data DESC, N.id DESC
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
            ");

            foreach( $busca_tags as $tagskey => $tags) {
                $array[$key]['tags'][$tagskey] = $tags;
            }
        }
       
        $result = $array;
        $base_route = '/api/v1/lista-news-channel/'.$param_channel_id.'';
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

}
