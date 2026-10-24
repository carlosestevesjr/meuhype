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

        // Mantém todas as tags disponíveis e prioriza as que têm conteúdo mais quente.
        // A notícia mais recente define a ordem principal e o volume dos últimos 7 dias
        // desempata tags atualizadas na mesma data.
        $sql_tags_hotness = "
            LEFT JOIN (
                SELECT
                    N_T.tags_id,
                    MAX(N.data) AS latest_news_at,
                    COUNT(DISTINCT CASE
                        WHEN N.data >= DATE_SUB(NOW(), INTERVAL 7 DAY) THEN N.id
                    END) AS recent_news_count
                FROM news_tags N_T
                INNER JOIN news N
                    ON N.id = N_T.news_id
                    AND N.status = 'show'
                GROUP BY N_T.tags_id
            ) TAG_HOTNESS
                ON TAG_HOTNESS.tags_id = T.id
        ";
       
        $busca_total_registros = DB::select("
            SELECT 
                T.id AS tag_id
            
            FROM tags T
            WHERE T.status = 'active' 
        ");  

        $inicio = ($qtd*$page) - $qtd; 
        $numPaginas = ceil(count($busca_total_registros) / $qtd); 
    
        $busca_tags = DB::select("
            SELECT 
                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image,
                T.slug AS tag_slug,
                T.description_short AS tag_descriptionshort,
                T.imdb_url AS tag_imdb_url,
                T.imdb_rating AS tag_imdb_rating,
                T.imdb_vote_count AS tag_imdb_vote_count,
                T.imdb_popularity AS tag_imdb_popularity,
                TAG_HOTNESS.latest_news_at AS tag_latest_news_at,
                COALESCE(TAG_HOTNESS.recent_news_count, 0) AS tag_recent_news_count
               
            FROM tags T
            $sql_tags_hotness
            WHERE T.status = 'active' 
            ORDER BY 
                TAG_HOTNESS.latest_news_at DESC,
                TAG_HOTNESS.recent_news_count DESC,
                T.title ASC
            LIMIT $inicio , $qtd
        ");  
      
        if($request->input('apiToken') && $request->input('apiToken') != ""){
            // $sql_channels_users = "AND CH.id IN ($array_channels_user)"; 
            $user = DB::select("
                SELECT 
                *
                FROM users U
                WHERE U.api_token = '".$request->input('apiToken')."'
            ");  
           
            if($user){
                $user_tags = DB::table('user_tags')->where('users_id', '=', $user[0]->id)->get();
                $array_user_tags = [];
                // print_r($user_tags);
                // dd();
                foreach($user_tags as $key => $item){
                    $array_user_tags[$key] = $item->tags_id;
                }
               
                foreach($busca_tags as $key => $item) {
                    $select = in_array($item->tag_id, $array_user_tags);
                    if($select){
                        $item->select = 1;
                    }else{
                        $item->select = 0;
                    }
                }
            }
        }
        // print_r($busca_tags);
        // dd();
        $result = $busca_tags;
        $base_route = '/api/v1/lista-tags';
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

    public function tagSingle(Request $request)
    {
      
        $tag = DB::select("
            SELECT 
                *
            FROM tags T
            WHERE T.slug = '".$request->tag_id."'
        ");  
        
        return $this->ResponseAPI( 
            [
                'dados' => $tag
            ]
            ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '000'
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

        // A busca preserva a mesma relevância da lista principal de tags.
        $sql_tags_hotness = "
            LEFT JOIN (
                SELECT
                    N_T.tags_id,
                    MAX(N.data) AS latest_news_at,
                    COUNT(DISTINCT CASE
                        WHEN N.data >= DATE_SUB(NOW(), INTERVAL 7 DAY) THEN N.id
                    END) AS recent_news_count
                FROM news_tags N_T
                INNER JOIN news N
                    ON N.id = N_T.news_id
                    AND N.status = 'show'
                GROUP BY N_T.tags_id
            ) TAG_HOTNESS
                ON TAG_HOTNESS.tags_id = T.id
        ";
       
        $busca_total_registros = DB::select("
            SELECT 
                T.id AS tag_id
            
            FROM tags T
            WHERE T.status = 'active' 
            $search
        ");  

        $inicio = ($qtd*$page) - $qtd; 
        $numPaginas = ceil(count($busca_total_registros) / $qtd); 
    
        $busca_tags = DB::select("
            SELECT 
                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image,
                T.slug AS tag_slug,
                T.description_short AS tag_descriptionshort,
                T.imdb_url AS tag_imdb_url,
                T.imdb_rating AS tag_imdb_rating,
                T.imdb_vote_count AS tag_imdb_vote_count,
                T.imdb_popularity AS tag_imdb_popularity,
                TAG_HOTNESS.latest_news_at AS tag_latest_news_at,
                COALESCE(TAG_HOTNESS.recent_news_count, 0) AS tag_recent_news_count
               
            FROM tags T
            $sql_tags_hotness
            WHERE T.status = 'active' 
            $search
            ORDER BY 
                TAG_HOTNESS.latest_news_at DESC,
                TAG_HOTNESS.recent_news_count DESC,
                T.title ASC
            LIMIT $inicio , $qtd
        ");  

        if($request->input('apiToken') && $request->input('apiToken') != ""){
            // $sql_channels_users = "AND CH.id IN ($array_channels_user)"; 
            $user = DB::select("
                SELECT 
                *
                FROM users U
                WHERE U.api_token = '".$request->input('apiToken')."'
            ");  
           
            if($user){
                $user_tags = DB::table('user_tags')->where('users_id', '=', $user[0]->id)->get();
                $array_user_tags = [];
                // print_r($user_tags);
                // dd();
                foreach($user_tags as $key => $item){
                    $array_user_tags[$key] = $item->tags_id;
                }
               
                foreach($busca_tags as $key => $item) {
                    $select = in_array($item->tag_id, $array_user_tags);
                    if($select){
                        $item->select = 1;
                    }else{
                        $item->select = 0;
                    }
                }
            }
        }
        
        $result = $busca_tags;
        $base_route = '/api/v1/lista-tags-search';
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

    public function listaTagsRecentes(Request $request)
    {
       
        $qtd = 200;
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
      
        $busca_news = DB::select("
            SELECT 

                T.id AS tag_id,
                T.title AS tag_name,
                T.image AS tag_image,
                T.slug AS tag_slug,
                T.description_short AS tag_descriptionshort,
                T.status AS tag_status,
                T.imdb_url AS tag_imdb_url,
                T.imdb_rating AS tag_imdb_rating,
                T.imdb_vote_count AS tag_imdb_vote_count,
                T.imdb_popularity AS tag_imdb_popularity,
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                N.id AS news_id
            
            FROM news_tags N_T

                INNER JOIN news N 
                    ON N.id = N_T.news_id
                
                INNER JOIN channels CH 
                    ON CH.id = N.channels_id 

                INNER JOIN tags T 
                    ON T.id = N_T.tags_id
            
            WHERE N.status = 'show'
            $sql_tags_users
            $sql_channels_users
            GROUP BY N.id
            ORDER BY 
                N.data DESC, N.id DESC
            LIMIT 200
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
                T.description_short AS tag_descriptionshort

                FROM news_tags N_T 
                    INNER JOIN tags T 
                        ON N_T.tags_id = T.id

                WHERE N_T.news_id = $item->news_id 
            ");

            foreach( $busca_tags as $tagskey => $tags) {
                $array[$key]['tags'][$tagskey] = $tags;
            }
           
        }
        $collection = collect( $busca_news);
        $unique = $collection->unique('tag_id');
        $result = $unique->values()->all();
        return $this->ResponseAPI( 
            [
                "date_initial" =>  $dateInitial,
                "date_final" =>  $dateFinal,
                'dados' => $result, 
                "total" => count($result)
            ]
            ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '000'
        );
    }

    public function postSetTag(Request $request)
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
                                T.id AS id
                            FROM tags T
                            WHERE T.slug = '".$request->tags_id."'
                            LIMIT 1
                        "); 
                        
        if(count($id_paramter)> 0){
            $param_tag_id = strVal($id_paramter[0]->id);
        }else{
            $param_tag_id = 0;
        }

        if($user){
            $user_tags = DB::table('user_tags')->where('users_id', '=',$user[0]->id)->where('tags_id', '=',$param_tag_id)->first();
           
            if(!$user_tags){
                $insert = new UserTags;
                $insert->users_id = $user[0]->id;
                $insert->tags_id = $param_tag_id;
                $condition = $insert->save();
                if($condition){
                    return $this->ResponseAPI( 
                        [
                            'dados' =>[
                                'message' => 'Tag selecionado com sucesso.'
                            ], 
                        ]
                        ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '001'
                    );
                }
            }else{
                return $this->ResponseAPI( 
                    [
                        'dados' =>[
                            'message' => 'Tag já selecionado anteriormente.'
                        ], 
                    ]
                    ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '000'
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

    public function postUnsetTag(Request $request)
    {
        $user = DB::select("
            SELECT 
            *
            FROM users U
            WHERE U.api_token = '".$request->input('apiToken')."'
        ");  

        $id_paramter = DB::select("
                                    SELECT 
                                        T.id AS id
                                    FROM tags T
                                    WHERE T.slug = '".$request->tags_id."'
                                    LIMIT 1
                                "); 
            
        if(count($id_paramter)> 0){
            $param_tag_id = strVal($id_paramter[0]->id);
        }else{
            $param_tag_id = 0;
        }
        
        if($user){
            // Remove somente a seleção pertencente ao usuário autenticado.
            // Sem o filtro por users_id, o primeiro vínculo de outro usuário
            // poderia ser excluído e a seleção atual continuaria marcada.
            $item = UserTags::where('users_id', '=', $user[0]->id)
                ->where('tags_id', '=', $param_tag_id)
                ->first();
            if( $item ){
                $item_delete = UserTags::find($item->id);
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
                        'message' => 'Tag não encontrada.'
                    ], 
                ]
                ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '000'
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

    /**
     * Seleciona ou remove, em uma única operação, todas as tags ativas.
     * O filtro opcional usa o nome da tag e não fica limitado à página atual.
     */
    public function postSetAllTags(Request $request)
    {
        $validated = $request->validate([
            'apiToken' => 'required|string',
            'select' => 'required|boolean',
            'search' => 'nullable|string|max:255',
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

        $tagsQuery = DB::table('tags')->where('status', 'active');
        $search = trim((string) ($validated['search'] ?? ''));
        if ($search !== '') {
            $tagsQuery->where('title', 'like', '%' . $search . '%');
        }

        $tags = $tagsQuery->get(['id', 'slug']);
        $tagIds = $tags->pluck('id')->map(function ($id) {
            return (int) $id;
        })->all();

        DB::transaction(function () use ($user, $tagIds, $validated) {
            if (empty($tagIds)) {
                return;
            }

            if ((bool) $validated['select']) {
                $existingIds = DB::table('user_tags')
                    ->where('users_id', $user->id)
                    ->whereIn('tags_id', $tagIds)
                    ->pluck('tags_id')
                    ->map(function ($id) {
                        return (int) $id;
                    })
                    ->all();
                $missingIds = array_diff($tagIds, $existingIds);
                $now = now();
                $rows = array_map(function ($tagId) use ($user, $now) {
                    return [
                        'users_id' => $user->id,
                        'tags_id' => $tagId,
                        'created_at' => $now,
                        'updated_at' => $now,
                    ];
                }, $missingIds);
                if (!empty($rows)) {
                    DB::table('user_tags')->insert($rows);
                }
                return;
            }

            DB::table('user_tags')
                ->where('users_id', $user->id)
                ->whereIn('tags_id', $tagIds)
                ->delete();
        });

        return $this->ResponseAPI(
            [
                'dados' => [
                    'message' => (bool) $validated['select']
                        ? 'Tags selecionadas com sucesso.'
                        : 'Seleção das tags removida com sucesso.',
                    'select' => (bool) $validated['select'] ? 1 : 0,
                    'slugs' => $tags->pluck('slug')->values()->all(),
                    'total' => count($tagIds),
                ],
            ],
            'O recurso solicitado foi processado e retornado com sucesso.',
            200,
            '001'
        );
    }

}
