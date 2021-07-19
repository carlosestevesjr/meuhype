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

    public function get($quantidade = 20) {
       
        $data = $this->getCurl(sprintf($this->base_url, $this->canal, $this->tag));
        preg_match_all('/(var ytInitialData = )(?P<json>[\s\S]*?)[;]/', $data, $matches);
        
        if(isset($matches['json'][0])){
            $dados = json_decode($matches['json'][0]);
        }else{
            $dados = [];
        }
        
        
        foreach ($dados->contents->twoColumnBrowseResultsRenderer->tabs as $key1 => $item1) {
            if(isset($item1->expandableTabRenderer) ){
                $dados = $item1->expandableTabRenderer->content->sectionListRenderer->contents;
                break;
            }
        }
            
        $return['content'] = [];
        foreach ($dados as $key => $value) {
            
            if($key >= $quantidade ){
                break;
            }

            $result['noticia'] = "";
            $result['img'] = "";
            $result['link'] = "";
            $result['data'] = "";

            if(isset($value->itemSectionRenderer->contents[0]->videoRenderer)){

                $result['noticia'] = $value->itemSectionRenderer->contents[0]->videoRenderer->title->runs[0]->text;
                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails)){

                    $thumbnails = $value->itemSectionRenderer->contents[0]->videoRenderer->thumbnail->thumbnails;
                    $thumbnails = array_reverse($thumbnails);
                    $result['img'] = isset($thumbnails[0]->url) ? $thumbnails[0]->url : '';
                }

                if(isset($value->itemSectionRenderer->contents[0]->videoRenderer->videoId)){
                    $result['url'] = sprintf(self::BUSCA_VIDEO, $value->itemSectionRenderer->contents[0]->videoRenderer->videoId);
                }
                
                if(isset($result['url']) && $result['url'] != ""){
                    $url_date = $result['url'];
                    $data2 = $this->getCurl($url_date);
                    preg_match_all('/(\"dateText\":{\"simpleText\":\")(?P<json>[\s\S]*?)["}}}]/', $data2, $matches);
                    $dados2 = json_encode($matches['json'][0]);
                    $dados2 = str_replace('"','',$dados2);
                    // echo '<pre>'; print_r($dados2); echo '</pre>';
                    $result['data'] =  $dados2;
                }

                $return['content'][] = $result;
                
            }
            
        }

        return $return['content'];
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

}
  
