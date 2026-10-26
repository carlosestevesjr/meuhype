<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;

use App\News;
use Carbon\Carbon;
use DB;

use Illuminate\Http\Request;

class NewsController extends Controller
{
    /**
     * Resume os filtros de conteúdo configurados pelo usuário autenticado.
     *
     * O aplicativo usa estes totais para avisar, de forma discreta, quando a
     * lista de notícias está personalizada por tags ou canais escolhidos.
     */
    private function getAppliedFilters($apiToken)
    {
        $summary = [
            'active' => false,
            'tags_count' => 0,
            'channels_count' => 0,
        ];

        if (!$apiToken) {
            return $summary;
        }

        $user = DB::table('users')
            ->where('api_token', (string) $apiToken)
            ->first();

        if (!$user) {
            return $summary;
        }

        $summary['tags_count'] = DB::table('user_tags')
            ->where('users_id', $user->id)
            ->count();
        $summary['channels_count'] = DB::table('user_channels')
            ->where('users_id', $user->id)
            ->count();
        $summary['active'] =
            $summary['tags_count'] > 0 || $summary['channels_count'] > 0;

        return $summary;
    }

    /**
     * Retorna os IDs das notícias curtidas pelo usuário autenticado.
     */
    public function listaNewsLikes(Request $request)
    {
        $user = DB::table('users')
            ->where('api_token', (string) $request->input('apiToken'))
            ->first();

        if (!$user) {
            return $this->ResponseAPI(
                ['dados' => ['message' => 'Token não existe.']],
                'Não foi possível autenticar o usuário.',
                401,
                '999'
            );
        }

        $newsIds = DB::table('user_news_likes')
            ->where('users_id', $user->id)
            ->orderByDesc('created_at')
            ->pluck('news_id')
            ->map(function ($newsId) {
                return (int) $newsId;
            })
            ->values()
            ->all();

        return $this->ResponseAPI(
            ['dados' => $newsIds],
            'Curtidas carregadas com sucesso.',
            200,
            '000'
        );
    }

    /**
     * Registra uma curtida sem criar duplicidades para o mesmo usuário.
     */
    public function postSetNewsLike(Request $request)
    {
        return $this->updateNewsLike($request, true);
    }

    /**
     * Remove somente a curtida pertencente ao usuário autenticado.
     */
    public function postUnsetNewsLike(Request $request)
    {
        return $this->updateNewsLike($request, false);
    }

    private function updateNewsLike(Request $request, bool $selected)
    {
        $validated = $request->validate([
            'apiToken' => 'required|string',
            'news_id' => 'required|integer|exists:news,id',
        ]);

        $user = DB::table('users')
            ->where('api_token', $validated['apiToken'])
            ->first();

        if (!$user) {
            return $this->ResponseAPI(
                ['dados' => ['message' => 'Token não existe.']],
                'Não foi possível autenticar o usuário.',
                401,
                '999'
            );
        }

        if ($selected) {
            DB::table('user_news_likes')->updateOrInsert(
                [
                    'users_id' => $user->id,
                    'news_id' => (int) $validated['news_id'],
                ],
                [
                    'updated_at' => now(),
                    'created_at' => now(),
                ]
            );
        } else {
            DB::table('user_news_likes')
                ->where('users_id', $user->id)
                ->where('news_id', (int) $validated['news_id'])
                ->delete();
        }

        return $this->ResponseAPI(
            [
                'dados' => [
                    'news_id' => (int) $validated['news_id'],
                    'select' => $selected ? 1 : 0,
                ],
            ],
            $selected
                ? 'Notícia curtida com sucesso.'
                : 'Curtida removida com sucesso.',
            200,
            '001'
        );
    }


    /**
     * Lista as notícias de um canal na data vigente usada pelo FeedDock.
     *
     * O parâmetro date recebe a data final devolvida pelo FeedDock. A data
     * inicial é calculada com a quantidade configurada em feed.php.
     */
    public function listaNewsChannelVigente(Request $request)
    {
        $request->validate([
            'date' => 'nullable|date_format:Y-m-d',
            'days_back' => 'nullable|integer|min:0|max:365',
            'page' => 'nullable|integer|min:1',
            'qtd' => 'nullable|integer|min:1|max:100',
        ]);

        $daysBack = (int) $request->input(
            'days_back',
            config('feed.feed_dock_days_back', 3)
        );
        $today = Carbon::now(config('app.timezone'))->toDateString();
        $endDate = $request->input('date') ?: $today;
        $startDate = Carbon::createFromFormat('Y-m-d', $endDate)
            ->subDays($daysBack)
            ->toDateString();
        $page = (int) $request->input('page', 1);
        $qtd = (int) $request->input('qtd', 20);
        $offset = ($page - 1) * $qtd;
        $channelSlug = $request->route('channel_id');

        $totalResult = DB::selectOne("
            SELECT
                COUNT(DISTINCT N.id) AS total
            FROM news N
                INNER JOIN channels CH
                    ON CH.id = N.channels_id
                INNER JOIN news_tags N_T
                    ON N_T.news_id = N.id
            WHERE CH.status = 'active'
                AND CH.slug = ?
                AND N.status = 'show'
                AND DATE(N.data) BETWEEN ? AND ?
        ", [$channelSlug, $startDate, $endDate]);
        $total = (int) ($totalResult->total ?? 0);

        // Offset e quantidade são inteiros validados antes de compor o LIMIT.
        $news = DB::select("
            SELECT
                N.id AS news_id,
                N.title AS news_title,
                N.image AS news_image,
                N.hash AS news_hash,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                CH.slug AS channel_slug
            FROM news N
                INNER JOIN channels CH
                    ON CH.id = N.channels_id
                INNER JOIN news_tags N_T
                    ON N_T.news_id = N.id
            WHERE CH.status = 'active'
                AND CH.slug = ?
                AND N.status = 'show'
                AND DATE(N.data) BETWEEN ? AND ?
            GROUP BY
                N.id,
                N.title,
                N.image,
                N.hash,
                N.data,
                N.link,
                CH.id,
                CH.name,
                CH.image,
                CH.type,
                CH.slug
            ORDER BY
                N.data DESC,
                N.id DESC
            LIMIT $offset, $qtd
        ", [$channelSlug, $startDate, $endDate]);

        $result = [];
        foreach ($news as $key => $item) {
            $result[$key]['new'] = $item;
            $result[$key]['tags'] = DB::select("
                SELECT
                    T.id AS tag_id,
                    T.title AS tag_name,
                    T.image AS tag_image,
                    T.slug AS tag_slug,
                    T.imdb_url AS tag_imdb_url,
                    T.imdb_rating AS tag_imdb_rating,
                    T.imdb_vote_count AS tag_imdb_vote_count,
                    T.imdb_popularity AS tag_imdb_popularity
                FROM news_tags N_T
                    INNER JOIN tags T
                        ON T.id = N_T.tags_id
                WHERE N_T.news_id = ?
            ", [$item->news_id]);
        }

        $lastPage = max(1, (int) ceil($total / $qtd));
        $baseRoute = '/api/v1/lista-news-channel-vigente/'.$channelSlug;
        $dateQuery = '&date='.$endDate.'&days_back='.$daysBack;

        return $this->ResponseAPI(
            [
                'active_date' => $endDate,
                'start_date' => $startDate,
                'end_date' => $endDate,
                'days_back' => $daysBack,
                'calendar_date' => $today,
                'current_page' => $page,
                'dados' => $result,
                'first_page_url' => url($baseRoute.'?page=1&qtd='.$qtd.$dateQuery),
                'from' => $total > 0 ? $offset + 1 : 0,
                'last_page' => $lastPage,
                'last_page_url' => url($baseRoute.'?page='.$lastPage.'&qtd='.$qtd.$dateQuery),
                'next_page_url' => $page < $lastPage
                    ? url($baseRoute.'?page='.($page + 1).'&qtd='.$qtd.$dateQuery)
                    : null,
                'path' => url($baseRoute),
                'per_page' => $qtd,
                'prev_page_url' => $page > 1
                    ? url($baseRoute.'?page='.($page - 1).'&qtd='.$qtd.$dateQuery)
                    : null,
                'to' => $offset + count($result),
                'total' => $total,
            ],
            'O recurso solicitado foi processado e retornado com sucesso.',
            200,
            '000'
        );
    }

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
                N.hash AS news_hash,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                CH.slug AS channel_slug
            
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
                N.hash AS news_hash,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                CH.slug AS channel_slug
            
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
                N.data DESC, RAND(), N.id DESC
            LIMIT $inicio , $qtd
        ");  
        
        $array = [];
        foreach($busca_news as $key => $item) {
            $array[$key]['new'] = $item;
           
            $busca_tags = DB::select("
                SELECT 
                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image,
                T.slug AS tag_slug,
                T.imdb_url AS tag_imdb_url,
                T.imdb_rating AS tag_imdb_rating,
                T.imdb_vote_count AS tag_imdb_vote_count,
                T.imdb_popularity AS tag_imdb_popularity

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
                'filters_applied' => $this->getAppliedFilters($request->input('apiToken')),
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
                N.hash AS news_hash,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                CH.slug AS channel_slug
            
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
                N.hash AS news_hash,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                CH.slug AS channel_slug
            
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
                T.image AS tag_image,
                T.slug AS tag_slug,
                T.imdb_url AS tag_imdb_url,
                T.imdb_rating AS tag_imdb_rating,
                T.imdb_vote_count AS tag_imdb_vote_count,
                T.imdb_popularity AS tag_imdb_popularity

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
                'filters_applied' => $this->getAppliedFilters($request->input('apiToken')),
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
        //Busca id paramter
        $id_paramter = DB::select("
                            SELECT 
                                T.id AS id
                            FROM tags T
                            WHERE T.slug = '".$param_tag_id."'
                            LIMIT 1
                        "); 
                        
        if(count($id_paramter)> 0){
            $param_tag_id = strVal($id_paramter[0]->id);
        }else{
            $param_tag_id = 0;
        }
        
        $qtd = 15;
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
                N.hash AS news_hash,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                CH.slug AS channel_slug
            
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
                N.hash AS news_hash,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                CH.slug AS channel_slug
               
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
                N.data DESC, RAND(), N.id DESC
            LIMIT $inicio , $qtd
        ");  
       
        $array = [];
        
        foreach($busca_news as $key => $item) {
            $array[$key]['new'] = $item;
           
            $busca_tags = DB::select("
                SELECT 
                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image,
                T.slug AS tag_slug,
                T.imdb_url AS tag_imdb_url,
                T.imdb_rating AS tag_imdb_rating,
                T.imdb_vote_count AS tag_imdb_vote_count,
                T.imdb_popularity AS tag_imdb_popularity

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
                'filters_applied' => $this->getAppliedFilters($request->input('apiToken')),
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

        //Busca id paramter
        $id_paramter = DB::select("
                            SELECT 
                                C.id AS id
                            FROM channels C
                            WHERE C.slug = '".$param_channel_id."'
                            LIMIT 1
                        "); 
                        
        if(count($id_paramter)> 0){
            $param_channel_id = strVal($id_paramter[0]->id);
        }else{
            $param_channel_id = 0;
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
                N.hash AS news_hash,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                CH.slug AS channel_slug
            
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
                N.hash AS news_hash,
                N.data AS news_data,
                N.link AS news_link,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                CH.slug AS channel_slug
            
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
                N.data DESC, RAND(), N.id DESC
            LIMIT $inicio , $qtd
        ");  
       
        $array = [];
        foreach($busca_news as $key => $item) {
            $array[$key]['new'] = $item;
           
            $busca_tags = DB::select("
                SELECT 
                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image,
                T.slug AS tag_slug,
                T.imdb_url AS tag_imdb_url,
                T.imdb_rating AS tag_imdb_rating,
                T.imdb_vote_count AS tag_imdb_vote_count,
                T.imdb_popularity AS tag_imdb_popularity

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
                'filters_applied' => $this->getAppliedFilters($request->input('apiToken')),
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

}
