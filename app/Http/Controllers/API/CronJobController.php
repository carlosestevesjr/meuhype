<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Support\Str;

use Illuminate\Http\Request;
use Alaouy\Youtube\Facades\Youtube;
use Twitter;
use Spotify;

use Validator;

use App\News;
use App\NewsTags;
use App\Crawler;
use App\Channels;
use App\Podcasts;
use App\Tags;
use DB;

class CronJobController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function index()
    {

        $arrayResults = [
                            'Omelete_Site'       => $this->buscaNewsOmeleteSite(),
                            'Jovem_Nerd_Site'    => $this->buscaNewsJovemNerdSite(),
                            'Super_Oito_Youtube' => $this->buscaNewsSuperOitoYoutube(),
                            'Jovem_Nerd_Youtube' => $this->buscaNewsJovemNerdYoutube(),
                            'Omelete_Youtube'    => $this->buscaNewsOmeleteYoutube(),
                            'Pipocando_Youtube'  => $this->buscaNewsPipocandoYoutube(),
                            'Ei_Nerd_Youtube'    => $this->buscaNewsEiNerdYoutube(),
                            'Nerd_Land_Youtube'  => $this->buscaNewsNerdLandYoutube(),
                            'Cinema_Com_Rapadura_Youtube' => $this->buscaCinemaComRapaduraYoutube(),
                            'Caique_Izoton_Youtube' => $this->buscaCaiqueIzotonYoutube(),
                            'Caverna_Do_Caruso_Youtube'  => $this->buscaCavernaDoCarusoYoutube(),
                            'Quatro_Coisas_Youtube'  => $this->buscaQuatroCoisasYoutube(),
                            'Operacao_Cinema_Youtube'  =>  $this->buscaOperacaoCinemaYoutube(),
                            'Nerd_Rabugento_Youtube'  =>  $this->buscaNerdRabugentoYoutube(),
                            'Heranca_Nerd_Youtube'  => $this->buscaHerancaNerdYoutube(),
                            'Cris_Panda_Youtube'  => $this->buscaCrisPandaYoutube(),
                            'Nerd_Experience_Youtube'  => $this->buscaNerdExperienceYoutube(),
                            'Caldeirao_Nerd_Youtube'  => $this->buscaCaldeiraoNerdYoutube(),
                            'Arena_Nerd_Youtube'  => $this->buscaArenaNerdYoutube(),
                            'Sessao_Nerd_Youtube'  => $this->buscaSessaoNerdYoutube(),
                            'Nerd_News_Youtube'  => $this->buscaNerdNewsYoutube(),
                            'Thiago_Romariz_Youtube'  => $this->buscaThiagoRomarizYoutube(),
                            'Gustavo_Cunha_Youtube'  => $this->buscaGustavoCunhaYoutube(),
                            'Miguel_Lokia_Youtube'  => $this->buscaMiguelLokiaYoutube(),
                            'Entre_Migas_Youtube'  => $this->buscaEntreMigasYoutube(),
                            'Jovem_Nerd_Spotify' => $this->buscaNewsJovemNerdSpotify(),
                            'Cinema_Com_Rapadura_Spotify' => $this->buscaNewsCinemaComRapaduraSpotify(),
                            
                        ];
        
        return response()->json($arrayResults , 200);
        // $this->formata_data(1,'20 de abril de 2021');
        //$this->formata_data(3,'2018-01-15T22:00:57Z');
        
       
    }

    public function buscaThiagoRomarizYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'thiagoromarizyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UC-_T97zvbTtXSQI9nVlOFrQ', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-thiago-romariz-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-thiago-romariz-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-thiago-romariz-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-thiago-romariz-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-thiago-romariz-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-thiago-romariz-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-thiago-romariz-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaEntreMigasYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'entremigasyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCX9AkKp_kixtLvIILx2EewA', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-entre-migas-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-entre-migas-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-entre-migas-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-entre-migas-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-entre-migas-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-entre-migas-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-entre-migas-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaMiguelLokiaYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'miguellokiayoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCP_Hxwf6ajGjPsMw0a8rnLQ', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-miguel-lokia-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-miguel-lokia-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-miguel-lokia-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-miguel-lokia-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-miguel-lokia-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-miguel-lokia-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-miguel-lokia-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaGustavoCunhaYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'gustavocunhayoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCfUE4aSsJSOmeGcnwue9TnQ', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-gustavo-cunha-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-gustavo-cunha-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-gustavo-cunha-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-gustavo-cunha-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-gustavo-cunha-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-gustavo-cunha-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-gustavo-cunha-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }
    
    public function buscaNerdNewsYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'nerdnewsyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCSozvJtG0HiPFuVyaIty2rw', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-nerd-news-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-nerd-news-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-nerd-news-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-nerd-news-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-nerd-news-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-nerd-news-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-nerd-news-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaSessaoNerdYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'sessaonerdyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCmGD63MyNLl3niTac686-XQ', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-sessao-nerd-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-sessao-nerd-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-sessao-nerd-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-sessao-nerd-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-sessao-nerd-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-sessao-nerd-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-sessao-nerd-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaArenaNerdYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'arenanerdyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCTvRce47EoHn6hIVd-H1Ggg', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-arena-nerd-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-arena-nerd-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-arena-nerd-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-arena-nerd-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-arena-nerd-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-arena-nerd-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-arena-nerd-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaCaldeiraoNerdYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'caldeiraonerdyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCkhfuyQUD5GNulpQRJOqrGg', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-caldeirao-nerd-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-caldeirao-nerd-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-caldeirao-nerd-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-caldeirao-nerd-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-caldeirao-nerd-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-caldeirao-nerd-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-caldeirao-nerd-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaNerdExperienceYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'nerdexperienceyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UC2TIV0LAfVRaFy1FihRhwyw', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-nerd-experience-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-nerd-experience-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-nerd-experience-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-nerd-experience-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-nerd-experience-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-nerd-experience-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-nerd-experience-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaCrisPandaYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'crispandayoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCIg-4NeNrY0DMUORXFmaNQw', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-cris-panda-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-cris-panda-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-cris-panda-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-cris-panda-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-cris-panda-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-cris-panda-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-cris-panda-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaHerancaNerdYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'herancanerdyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCFklwULD0GH0awMkBJNflvw', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-heranca-nerd-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-heranca-nerd-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-heranca-nerd-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-heranca-nerd-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-heranca-nerd-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-heranca-nerd-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-heranca-nerd-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaNerdRabugentoYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'nerdrabugentoyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UClXazpjDAA6sA6dFzWXQ_lw', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-nerd-rabugento-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-nerd-rabugento-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-nerd-rabugento-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-nerd-rabugento-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-nerd-rabugento-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-nerd-rabugento-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-nerd-rabugento-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaOperacaoCinemaYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'operacaocinemayoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCT-QobdGYczKTSuWAQbQFAA', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-operacao-cinema-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-operacao-cinema-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-operacao-cinema-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-operacao-cinema-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-operacao-cinema-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-operacao-cinema-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-operacao-cinema-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaQuatroCoisasYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'quatrocoisasyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCMn_W4pe7msJS77koaT96gg', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-quatro-coisas-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-quatro-coisas-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-quatro-coisas-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-quatro-coisas-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-quatro-coisas-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-quatro-coisas-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-quatro-coisas-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaCavernaDoCarusoYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'cavernadocarusoyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCAKA2kEF00INrjkrs-HIqmA', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-caverna-do-caruso-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-caverna-do-caruso-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-caverna-do-caruso-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-caverna-do-caruso-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-caverna-do-caruso-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-caverna-do-caruso-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-caverna-do-caruso-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaCaiqueIzotonYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'caiqueizotonyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UC3ucQfyGEXYlYFucvR87vyQ', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-caique-izoton-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-caique-izoton-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-caique-izoton-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-caique-izoton-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-caique-izoton-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-caique-izoton-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-caique-izoton-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaCinemaComRapaduraYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'cinemacomrapadurayoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCurl4RJpmlVmUJUiTWyGWAA', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-cinema-com-rapadura-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-cinema-com-rapadura-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-cinema-com-rapadura-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-cinema-com-rapadura-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-cinema-com-rapadura-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-cinema-com-rapadura-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-cinema-com-rapadura-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaNewsNerdLandYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'nerdlandyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCevaIHgjRXaYX3S6uQY8rig', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-nerdland-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {
                    
                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-nerdland-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }

                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-nerdland-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-nerdland-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-nerdland-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-nerdland-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-nerdland-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaNewsEiNerdYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'einerdyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCt_4wzTQqmcUvemNkeO0plA', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-einerd-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {
                    
                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-einerd-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }

                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-einerd-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-einerd-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-einerd-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-einerd-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-einerd-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaNewsPipocandoYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'pipocandoyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCBFLqK7PAP9DQ3JpIrWFI7wQ', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-pipocando-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-pipocando-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }
    
                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-pipocando-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-pipocando-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-pipocando-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-pipocando-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-pipocando-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaNewsOmeleteYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'omeleteyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCaSAM5kna2KyX-uVLSGr8PQ', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-omelete-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {
                    
                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-omelete-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }

                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-omelete-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-omelete-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-omelete-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-omelete-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-omelete-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaNewsJovemNerdYoutube(){
        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'jovemnerdyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                        ->where( 'status', '=', 'active' )
                        ->where( 'tags_id', '!=', 0 )
                        ->whereBetween('time_initial', [$hora, $hora_30])
                        // ->orWhereBetween('time_final', [$hora, $hora_30])
                        ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
            // dd($url);
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        $activities = Youtube::searchChannelVideos($url, 'UCmEClzCBDx-vrt0GuSKBd9g', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-jovemnerd-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {
                    
                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-jovemnerd-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }

                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-jovemnerd-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                      
                        
                        if($this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-jovemnerd-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-jovemnerd-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt);
        
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-jovemnerd-youtube')
                                );
                            }
    
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-jovemnerd-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaNewsSuperOitoYoutube(){

        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'superoitoyoutube' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                            ->where( 'status', '=', 'active' )
                            ->where( 'tags_id', '!=', 0 )
                            ->whereBetween('time_initial', [$hora, $hora_30])
                            // ->orWhereBetween('time_final', [$hora, $hora_30])
                            ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count == 1){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->first();
                    if($tag ){
                        $url = $tag->title ;
                        // echo $url;
                    }
                }
                $count++;
            }
        }
       
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
        
        $activities = Youtube::searchChannelVideos($url, 'UCE8deXi-Eea3SuEV1Q1L4ug', 5);
        // $activities = Youtube::getActivitiesByChannelId('UCmEClzCBDx-vrt0GuSKBd9g');
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        if($activities){
            foreach($activities as $item){
    
                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item->snippet->title.'-superoito-youtube')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );
               
                if ($validator->fails()) {
                    
                    $news = News::where( 'hash',  '=', Str::slug($item->snippet->title.'-superoito-youtube') )->first();
                            
                    if($news){
                        $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                        
                        if(!$news_tags){
                            $insert_news_tags = new NewsTags;
                            $insert_news_tags->news_id = $news->id;
                            $insert_news_tags->tags_id = $tag->id;
                            $insert_news_tags->save();
                        }
                    }

                    // Validation 
                    array_push(
                        $array_existentes,
                        Str::slug($item->snippet->title.'-superoito-youtube')
                    );
                   
                }else{
    
                    $img = "";
                    $link ="";
    
                    if(!empty($item->snippet->thumbnails)){
                        if(!empty($item->snippet->thumbnails->maxres->url)){
                            $img = $item->snippet->thumbnails->maxres->url;
                        }else if(!empty($item->snippet->thumbnails->standard->url)){
                            $img = $item->snippet->thumbnails->standard->url;
                        }else if(!empty($item->snippet->thumbnails->high->url)){
                            $img = $item->snippet->thumbnails->high->url;
                        }else if(!empty($item->snippet->thumbnails->medium->url)){
                            $img = $item->snippet->thumbnails->medium->url;
                        }else{
                            $img = $item->snippet->thumbnails->default->url;
                        }
                    }
    
                    if(!empty($item->id->videoId)){
                        $link = 'https://www.youtube.com/watch?v='.$item->id->videoId;
                    }
                   
                    if($img != "" && $link != ""){
                        
                        if( $this->validaNoticia( $tag->title, $this->removeEmoji($item->snippet->title) )){
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug($this->removeEmoji($item->snippet->title)).'-superoito-youtube'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);
    
                            $insert = new News;
                            $insert->title = $this->removeEmoji($item->snippet->title);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item->snippet->title);
                            $insert->hash = Str::slug($item->snippet->title.'-superoito-youtube');
                            $insert->link = $link;
                            $insert->image = '/uploads/news/' . $filename;
                            $insert->status = "show";
                            $insert->order = 0;
                    
                            $insert->data = $this->formata_data(3, $item->snippet->publishedAt) ;
                           
                            $condition = $insert->save();
                            if($condition){

                                $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                                if(!$news_tags){
                                    $insert_news_tags = new NewsTags;
                                    $insert_news_tags->news_id = $insert->id;
                                    $insert_news_tags->tags_id = $tag->id;
                                    $insert_news_tags->save();
                                }

                                array_push(
                                    $array_adicionados,
                                    $insert->id.' '.Str::slug($item->snippet->title.'-superoito-youtube')
                                );
                            }
                        }
                        
                        
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item->snippet->title.'-superoito-youtube')
                        );
                    }
                }
            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];

        return $retorno;
    }

    public function buscaNewsJovemNerdSite(){

        $channel = Channels::where( 'hash',  '=', 'jovemnerdsite' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                            ->where( 'status', '=', 'active' )
                            ->where( 'tags_id', '!=', 0 )
                            ->whereBetween('time_initial', [$hora, $hora_30])
                            // ->orWhereBetween('time_final', [$hora, $hora_30])
                            ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
                        // echo $url;
                    }
                }
                $count++;
            }
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }

        // var_dump( $url );
        // $url = "https://jovemnerd.com.br/bunker/categoria/filmes/";

        $result = $this->getHtml($url);
        preg_match_all('/card-post -rowdesktop">(?P<artigo>[\s\S]*?)(<\/article>)/', $result, $matches);
        $result = [];
        foreach ($matches['artigo'] as $key => $value) {
            preg_match_all('/(<h2)[\s\S]*?(class="title">)[\s\S]*?(<a)[\s\S]*?(href=")(?P<url>[\s\S]*?)(">)(?P<noticia>[\s\S]+?)(<\/a>)/', $value, $matche);
            $result['url'] = $matche['url'][0];
            $result['noticia'] = trim($matche['noticia'][0]) ;
            preg_match_all('/(<img)[\s\S]*?(src\=")(?P<imagem>[\s\S]*?)(")/', $value, $matche);
            $result['img'] = $matche['imagem'][0];
            preg_match_all('/(<time)[\s\S](class="postedon">)(?P<data>[\s\S]*?)(<\/time>)/', $value, $matche);
            $result['data'] = trim($matche['data'][0]) ;
            $return['content'][] = $result;
        }

        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-jovemnerdsite')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-jovemnerdsite') )->first();
                            
                if($news){
                    $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                    
                    if(!$news_tags){
                        $insert_news_tags = new NewsTags;
                        $insert_news_tags->news_id = $news->id;
                        $insert_news_tags->tags_id = $tag->id;
                        $insert_news_tags->save();
                    }
                }

                // Validation 
                array_push(
                    $array_existentes,
                    Str::slug($item['noticia'].'-jovemnerdsite')
                );
            }else{

                $img = "";
                $link = "";
                $data = "";

                if($item['img']){
                    $img = $item['img'];
                }

                if($item['url']){
                    $link = $item['url'];
                }

                if($item['data']){
                    $data = $item['data'];
                }
                if($img != "" && $link != ""){
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        //Baixa imagem
                        $file =$img;
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-jovemnerdsite'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-jovemnerdsite');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $this->formata_data(1, trim($data));
                        $condition = $insert->save();
                        if($condition){
                            
                            $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                            if(!$news_tags){
                                $insert_news_tags = new NewsTags;
                                $insert_news_tags->news_id = $insert->id;
                                $insert_news_tags->tags_id = $tag->id;
                                $insert_news_tags->save();
                            }

                            array_push(
                                $array_adicionados,
                                $insert->id.' '.Str::slug($item['noticia'].'-jovemnerdsite')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-jovemnerdsite')
                    );
                }
            }
        }

        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros, 
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];
        return $retorno;
    }

    public function buscaNewsOmeleteSite(){

        $channel = Channels::where( 'hash',  '=', 'omeletesite' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            $hora = date('H:i:s');
            $hora_30 = date('H:i:s', strtotime('+30 minute', strtotime($hora)));
            // echo $hora;
            // echo "<br>";
            // echo $hora_30;
            $crawlers = DB::table('crawler')
                            ->where( 'status', '=', 'active' )
                            ->where( 'tags_id', '!=', 0 )
                            ->whereBetween('time_initial', [$hora, $hora_30])
                            // ->orWhereBetween('time_final', [$hora, $hora_30])
                            ->get();
            $count = 1;
            foreach ($crawlers as $key => $value) {
                // echo "crawler";
                if($count){
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
                        // echo $url;
                    }
                }
                $count++;
            }
        }
        // echo 'url:'.$url;
        if($url == ""){
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
       
        // $url = "https://www.omelete.com.br/filmes";

        $result = $this->getHtml($url);
       
        preg_match_all('/article class="col(?P<artigo>[\s\S]*?)(<\/article>)/', $result, $matches);

        $result = [];
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];
        // dd($matches['artigo'] );
        foreach ($matches['artigo'] as $key => $value) {
            preg_match_all('/(<h2>)[\s\S]*?(?P<noticia>[\s\S]*?)(<\/h2>)/', $value, $matche_noticia);
            $result['noticia'] = $matche_noticia['noticia'];
            preg_match_all('/(<a href=")(?P<link>[\s\S]*?)(" class="analytic-featured")/', $value, $matche_link);
            $link =  $matche_link['link'];
            $result['link'] = $matche_link['link'];
            preg_match_all('/(<img)[\s\S]*?(data-lazy-src\=")(?P<imagem>[\s\S]*?)(")/', $value, $matche_img);
            $result['img'] = $matche_img['imagem'];
            preg_match_all('/(mark__time">)(?P<data>[\s\S]*?)(<\/div>)/', $value, $matche_data);
            $result['data'] = str_replace(" ","",str_replace("\n","",$matche_data['data']));
            $return['content'][] = $result;
        }
       
        // return false ;
        foreach($return['content'] as $item){
            
            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'][0].'-omeletesite')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-omeletesite') )->first();
                            
                if($news){
                    $news_tags = NewsTags::where( 'news_id',  '=',  $news->id )->where( 'tags_id',  '=', $tag->id )->first();
                    
                    if(!$news_tags){
                        $insert_news_tags = new NewsTags;
                        $insert_news_tags->news_id = $news->id;
                        $insert_news_tags->tags_id = $tag->id;
                        $insert_news_tags->save();
                    }
                }

                // Validation 
                array_push(
                    $array_existentes,
                    Str::slug($item['noticia'][0].'-omeletesite')
                );
               
            }else{

                $img = "";
                $link = "";
                $data = "";

                if($item['img']){
                    $img = 'https:'.$item['img'][0];
                }

                if($item['link']){
                    $link = "https://www.omelete.com.br".$item['link'][0];
                }

                if($item['data']){
                    $data = $item['data'][0];
                }

               
                if($img != "" && $link != ""){
                    
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia'][0]) )){
                        //Baixa imagem
                        $file =$img;
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'][0])).'-omeletesite'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia'][0]);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia'][0]);
                        $insert->hash = Str::slug($item['noticia'][0].'-omeletesite');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                
                        $insert->data =  $this->formata_data(2, trim($data));
                        $condition = $insert->save();
                        if($condition){

                            $news_tags = NewsTags::where( 'news_id',  '=',  $insert->id )->where( 'tags_id',  '=', $tag->id )->first();
                            
                            if(!$news_tags){
                                $insert_news_tags = new NewsTags;
                                $insert_news_tags->news_id = $insert->id;
                                $insert_news_tags->tags_id = $tag->id;
                                $insert_news_tags->save();
                            }

                            array_push(
                                $array_adicionados,
                                $insert->id.' '.Str::slug($item['noticia'][0].'-omeletesite')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'][0].'-omeletesite')
                    );
                }
            }
        }

        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros, 
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];
        return $retorno;
    }
    
    public function buscaNewsCinemaComRapaduraSpotify(){

        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'cinemacomrapaduraspotify' )->firstOrFail();
        $url = "";
       
        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
          
        }else{
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
       
        // Search episodes by query.
        // Search shows by query.
        $podcasts = Spotify::show('0kof6vwnq6i1zlvbh9lwsY')->market('BR')->get();
        // dd($podcasts['episodes']);
        // dd($podcasts['episodes']['items']);
        foreach ($podcasts['episodes']['items'] as $key => $podcast) {

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($podcast['name'].'-cinema-com-rapadura-spotify')], [
                    'hash' => 'required|unique:podcasts',
                ],
                $messages = [
                    'unique'    => 'Podcast já existe.',
                ]
            );
        
            if ($validator->fails()) {

                // Validation 
                array_push(
                    $array_existentes,
                    Str::slug($podcast['name'].'-cinema-com-rapadura-spotify')
                );
            
            }else{
                $insert = new Podcasts;
                $insert->title = $this->removeEmoji($podcast['name']);
                $insert->channels_id = $channel->id;
                $insert->slug = Str::slug($podcast['name']);
                $insert->hash = Str::slug($podcast['name'].'-cinema-com-rapadura-spotify');
                $insert->link = $podcast['external_urls']['spotify'];
                $insert->image = $podcast['images'][1]['url'];
                $insert->status = "show";
                $insert->order = 0;
                
                $insert->data = $podcast['release_date'];

                $condition = $insert->save();
                if($condition){
                    array_push(
                        $array_adicionados,
                        $insert->id.' '.Str::slug($podcast['name'].'-cinema-com-rapadura-spotify')
                    );
                }

            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];
        return $retorno;
    }

    public function buscaNewsJovemNerdSpotify(){

        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'jovemnerdspotify' )->firstOrFail();
        $url = "";

        $array_adicionados = [];
        $array_existentes = [];
        $array_erros = [];

        if($channel){
            
        }else{
            $retorno = [
                'code'         => '003',
                'adicionados'  => $array_adicionados, 
                'existentes'   => $array_existentes, 
                'erros'        => $array_erros, 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return $retorno;
        }
       
        // Search episodes by query.
        // Search shows by query.
        $podcasts = Spotify::show('22Wgt4ASeaw8mmoqAWNUn1')->market('BR')->get();
        // dd($podcasts['episodes']);
        // dd($podcasts['episodes']['items']);
        foreach ($podcasts['episodes']['items'] as $key => $podcast) {

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($podcast['name'].'-jovemnerd-spotify')], [
                    'hash' => 'required|unique:podcasts',
                ],
                $messages = [
                    'unique'    => 'Podcast já existe.',
                ]
            );
        
            if ($validator->fails()) {

                // Validation 
                array_push(
                    $array_existentes,
                    Str::slug($podcast['name'].'-jovemnerd-spotify')
                );
            
            }else{
                $insert = new Podcasts;
                $insert->title = $this->removeEmoji($podcast['name']);
                $insert->channels_id = $channel->id;
                $insert->slug = Str::slug($podcast['name']);
                $insert->hash = Str::slug($podcast['name'].'-jovemnerd-spotify');
                $insert->link = $podcast['external_urls']['spotify'];
                $insert->image = $podcast['images'][1]['url'];
                $insert->status = "show";
                $insert->order = 0;
                
                $insert->data = $podcast['release_date'];

                $condition = $insert->save();
                if($condition){
                    array_push(
                        $array_adicionados,
                        $insert->id.' '.Str::slug($podcast['name'].'-jovemnerd-spotify')
                    );
                }

            }
        }
        
        $retorno = [
            'code'         => '000',
            'adicionados'  => $array_adicionados, 
            'existentes'   => $array_existentes, 
            'erros'        => $array_erros,
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
        ];
        return $retorno;
    }

    public function getHtml($url) {

        $context = stream_context_create(
            array(
                "http" => array(
                    "header" => "User-Agent: ".$this->getRandAgent()
                )
            )
        );

        return file_get_contents($url, false, $context);
    }

    public function getRandAgent() {

            $agents = ['Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',
            'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36',
            'Mozilla/5.0 (Windows NT 5.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36',
            'Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36',
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36',
            'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',
            'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',
            'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',
            # Firefox
            'Mozilla/4.0 (compatible; MSIE 9.0; Windows NT 6.1)',
            'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko',
            'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)',
            'Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko',
            'Mozilla/5.0 (Windows NT 6.2; WOW64; Trident/7.0; rv:11.0) like Gecko',
            'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko',
            'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.0; Trident/5.0)',
            'Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko',
            'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)',
            'Mozilla/5.0 (Windows NT 6.1; Win64; x64; Trident/7.0; rv:11.0) like Gecko',
            'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0)',
            'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)',
            'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)'];

            return $agents[rand(0, count($agents)-1)];
    }

    // /**
    //  * Display the specified resource.
    //  *
    //  * @param  int  $id
    //  * @return \Illuminate\Http\Response
    //  */
    // public function show(Request $request)
    // {
    //     $noticias =DB::table('news')
    //                     ->join('channels', 'news.channels_id', '=', 'channels.id')
    //                     ->join('movies', 'news.movies_id', '=', 'movies.id')
    //                     ->select('news.*', 'channels.name as channel', 'channels.image as channel_logo', 'movies.title as movie_title')
    //                     ->orderBy('created_at', 'desc')
    //                     ->paginate(15);
       
    //     return response()->json($noticias , 200);
    // }

    public function removeEmoji($text)
    {
        $string = $text;
        $string = str_replace( "?", "{%}", $string );
        $string  = mb_convert_encoding( $string, "ISO-8859-1", "UTF-8" );
        $string  = mb_convert_encoding( $string, "UTF-8", "ISO-8859-1" );
        $string  = str_replace( array( "?", "? ", " ?" ), array(""), $string );
        $string  = str_replace( "{%}", "?", $string );

        $tweet = preg_replace('/#/', '', $string);

        return trim( $tweet );
    }

    public function file_get_contents_curl( $url ) { 

        $ch = curl_init();   
        curl_setopt($ch, CURLOPT_HEADER, 0); 
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 5); 
        curl_setopt($ch, CURLOPT_URL, $url);  
        $data = curl_exec($ch); 
        curl_close($ch); 
    
        return $data; 
    } 

    public function downloadFile( $imgName, $url, $path )
    {
        $data = $this->file_get_contents_curl( $url );
        $status = file_put_contents( $path.$imgName, $data ); 
        return $status;
    }

    public function formata_data( $type, $data )
    {

        // 1 - 13 de julho de 2020 //JOVEM NERD SITE
        // 2 - 15.04.202111H51 //OMELETE  SITE
        // 3 - 2018-01-15T22:00:57Z //YOUTUBE
        if($data != "" && $type == 1){
            $mes = array(
                'referencia' => array('/ de janeiro de /', '/ de fevereiro de /', '/ de março de /', '/ de abril de /', '/ de maio de /', '/ de junho de /', '/ de julho de /' , '/ de agosto de /', '/ de setembro de /', '/ de outubro de /', '/ de novembro de /', '/ de dezembro de /'),
                'correcao' => array('/01/', '/02/', '/03/', '/04/', '/05/', '/06/', '/07/', '/08/', '/09/', '/10/', '/11/', '/12/')
            );
            $data_final = preg_replace($mes['referencia'], $mes['correcao'], $data);
            $array = explode("/", $data_final);
            $data_final = $array[2].'-'.$array[1].'-'.$array[0];
            return  $data_final;
        }else if($data != "" && $type == 2){
            $array = explode(".", $data);
            $data_final = substr( $array[2], 0, 4).'-'.$array[1].'-'.$array[0];
            return $data_final ;
        }else if($data != "" && $type == 3){
            $data_final = substr(  $data, 0, -10);
            return $data_final ;
        }

    }

    public function validaNoticia($search, $title){
        $search = $this->removeArtigosPreposicoes($search);
        
        // echo '<br/>';
        // echo  $search;
        // echo '<br/>';
        // echo  $title;
        // echo '<br/>';
        // echo '<br/>';
      
        // $search = 'Falcão e O Soldado Invernal';
       
        // $title = "Trailer The Soldado Falcon and the Winter Soldier - Sem aposentadoria";
        $palavras = explode(" ", $search);
        
        $matches = 0;
        foreach ($palavras as $key => $value) {
            // echo  trim($value);
            // echo $title;
            // echo '<br/>';
            $value = ' '.$value .' ';
            if(preg_match("/{$value}/i", $title)) {
                // echo '------------true--------------------';
                $matches = $matches + 1;
            }
            // echo '<br/>';
        }
        if( $matches > 0){
            return true;
        }else{
            return false;
        }
    }

    public function removeArtigosPreposicoes($frase){
        
        $artigos = array(
            "o",
            "a",
            "e",
            "os",
            "as",
            "um",
            "uma",
            "uns",
            "umas",
            "ao",
            "à",
            "às",
            "da",
            "das",
            "do",
            "dos",
            "na",
            "nas",
            "no",
            "nos",
            "num",
            "nuns",
            "numa",
            "numas",
            "dum",
            "duns",
            "duma",
            "dumas",
            "com",
            "pro",
            "pra",
            "pros",
            "pras",
            "pelo",
            "pela",
            "pelos",
            "pelas",
            "dele",
            "dela",
            "deles",
            "delas",
        );

        foreach($artigos as $artigo)
        {
            //no meio da frase
            $frase = preg_replace("/\s$artigo\s/i", ' ', $frase);
            //no inicio da linha
            $frase = preg_replace("/^$artigo\s/i", ' ', $frase);
            //no final da linha
            $frase = preg_replace("/\s$artigo.$/i", '.', $frase);
        }
        return $frase;
    }
  
}
