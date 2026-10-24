<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;

use Validator;
use File;
use Session;
use DB;

use App\Channels;
use App\UserChannels;

use Carbon\Carbon;
use Illuminate\Http\Request;

class ChannelController extends Controller
{

    /**
     * Retorna todos os canais que publicaram notícias na data vigente.
     *
     * O período usa a quantidade de dias configurada em feed.php. As datas são
     * devolvidas para que o Reels mantenha exatamente o mesmo recorte.
     */
    public function listaChannelsVigentes(Request $request)
    {
        $request->validate([
            'days_back' => 'nullable|integer|min:0|max:365',
        ]);

        $daysBack = (int) $request->input(
            'days_back',
            config('feed.feed_dock_days_back', 3)
        );
        $today = Carbon::now(config('app.timezone'));
        $endDate = $today->toDateString();
        $startDate = $today->copy()->subDays($daysBack)->toDateString();

        $channels = DB::select("
            SELECT
                CH.id AS channels_id,
                CH.name AS channel,
                CH.image AS channel_logo,
                CH.type AS channel_type,
                CH.slug AS channel_slug,
                CH.description AS channel_description,
                CH.facebook AS channel_facebook,
                CH.instagram AS channel_instagram,
                CH.youtube AS channel_youtube,
                CH.twitter AS channel_twitter,
                MAX(N.data) AS latest_news_data,
                COUNT(DISTINCT N.id) AS news_count
            FROM channels CH
                INNER JOIN news N
                    ON N.channels_id = CH.id
                INNER JOIN news_tags N_T
                    ON N_T.news_id = N.id
            WHERE CH.status = 'active'
                AND N.status = 'show'
                AND DATE(N.data) BETWEEN ? AND ?
            GROUP BY
                CH.id,
                CH.name,
                CH.image,
                CH.type,
                CH.slug,
                CH.description,
                CH.facebook,
                CH.instagram,
                CH.youtube,
                CH.twitter
            ORDER BY
                latest_news_data DESC,
                CH.name ASC
        ", [$startDate, $endDate]);

        // Mantém a informação de canais seguidos quando há usuário autenticado.
        if ($request->filled('apiToken')) {
            $user = DB::selectOne("
                SELECT
                    U.id
                FROM users U
                WHERE U.api_token = ?
                LIMIT 1
            ", [$request->input('apiToken')]);

            if ($user) {
                $userChannels = DB::select("
                    SELECT
                        UC.channels_id
                    FROM user_channels UC
                    WHERE UC.users_id = ?
                ", [$user->id]);
                $selectedChannels = array_map(function ($item) {
                    return (int) $item->channels_id;
                }, $userChannels);

                foreach ($channels as $channel) {
                    $channel->select = in_array(
                        (int) $channel->channels_id,
                        $selectedChannels,
                        true
                    ) ? 1 : 0;
                }
            }
        }

        $baseRoute = '/api/v1/lista-channels-vigentes';
        $total = count($channels);

        return $this->ResponseAPI(
            [
                'active_date' => $endDate,
                'start_date' => $startDate,
                'end_date' => $endDate,
                'days_back' => $daysBack,
                'current_page' => 1,
                'dados' => $channels,
                'first_page_url' => url($baseRoute),
                'from' => $total > 0 ? 1 : 0,
                'last_page' => 1,
                'last_page_url' => url($baseRoute),
                'next_page_url' => null,
                'path' => url($baseRoute),
                'per_page' => $total,
                'prev_page_url' => null,
                'to' => $total,
                'total' => $total,
            ],
            'O recurso solicitado foi processado e retornado com sucesso.',
            200,
            '000'
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
                CH.type AS channel_type,
                CH.slug AS channel_slug,
                CH.description AS channel_description,
                CH.facebook AS channel_facebook,
                CH.instagram AS channel_instagram,
                CH.youtube AS channel_youtube,
                CH.twitter AS channel_twitter
               
            
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
                CH.slug AS channel_slug,
                CH.description AS channel_description,
                CH.facebook AS channel_facebook,
                CH.instagram AS channel_instagram,
                CH.youtube AS channel_youtube,
                CH.twitter AS channel_twitter
               
            
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

    public function channelSingle(Request $request)
    {
      
       
        $channel = DB::select("
            SELECT 
                *
            FROM channels  CH
            WHERE CH.slug = '".$request->channel_id."'
        ");  

        
        return $this->ResponseAPI( 
            [
                'dados' => $channel
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
                CH.slug AS channel_slug,
                CH.description AS channel_description,
                CH.facebook AS channel_facebook,
                CH.instagram AS channel_instagram,
                CH.youtube AS channel_youtube,
                CH.twitter AS channel_twitter
               
            
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
                CH.slug AS channel_slug,
                CH.description AS channel_description,
                CH.facebook AS channel_facebook,
                CH.instagram AS channel_instagram,
                CH.youtube AS channel_youtube,
                CH.twitter AS channel_twitter
               
            
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
            // Remove somente a seleção pertencente ao usuário autenticado.
            // Sem o filtro por users_id, o primeiro vínculo de outro usuário
            // poderia ser excluído e a seleção atual continuaria marcada.
            $item = UserChannels::where('users_id', '=', $user[0]->id)
                ->where('channels_id', '=', $param_tag_id)
                ->first();
            
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

    /**
     * Seleciona ou remove, em uma única operação, todos os canais ativos.
     * Quando search é informado, a alteração alcança todos os resultados da
     * busca no banco, inclusive os que ainda não foram carregados no app.
     */
    public function postSetAllCanais(Request $request)
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

        $channelsQuery = DB::table('channels')
            ->where('status', 'active');
        $search = trim((string) ($validated['search'] ?? ''));
        if ($search !== '') {
            $channelsQuery->where('name', 'like', '%' . $search . '%');
        }

        $channels = $channelsQuery->get(['id', 'slug']);
        $channelIds = $channels->pluck('id')->map(function ($id) {
            return (int) $id;
        })->all();

        DB::transaction(function () use ($user, $channelIds, $validated) {
            if (empty($channelIds)) {
                return;
            }

            if ((bool) $validated['select']) {
                $existingIds = DB::table('user_channels')
                    ->where('users_id', $user->id)
                    ->whereIn('channels_id', $channelIds)
                    ->pluck('channels_id')
                    ->map(function ($id) {
                        return (int) $id;
                    })
                    ->all();
                $missingIds = array_diff($channelIds, $existingIds);
                $now = now();
                $rows = array_map(function ($channelId) use ($user, $now) {
                    return [
                        'users_id' => $user->id,
                        'channels_id' => $channelId,
                        'created_at' => $now,
                        'updated_at' => $now,
                    ];
                }, $missingIds);
                if (!empty($rows)) {
                    DB::table('user_channels')->insert($rows);
                }
                return;
            }

            DB::table('user_channels')
                ->where('users_id', $user->id)
                ->whereIn('channels_id', $channelIds)
                ->delete();
        });

        return $this->ResponseAPI(
            [
                'dados' => [
                    'message' => (bool) $validated['select']
                        ? 'Canais selecionados com sucesso.'
                        : 'Seleção dos canais removida com sucesso.',
                    'select' => (bool) $validated['select'] ? 1 : 0,
                    'slugs' => $channels->pluck('slug')->values()->all(),
                    'total' => count($channelIds),
                ],
            ],
            'O recurso solicitado foi processado e retornado com sucesso.',
            200,
            '001'
        );
    }


}
