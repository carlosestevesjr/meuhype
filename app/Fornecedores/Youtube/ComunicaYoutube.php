<?php

namespace App\Fornecedores\Youtube;


class ComunicaYoutube {
        
    /**
        * @const URL_BUSCA
    **/
    const URL_BUSCA = '/%s/search?query=%s';

    /**
        * @const BUSCA_VIDEO
    **/
    const BUSCA_VIDEO = 'https://www.youtube.com/watch?v=%s';

    /**
        * @var string
    **/
    private $canal;

    /**
        * @var string
    **/
    private $tag;

    /**
        * @var string
    **/
    private $base_url = "";

    /**
        * @var string
    **/
    private $url = "";

    /**
        * @param string $tag
        * @param string $canal
        * @return self
    **/
    public function prepare($tag, $canal) {
        
        $this->tag = urlencode($tag);
        $this->canal = urlencode($canal);

        return $this;
    }

    /**
        * @param string $base_url
        * @return self
    **/
    public function baseUrl($baseUrl) {
        
        $this->base_url = $baseUrl. self::URL_BUSCA ;
        // echo($this->base_url);
        // die;
        return $this;
    }

    /**
        * @param string $url
        * @return self
    **/
    public function url($url) {

        $this->url = $url;
        return $this;
    }

    public function get($quantidade = 15) {

        $url = $this->url ?: sprintf($this->base_url, $this->canal, $this->tag);
        $data = $this->getCurl($url);
        sleep(1);
        // var_dump($data); 
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)(;<\/script>|;<)/', $data, $matches);
        // echo($matches['json'][0]); 
        
    
        // exit;
        if(!empty($matches['json'][0])){
            $dados = json_decode($matches['json'][0]);
        }else{
            $dados = [];
        }

        $videos = $this->buscaVideoRenderers($dados);
        $return['content'] = [];
        
        foreach ($videos as $key => $video) {
            
            if($key >= $quantidade ){
                break;
            }

            $result['noticia'] = "";
            $result['img'] = "";
            $result['link'] = "";
            $result['url'] = "";
            $result['data'] = "";

            $result['noticia'] = $this->textoYoutube($video->title ?? null);
            if(isset($video->thumbnail->thumbnails)){

                $thumbnails = $video->thumbnail->thumbnails;
                $thumbnails = array_reverse($thumbnails);
                $result['img'] = isset($thumbnails[0]->url) ? preg_replace('/\?.*$/', '', $thumbnails[0]->url) : '';
            }

            if(isset($video->videoId)){
                $result['url'] = sprintf(self::BUSCA_VIDEO, $video->videoId);
            }

            if(isset($video->publishedTimeText)){
                $result['data'] = $this->textoYoutube($video->publishedTimeText);
            }

            if($result['noticia'] != "" && $result['url'] != ""){
                $return['content'][] = $result;
            }
        }

        return $return['content'];
    }

    private function buscaVideoRenderers($node) {

        $videos = [];

        if(is_object($node)){
            if(isset($node->videoRenderer)){
                $videos[] = $node->videoRenderer;
            }

            foreach (get_object_vars($node) as $value) {
                $videos = array_merge($videos, $this->buscaVideoRenderers($value));
            }
        } else if(is_array($node)) {
            foreach ($node as $value) {
                $videos = array_merge($videos, $this->buscaVideoRenderers($value));
            }
        }

        return $videos;
    }

    private function textoYoutube($node) {

        if(isset($node->simpleText)){
            return $node->simpleText;
        }

        if(isset($node->runs[0]->text)){
            return $node->runs[0]->text;
        }

        return "";
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

}
  
