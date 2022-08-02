<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Support\Str;

use App\Fornecedores\Youtube\ComunicaYoutube;

use Illuminate\Http\Request;
use Alaouy\Youtube\Facades\Youtube;
use Twitter;
use Spotify;
use Mail;
use Validator;

use App\CrawlerConfigs;
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
        // $this->buscaTeste();
          
        $hora_inicial = date("H:i:s");

        $arrayResults = [
                            'Omelete_Site'       => ($this->crawler_canais_ativos('omeletesite')) ? $this->buscaNewsOmeleteSite() : "desligado",
                            'Jovem_Nerd_Site'    => ($this->crawler_canais_ativos('jovemnerdsite')) ? $this->buscaNewsJovemNerdSite() : "desligado",
                            'Tec_Mundo_Site'    => ($this->crawler_canais_ativos('tecmundosite')) ? $this->buscaTecMundoSite() : "desligado",
                            'Poltrona_Nerd_Site'    => ($this->crawler_canais_ativos('poltronanerdsite')) ? $this->buscaPoltronaNerdSite() : "desligado",
                            'Super_Oito_Youtube' => ($this->crawler_canais_ativos('superoitoyoutube')) ? $this->buscaNewsSuperOitoYoutube() : "desligado",
                            'Jovem_Nerd_Youtube' => ($this->crawler_canais_ativos('jovemnerdyoutube')) ? $this->buscaNewsJovemNerdYoutube() : "desligado",
                            'Omelete_Youtube'    => ($this->crawler_canais_ativos('omeleteyoutube')) ? $this->buscaNewsOmeleteYoutube() : "desligado",
                            'Pipocando_Youtube'  => ($this->crawler_canais_ativos('pipocandoyoutube')) ? $this->buscaNewsPipocandoYoutube() : "desligado",
                            'Ei_Nerd_Youtube'    => ($this->crawler_canais_ativos('einerdyoutube')) ? $this->buscaNewsEiNerdYoutube() : "desligado",
                            'Nerd_Land_Youtube'  => ($this->crawler_canais_ativos('nerdlandyoutube')) ? $this->buscaNewsNerdLandYoutube() : "desligado",
                            'Cinema_Com_Rapadura_Youtube' => ($this->crawler_canais_ativos('cinemacomrapadurayoutube')) ? $this->buscaCinemaComRapaduraYoutube() : "desligado",
                            'Caique_Izoton_Youtube' => ($this->crawler_canais_ativos('caiqueizotonyoutube')) ? $this->buscaCaiqueIzotonYoutube() : "desligado",
                            'Caverna_Do_Caruso_Youtube' => ($this->crawler_canais_ativos('cavernadocarusoyoutube')) ? $this->buscaCavernaDoCarusoYoutube() : "desligado",
                            'Quatro_Coisas_Youtube' => ($this->crawler_canais_ativos('quatrocoisasyoutube')) ? $this->buscaQuatroCoisasYoutube() : "desligado",
                            'Operacao_Cinema_Youtube' => ($this->crawler_canais_ativos('operacaocinemayoutube')) ? $this->buscaOperacaoCinemaYoutube() : "desligado",
                            'Nerd_Rabugento_Youtube' => ($this->crawler_canais_ativos('nerdrabugentoyoutube')) ? $this->buscaNerdRabugentoYoutube() : "desligado",
                            'Cris_Panda_Youtube' => ($this->crawler_canais_ativos('crispandayoutube')) ? $this->buscaCrisPandaYoutube() : "desligado",
                            'Nerd_Experience_Youtube' => ($this->crawler_canais_ativos('nerdexperienceyoutube')) ? $this->buscaNerdExperienceYoutube() : "desligado",
                            'Caldeirao_Nerd_Youtube' => ($this->crawler_canais_ativos('caldeiraonerdyoutube')) ? $this->buscaCaldeiraoNerdYoutube() : "desligado",
                            'Arena_Nerd_Youtube' => ($this->crawler_canais_ativos('arenanerdyoutube')) ? $this->buscaArenaNerdYoutube() : "desligado",
                            'Sessao_Nerd_Youtube' => ($this->crawler_canais_ativos('sessaonerdyoutube')) ? $this->buscaSessaoNerdYoutube() : "desligado",
                            'Nerd_News_Youtube' => ($this->crawler_canais_ativos('nerdnewsyoutube')) ? $this->buscaNerdNewsYoutube() : "desligado",
                            'Thiago_Romariz_Youtube' => ($this->crawler_canais_ativos('thiagoromarizyoutube')) ? $this->buscaThiagoRomarizYoutube() : "desligado",
                            'Gustavo_Cunha_Youtube' => ($this->crawler_canais_ativos('gustavocunhayoutube')) ? $this->buscaGustavoCunhaYoutube() : "desligado",
                            'Miguel_Lokia_Youtube' => ($this->crawler_canais_ativos('miguellokiayoutube')) ? $this->buscaMiguelLokiaYoutube() : "desligado",
                            'Entre_Migas_Youtube' => ($this->crawler_canais_ativos('entremigasyoutube')) ? $this->buscaEntreMigasYoutube() : "desligado",
                            'Matando_Robos_Gigantes_Youtube' => ($this->crawler_canais_ativos('matandorobosgigantesyoutube')) ? $this->buscaMatandoRobosGigantesYoutube() : "desligado",
                            // 'Jovem_Nerd_Spotify' => ($this->crawler_canais_ativos('jovemnerdspotify')) ? $this->buscaNewsJovemNerdSpotify() : "desligado",
                            // 'Cinema_Com_Rapadura_Spotify' => ($this->crawler_canais_ativos('cinemacomrapaduraspotify')) ? $this->buscaNewsCinemaComRapaduraSpotify() : "desligado"
                        ];
                        
        $hora_final = date("H:i:s");
        // $user = User::findOrFail('1');
        // $message->from($address, $name = null);
        // $message->sender($address, $name = null);
        // $message->to($address, $name = null);
        // $message->cc($address, $name = null);
        // $message->bcc($address, $name = null);
        // $message->replyTo($address, $name = null);
        // $message->subject($subject);
        // $message->priority($level);
        // $message->attach($pathToFile, array $options = []);
        //
        // Attach a file from a raw $data string...
        // $message->attachData($data, $name, array $options = []);

        //Get the underlying SwiftMailer message instance...
        // $message->getSwiftMessage();
        // var_dump($arrayResults['Omelete_Site']);
        // dd();   
     
        try {
            $dados = [ 'data'  => $arrayResults, 'hora_inicial' => $hora_inicial,'hora_final' => $hora_final];
            echo '<pre>';
            print_r($arrayResults);
            echo '</pre>';
            Mail::send('emails.contato', $dados, function ($message) {
                $message->from('inthemovie@nocinema.kinghost.net', 'Contato Meu Hype');
                $message->subject('Contato Pelo Site');
                $message->to('carlosestevesjr0@gmail.com');
                
            });
        }
        catch (Exception $e) {
            echo $e->getMessage();
            $dados = [ 'data'  => $e->getMessage()];

            Mail::send('emails.contato', $dados, function ($message) {
                $message->from('inthemovie@nocinema.kinghost.net', 'Contato Meu Hype');
                $message->subject('Contato Pelo Site');
                $message->to('carlosestevesjr0@gmail.com');
            });
        }
        
        // return response()->json($arrayResults , 200);
        
    }

    public function buscaTeste(){
        $result = $this->getCurl("https://www.filmelier.com/br/film/19308/tico-e-teco-defensores-da-lei");

        echo $result;
        die('buscaTeste');
    }

    public function buscaMatandoRobosGigantesYoutube(){

        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'matandorobosgigantesyoutube' )->firstOrFail();
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        
        //Busca Crawler
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/user')->prepare($tag_title, 'matandorobosgigantes')->get($this->qtd_noticias_por_canal());
       
        // echo '<pre>'; print_r($return['content']); echo '</pre>';/
        foreach($dados_busca as $item){

            //Validando os campos
            $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-matandorobosgigantesyoutube')], [
                    'hash' => 'required|unique:news',
                ],
                $messages = [
                    'unique'    => 'Notícia já existe.',
                ]
            );

            if ($validator->fails()) {

                $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-matandorobosgigantesyoutube') )->first();
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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
                    Str::slug($item['noticia'].'-matandorobosgigantesyoutube')
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

                        //Baixa imagem
                        $file =$img;
                        $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-matandorobosgigantesyoutube'.'.jpg';
                        $destinationPath = public_path().'/uploads/news/';
                        $upload = $this->downloadFile($filename, $file , $destinationPath);

                        $insert = new News;
                        $insert->title = $this->removeEmoji($item['noticia']);
                        $insert->channels_id = $channel->id;
                        $insert->slug = Str::slug($item['noticia']);
                        $insert->hash = Str::slug($item['noticia'].'-matandorobosgigantesyoutube');
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
                                $insert->id.' '.Str::slug($item['noticia'].'-matandorobosgigantesyoutube')
                            );
                        }
                    }
                }else{
                    array_push(
                        $array_erros,
                        Str::slug($item['noticia'].'-matandorobosgigantesyoutube')
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

    public function buscaThiagoRomarizYoutube(){

        // Search only videos in a given channel, return an array of PHP objects
        $channel = Channels::where( 'hash',  '=', 'thiagoromarizyoutube' )->firstOrFail();
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        
        //Busca Crawler
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'ThiagoRomariz')->get($this->qtd_noticias_por_canal());
       
        // echo '<pre>'; print_r($return['content']); echo '</pre>';/
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        
        //Busca Crawler
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'EntreMigas')->get($this->qtd_noticias_por_canal());
       
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        
        //Busca Crawler
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'MiguelLokiaMesmo')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        
        //Busca Crawler
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'GustavoCunhavideos')->get($this->qtd_noticias_por_canal());

        // echo '<pre>'; print_r($dados_busca); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'NerdNewsOficial')->get($this->qtd_noticias_por_canal());

        // echo '<pre>'; print_r($dados_busca); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'SessãoNerdOficial')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'ArenaNerdOficial')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'CaldeirãoNerd')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title= "";

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
                    if($tag){
                        $tag_title = $tag->title ;
                        // echo $tag_title
                    }
                }
                $count++;
            }
            // dd($tag_title;
        }
        // echo 'url:'.$tag_title
        
        if($tag_title== ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'NERDEXPERIENCEOFICIAL')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                    if($tag){
                        $tag_title = $tag->title;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/user')->prepare($tag_title, 'CoxinhaNerd')->get($this->qtd_noticias_por_canal());

        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'NerdRabugentoOficial')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'OperaçãoCinema')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'Qu4troCoisas')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'CAVERNADOCARUSO')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'CaiqueIzoton')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'CinemacomRapaduraoficial')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'NerdLand')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'einerdtv')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'Pipocando')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
       
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'omeleteve')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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
                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title ;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/c')->prepare($tag_title, 'JovemNerd')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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
        $tag_title = "";

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
                        $tag_title = $tag->title;
                        // echo $tag_title;
                    }
                }
                $count++;
            }
            // dd($tag_title);
        }
        // echo 'url:'.$tag_title;
        
        if($tag_title == ""){
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
        $comunicaYoutube = new ComunicaYoutube;
        $dados_busca = $comunicaYoutube->baseUrl('https://www.youtube.com/user')->prepare($tag_title, 'otaviouga')->get($this->qtd_noticias_por_canal());
        
        // echo '<pre>'; print_r($return['content']); echo '</pre>';
        // die;
        foreach($dados_busca as $item){

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
                            
                if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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

                
                if($img != "" && $link != ""){
                    $data_json = "";
                    if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                        if(isset($item['url']) && $item['url'] != ""){
                            $data2 = "";
                            $url_date = "";
                            $url_date = $item['url'];
                            $this->pauseTime();
                            $data2 = $this->getCurl($url_date);
                            preg_match_all('/(<meta itemprop="datePublished" content=")(?P<json>[\s\S]*?)["><meta]/', $data2, $matches);
                            if(!empty($matches['json'][0])){
                                $data =  trim($matches['json'][0]); 
                            }else{
                                $data = '0000-00-00';
                            }
                        }

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

        $result = $this->getCurl($url);
        preg_match_all('/card-post -rowdesktop">(?P<artigo>[\s\S]*?)(<\/article>)/', $result, $matches);
        $result = [];
        foreach ($matches['artigo'] as $key => $value) {
            preg_match_all('/(<h2)[\s\S]*?(class="title">)[\s\S]*?(<a)[\s\S]*?(href=")(?P<url>[\s\S]*?)(">)(?P<noticia>[\s\S]+?)(<\/a>)/', $value, $matche);
            $result['url'] = $matche['url'][0];
            $result['noticia'] = trim($matche['noticia'][0]) ;
            preg_match_all('/(<img)[\s\S]*?(src\=")(?P<imagem>[\s\S]*?)(")/', $value, $matche);
            $result['img'] = (array_key_exists(0 , $matche['imagem'])) ? $matche['imagem'][0] : '';
            preg_match_all('/(<time)[\s\S](class="postedon">)(?P<data>[\s\S]*?)(<\/time>)/', $value, $matche);
            $result['data'] = trim($matche['data'][0]) ;
            $return['content'][] = $result;
        }

        if(count($return['content']) > 0){
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
                                
                    if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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
                        $data =  $this->formata_data(1, trim($item['data'])); 
                    }
                    if($img != "" && $link != ""){
                        $data_json = "";
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

        $result = $this->getCurl($url);
       
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
       
            
        if(count($return['content']) > 0){
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
                                
                    if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia'][0]) )){
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
                        $data_json = "";
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

    public function buscaTecMundoSite(){

        $channel = Channels::where( 'hash',  '=', 'tecmundosite' )->firstOrFail();
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

        $result = $this->getCurl($url);
        preg_match_all('/(<article class="tec--card tec--card--medium">)(?P<artigos>[\s\S]*?)(<\/article>)/', $result, $matches);
       
        $result = [];
       
        foreach ($matches['artigos'] as $key => $value) {
            preg_match_all('/(title=")(?P<noticia>[\s\S]*?)(")/', $value ,$matche_noticia);
            $result['noticia'] = $matche_noticia['noticia'][0];
       
            preg_match_all('/(href=")(?P<link>[\s\S]*?)(")/', $value, $matche_link);
            $result['url']=  $matche_link['link'][0];
           
            preg_match_all('/(<img data-src=")(?P<imagem>[\s\S]*?)("?ims=)/', $value, $matche_img);
            $result['img'] = (array_key_exists(0 , $matche_img['imagem'])) ? $matche_img['imagem'][0] : '';
            
            preg_match_all('/(class="tec--timestamp__item z--font-semibold">)(?P<data>[\s\S]*?)(<\/div>)/', $value, $matche_data);
            $result['data'] = $matche_data['data'][0];
            $return['content'][] = $result;
        }

        if(count($return['content']) > 0){
            foreach($return['content'] as $item){

                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-tecmundosite')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );

                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-tecmundosite') )->first();
                                
                    if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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
                        Str::slug($item['noticia'].'-tecmundosite')
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
                        $data =  $this->formata_data(1, trim($item['data'])); 
                    }
                    if($img != "" && $link != ""){
                        $data_json = "";
                        if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                            //Baixa imagem
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-tecmundosite'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);

                            $insert = new News;
                            $insert->title = $this->removeEmoji($item['noticia']);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item['noticia']);
                            $insert->hash = Str::slug($item['noticia'].'-tecmundosite');
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
                                    $insert->id.' '.Str::slug($item['noticia'].'-tecmundosite')
                                );
                            }
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item['noticia'].'-tecmundosite')
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

    public function buscaPoltronaNerdSite(){
 
        $channel = Channels::where( 'hash',  '=', 'poltronanerdsite' )->firstOrFail();
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

        $result = $this->getCurl($url);
        preg_match_all('/(<article class="jeg_post jeg_pl_md_2 format-standard">)(?P<artigo>[\s\S]*?)(<\/article>)/',$result ,$matche_artigo);
        $result = [];
        
        foreach ($matche_artigo['artigo'] as $key => $value) {
            preg_match_all('/(<h3 class="jeg_post_title">\n<a href=")([https:\/\/][^\/\/])(?P<noticia>[\s\S]*?)(<\/a>\n<\/h3>)/', $value ,$matche_noticia);
            $result['noticia'] = "";
            if(isset($matche_noticia['noticia'][0])){
                $explode = explode("\">",$matche_noticia['noticia'][0]);
                if(isset($explode[1])){
                    $result['noticia'] = $explode[1];
                }
            }
          
            preg_match_all('/(href=")(?P<link>[\s\S]*?)(")/', $value, $matche_link);
            $result['url']=  $matche_link['link'][0];
            
            preg_match_all('/(ret_img,w_350,h_250\/)(?P<imagem>[\s\S]*?)(")/', $value, $matche_img);
            $result['img'] = (array_key_exists(0 , $matche_img['imagem'])) ? $matche_img['imagem'][0] : '';
            
            preg_match_all('/(<i class="fa fa-clock-o"><\/i>)(?P<data>[\s\S]*?)(<\/a)/', $value, $matche_data);
            $result['data'] = $matche_data['data'][0];
    
            $return['content'][] = $result;
        }
        
        if(count($return['content']) > 0){
            foreach($return['content'] as $item){

                //Validando os campos
                $validator = Validator::make(['hash' => Str::slug($item['noticia'].'-poltronanerdsite')], [
                        'hash' => 'required|unique:news',
                    ],
                    $messages = [
                        'unique'    => 'Notícia já existe.',
                    ]
                );

                if ($validator->fails()) {

                    $news = News::where( 'hash',  '=',  Str::slug($item['noticia'].'-poltronanerdsite') )->first();
                                
                    if($news && $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
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
                        Str::slug($item['noticia'].'-poltronanerdsite')
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
                        $data =  $this->formata_data(1, trim($item['data'])); 
                    }
                    if($img != "" && $link != ""){
                        $data_json = "";
                        if( $this->validaNoticia( $tag->title,  $this->removeEmoji($item['noticia']) )){
                            //Baixa imagem
                            $file =$img;
                            $filename =  date('Ymdhis'). '_' . Str::slug( $this->removeEmoji($item['noticia'])).'-poltronanerdsite'.'.jpg';
                            $destinationPath = public_path().'/uploads/news/';
                            $upload = $this->downloadFile($filename, $file , $destinationPath);

                            $insert = new News;
                            $insert->title = $this->removeEmoji($item['noticia']);
                            $insert->channels_id = $channel->id;
                            $insert->slug = Str::slug($item['noticia']);
                            $insert->hash = Str::slug($item['noticia'].'-poltronanerdsite');
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
                                    $insert->id.' '.Str::slug($item['noticia'].'-poltronanerdsite')
                                );
                            }
                        }
                    }else{
                        array_push(
                            $array_erros,
                            Str::slug($item['noticia'].'-poltronanerdsite')
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
        $timeout = 20; // set to zero for no timeout
        curl_setopt ($ch, CURLOPT_URL, $url);
        curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT, $timeout);

        ob_start();
        curl_exec($ch);
        curl_close($ch);
        $file_contents = ob_get_contents();
        ob_end_clean();


        // $ch = curl_init();
        // curl_setopt($ch, CURLOPT_URL, $url);
        // curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        // curl_setopt($ch, CURLOPT_USERAGENT, $config['useragent']);
        // // curl_setopt($ch, CURLOPT_COOKIEFILE, '/tmp/cookiefile');
        // // curl_setopt($ch, CURLOPT_PROXY, $proxy); // $proxy is ip of proxy server
        // curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        // curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        // // curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
        // // curl_setopt($ch, CURLOPT_TIMEOUT, 10);
        // $httpCode = curl_getinfo($ch , CURLINFO_HTTP_CODE); // this results 0 every time
        // $response = curl_exec($ch);
        // echo $httpCode;
        // if ($response === false) $response = curl_error($ch);
       
        // curl_close($ch);

        return $file_contents;
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

    public function removeEmoji($text){
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

    public function downloadFile( $imgName, $url, $path ){
        $data = $this->file_get_contents_curl( $url );
        $status = file_put_contents( $path.$imgName, $data ); 
        return $status;
    }

    public function formata_data( $type, $data ){
        
        // 1 - 13 de julho de 2020 //JOVEM NERD SITE
        // 2 - 15.04.202111H51 //OMELETE  SITE
        // 3 - 2018-01-15T22:00:57Z //YOUTUBE
        // 4 - 13 de out. de 2017  //YOUTUBE Site
        $mes = array(
            'referencia' => array('/ de janeiro de /', '/ de fevereiro de /', '/ de março de /', '/ de abril de /', '/ de maio de /', '/ de junho de /', '/ de julho de /' , '/ de agosto de /', '/ de setembro de /', '/ de outubro de /', '/ de novembro de /', '/ de dezembro de /'),
            'correcao' => array('/01/', '/02/', '/03/', '/04/', '/05/', '/06/', '/07/', '/08/', '/09/', '/10/', '/11/', '/12/')
        );

        $mes2 = array(
            'referencia' => array('/ de jan. de /', '/ de fev. de /', '/ de mar. de /', '/ de abr. de /', '/ de mai. de /', '/ de jun. de /', '/ de jul. de /' , '/ de ago. de /', '/ de set. de /', '/ de out. de /', '/ de nov. de /', '/ de dez. de /'),
            'correcao' => array('/01/', '/02/', '/03/', '/04/', '/05/', '/06/', '/07/', '/08/', '/09/', '/10/', '/11/', '/12/')
        );

        if($data != "" && $type == 1){
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

            try {
                if (strpos($data, 'hoje') !== false) {
                    return date('Y-m-d') ;
                }
    
                $data = str_replace('Estreou em ','',$data);
                $data = str_replace('Transmitido ao vivo em ','',$data);
              
                $data_final = preg_replace($mes['referencia'], $mes['correcao'], $data);
                $data_final = preg_replace($mes2['referencia'], $mes2['correcao'], $data_final);
                $array = explode("/", $data_final);
              
                $data_final = $array[2].'-'.$array[1].'-'.$array[0];
                return $data_final ;
            } catch (Exception $e) {
                return date('Y-m-d') ;
            }
           
        }

    }

    function validaNoticia($search, $title, $porcentagemMatch = 65){

        $search = strtolower($this->removerAcentos($this->removeArtigosPreposicoes($search)));
        $title = strtolower($this->removerAcentos($this->removeArtigosPreposicoes($title)));
        $palavras = explode(" ", $search);
        $palavrasTitle  = explode(" ", $title);
    
        $matches = 0;
        $similaridadeGeral = 0;
        foreach ($palavras as $key => $palavraSearch) {
            foreach ($palavrasTitle as $key2 => $palavraTitle) {
                similar_text($palavraSearch, $palavraTitle, $similaridade);
    
                if($similaridade > $porcentagemMatch) {
                    $matches++; 
                    $similaridadeGeral += $similaridade;
                }
            }
        }
    
        if( $similaridadeGeral/count($palavras) > $porcentagemMatch){
            return true;
        }else{
            return false;
        }
    }

    function removeArtigosPreposicoes($frase){
        
        $artigos = array(
            "o",
            "a",
            "e",
            "é",
            "os",
            "as",
            "um",
            "uma",
            "uns",
            "umas",
            "ao",
            "à",
            "de",
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
            // "the",
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
    
    function removerAcentos($texto){
        return preg_replace(array("/(á|à|ã|â|ä)/","/(Á|À|Ã|Â|Ä)/","/(é|è|ê|ë)/","/(É|È|Ê|Ë)/","/(í|ì|î|ï)/","/(Í|Ì|Î|Ï)/","/(ó|ò|õ|ô|ö)/","/(Ó|Ò|Õ|Ô|Ö)/","/(ú|ù|û|ü)/","/(Ú|Ù|Û|Ü)/","/(ñ)/","/(Ñ)/", "/(ç)/", "/(Ç)/"),explode(" ","a A e E i I o O u U n N c C"),$texto);
    }

    function getUserIP() {
        $ipaddress = '';
        if (isset($_SERVER['HTTP_CLIENT_IP']))
            $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
        else if(isset($_SERVER['HTTP_X_FORWARDED_FOR']))
            $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
        else if(isset($_SERVER['HTTP_X_FORWARDED']))
            $ipaddress = $_SERVER['HTTP_X_FORWARDED'];
        else if(isset($_SERVER['HTTP_X_CLUSTER_CLIENT_IP']))
            $ipaddress = $_SERVER['HTTP_X_CLUSTER_CLIENT_IP'];
        else if(isset($_SERVER['HTTP_FORWARDED_FOR']))
            $ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
        else if(isset($_SERVER['HTTP_FORWARDED']))
            $ipaddress = $_SERVER['HTTP_FORWARDED'];
        else if(isset($_SERVER['REMOTE_ADDR']))
            $ipaddress = $_SERVER['REMOTE_ADDR'];
        else
            $ipaddress = 'UNKNOWN';
        return $ipaddress;
    }

    function pauseTime() {
        $sorteio = rand(1,5);

        if($sorteio == 1){
            return usleep(3056872);
        }else if($sorteio == 2){
            return usleep(1925713);
        }else if($sorteio == 3){
            return usleep(2004567);
        }else if($sorteio == 4){
            return usleep(3354781);
        }else if($sorteio == 5){
            return usleep(1000000);
        }
    }
    
    function crawler_canais_ativos($hash_channel) {
        $crawler_configs = CrawlerConfigs::where( 'id',  '=', 1 )->first();
        $array_canais_ativos = json_decode($crawler_configs->array_canais_ativos, true);

        if(in_array($hash_channel, $array_canais_ativos)){
            return true;
        }
        return false;
    }

    function qtd_noticias_por_canal() {
        $crawler_configs = CrawlerConfigs::where( 'id',  '=', 1 )->first();
        if(!empty($crawler_configs)){
            return $crawler_configs->qtd_noticias_por_canal;
        }else{
            return 20;
        }
    }
}
