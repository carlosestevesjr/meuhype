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
                            // 'Jovem_Nerd_Spotify' => $this->buscaNewsJovemNerdSpotify(),
                            // 'Cinema_Com_Rapadura_Spotify' => $this->buscaNewsCinemaComRapaduraSpotify(),
                            
                            
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
        
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';/
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-thiagoromarizyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-thiagoromarizyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-thiagoromarizyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-thiagoromarizyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-thiagoromarizyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-thiagoromarizyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-thiagoromarizyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-entremigasyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-entremigasyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-entremigasyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-entremigasyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-entremigasyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-entremigasyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-entremigasyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-miguellokiayoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-miguellokiayoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-miguellokiayoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-miguellokiayoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-miguellokiayoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-miguellokiayoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-miguellokiayoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-gustavocunhayoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-gustavocunhayoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-gustavocunhayoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-gustavocunhayoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-gustavocunhayoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-gustavocunhayoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-gustavocunhayoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-nerdnewsyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-nerdnewsyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-nerdnewsyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-nerdnewsyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-nerdnewsyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-nerdnewsyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-nerdnewsyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-sessaonerdyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-sessaonerdyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-sessaonerdyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-sessaonerdyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-sessaonerdyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-sessaonerdyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-sessaonerdyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-arenanerdyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-arenanerdyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-arenanerdyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-arenanerdyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-arenanerdyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-arenanerdyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-arenanerdyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-caldeiraonerdyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-caldeiraonerdyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-caldeiraonerdyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-caldeiraonerdyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-caldeiraonerdyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-caldeiraonerdyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-caldeiraonerdyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-nerdexperienceyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-nerdexperienceyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-nerdexperienceyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-nerdexperienceyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-nerdexperienceyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-nerdexperienceyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-nerdexperienceyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-crispandayoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-crispandayoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-crispandayoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-crispandayoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-crispandayoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-crispandayoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-crispandayoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-nerdrabugentoyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-nerdrabugentoyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-nerdrabugentoyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-nerdrabugentoyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-nerdrabugentoyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-nerdrabugentoyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-nerdrabugentoyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-operacaocinemayoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-operacaocinemayoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-operacaocinemayoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-operacaocinemayoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-operacaocinemayoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-operacaocinemayoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-operacaocinemayoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-quatrocoisasyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-quatrocoisasyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-quatrocoisasyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-quatrocoisasyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-quatrocoisasyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-quatrocoisasyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-quatrocoisasyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-cavernadocarusoyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-cavernadocarusoyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-cavernadocarusoyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-cavernadocarusoyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-cavernadocarusoyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-cavernadocarusoyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-cavernadocarusoyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-caiqueizotonyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-caiqueizotonyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-caiqueizotonyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-caiqueizotonyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-caiqueizotonyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-caiqueizotonyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-caiqueizotonyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-cinemacomrapadurayoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-cinemacomrapadurayoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-cinemacomrapadurayoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-cinemacomrapadurayoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-cinemacomrapadurayoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-cinemacomrapadurayoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-cinemacomrapadurayoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-nerdlandyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-nerdlandyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-nerdlandyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-nerdlandyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-nerdlandyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-nerdlandyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-nerdlandyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-einerdyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-einerdyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-einerdyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-einerdyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-einerdyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-einerdyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-einerdyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-pipocandoyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-pipocandoyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-pipocandoyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-pipocandoyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-pipocandoyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-pipocandoyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-pipocandoyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-omeleteyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-omeleteyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-omeleteyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-omeleteyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-omeleteyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-omeleteyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-omeleteyoutube')
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
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-jovemnerdyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-jovemnerdyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-jovemnerdyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-jovemnerdyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-jovemnerdyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-jovemnerdyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-jovemnerdyoutube')
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
                    $tag = Tags::where( 'id',  '=', $value->tags_id )->where( 'status',  '=', 'active' )->firstOrFail();
                    if($tag ){
                        $url = $channel->url_crawler .str_replace(" ","+",$tag->title) ;
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
        
        //Busca crawler
        $data = $this->getCurl($url);
        
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        preg_match_all('/"sectionListRenderer":{"contents":\[(?P<artigo>[\s\S]*?)(,{"continuationItemRenderer")/', $matches['json'][0], $matches);
       
        if(isset($matches['artigo'][0])){
            $dados = json_decode('['.$matches['artigo'][0].']');
        }else{
            $dados = [];
        }
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            if($key < 11){
                $result['noticia'] = "";
                $result['img'] = "";
                $result['link'] = "";
                $result['data'] = "";

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                    $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                    //Verifica se a noticia tem relação com as tags
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($result['noticia']) )){
                    
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){
                            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[3]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[2]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[1]->url;
                            }else if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url)){
                                $result['img'] = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails[0]->url;
                            }else{
                                $result['img'] = "";
                            }
                        }
            
                        if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                            $result['url'] = 'https://www.youtube.com/watch?v='.$value->itemSectionRenderer->contents[0]->videoRenderer->videoId;
                        }
                        
                        if(isset($result['url']) && $result['url'] != ""){
                            $url_date = $result['url'];
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                            $dados2 = json_encode($matches['json'][0]);
                            $dados2 = str_replace('"','',$dados2);
                            // echo '<pre>'; print_r($dados2); echo '</pre>';
                            $result['data'] =  $this->formata_data(4,$dados2);
                        }

                        $return['content'][] = $result;
            
                    }
                }
            }else{
                break;
            }
        }
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($return['content'] as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-superoitoyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-superoitoyoutube') )->first();
                            
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
                    Str::slug($item['noticia'].'-superoitoyoutube')
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
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-superoitoyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-superoitoyoutube');
                        $insert->link = $link;
                        $insert->image = '/uploads/news/' . $filename;
                        $insert->status = "show";
                        $insert->order = 0;
                        
                        $insert->data = $data;
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
                                $insert->id.' '.Str::slug($item['noticia'].'-superoitoyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-superoitoyoutube')
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

                $news = News::where( 'hash',  '=', Str::slug($item['noticia'][0].'-omeletesite') )->first();
                            
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

    public function getCurl($url) {

        $config['useragent'] = $this->getRandAgent();

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_USERAGENT, $config['useragent']);
        // curl_setopt($ch, CURLOPT_PROXY, $proxy); // $proxy is ip of proxy server
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);
        $httpCode = curl_getinfo($ch , CURLINFO_HTTP_CODE); // this results 0 every time
        $response = curl_exec($ch);
        if ($response === false) $response = curl_error($ch);
       
        curl_close($ch);

        return $response;
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
        // 4 - 13 de out. de 2017 //YOUTUBE Site
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
        }else if($data != "" && $type == 4){
            $data = str_replace('Estreou em ','',$data);
            $data = str_replace('Transmitido ao vivo em ','',$data);
            $mes = array(
                'referencia' => array('/ de jan. de /', '/ de fev. de /', '/ de mar. de /', '/ de abr. de /', '/ de mai. de /', '/ de jun. de /', '/ de jul. de /' , '/ de ago. de /', '/ de set. de /', '/ de out. de /', '/ de nov. de /', '/ de dez. de /'),
                'correcao' => array('/01/', '/02/', '/03/', '/04/', '/05/', '/06/', '/07/', '/08/', '/09/', '/10/', '/11/', '/12/')
            );
            $data_final = preg_replace($mes['referencia'], $mes['correcao'], $data);
            $array = explode("/", $data_final);
            $data_final = $array[2].'-'.$array[1].'-'.$array[0];
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

            "after",
            "at",
            "before",
            "by",
            "from",
            "in",
            "on",
            "to",
            "the",
            "of",
            "with",
            "without"

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
