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
use Storage;

use Gumlet\ImageResize;
use Symfony\Component\DomCrawler\Crawler as HtmlCrawler;

use App\CrawlerConfigs;
use App\News;
use App\NewsTags;
use App\Crawler;
use App\Channels;
use App\Podcasts;
use App\Tags;
use App\Services\TagImageOptimizer;
use DB;

class CronJobController extends Controller
{
  private TagImageOptimizer $imageOptimizer;

  public function __construct(TagImageOptimizer $imageOptimizer)
  {
    $this->imageOptimizer = $imageOptimizer;
  }

  /**
   * Display a listing of the resource.
   *
   * @return \Illuminate\Http\Response
   */


  // Executa o cron completo, chamando cada crawler ativo e exibindo o resultado consolidado.


  public function index()
  {
    // $this->buscaTeste();

    $hora_inicial = date("H:i:s");

    $arrayResults = [
      'Omelete_Site' => ($this->crawler_canais_ativos('omeletesite')) ? $this->buscaNewsOmeleteSite() : "desligado",
      'Jovem_Nerd_Site' => ($this->crawler_canais_ativos('jovemnerdsite')) ? $this->buscaNewsJovemNerdSite() : "desligado",
      'Tec_Mundo_Site' => ($this->crawler_canais_ativos('tecmundosite')) ? $this->buscaTecMundoSite() : "desligado",
      'Poltrona_Nerd_Site' => ($this->crawler_canais_ativos('poltronanerdsite')) ? $this->buscaPoltronaNerdSite() : "desligado",
      'Super_Oito_Youtube' => ($this->crawler_canais_ativos('superoitoyoutube')) ? $this->buscaNewsSuperOitoYoutube() : "desligado",
      'Jovem_Nerd_Youtube' => ($this->crawler_canais_ativos('jovemnerdyoutube')) ? $this->buscaNewsJovemNerdYoutube() : "desligado",
      'Omelete_Youtube' => ($this->crawler_canais_ativos('omeleteyoutube')) ? $this->buscaNewsOmeleteYoutube() : "desligado",
      'Pipocando_Youtube' => ($this->crawler_canais_ativos('pipocandoyoutube')) ? $this->buscaNewsPipocandoYoutube() : "desligado",
      'Ei_Nerd_Youtube' => ($this->crawler_canais_ativos('einerdyoutube')) ? $this->buscaNewsEiNerdYoutube() : "desligado",
      'Nerd_Land_Youtube' => ($this->crawler_canais_ativos('nerdlandyoutube')) ? $this->buscaNewsNerdLandYoutube() : "desligado",
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
      'Jovem_Nerd_Spotify' => ($this->crawler_canais_ativos('jovemnerdspotify')) ? $this->buscaNewsJovemNerdSpotify() : "desligado",
      'Cinema_Com_Rapadura_Spotify' => ($this->crawler_canais_ativos('cinemacomrapaduraspotify')) ? $this->buscaNewsCinemaComRapaduraSpotify() : "desligado"
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
      $dados = ['data' => $arrayResults, 'hora_inicial' => $hora_inicial, 'hora_final' => $hora_final];
      echo '<pre>';
      print_r($arrayResults);
      echo '</pre>';
    } catch (Exception $e) {
      echo $e->getMessage();
      $dados = ['data' => $e->getMessage()];

    }

    // return response()->json($arrayResults , 200);

  }

  // Metodo manual de teste para inspecionar o HTML retornado por uma URL.

  public function buscaTeste()
  {
    $result = $this->getCurl("https://www.filmelier.com/br/film/19308/tico-e-teco-defensores-da-lei");

    echo $result;
    die('buscaTeste');
  }

  // Executa um callback medindo o tempo gasto e registrando a operacao.

  public function medeTempo(&$tempos, $tipo, $url, $callback, $extra = [])
  {
    $inicio = microtime(true);

    try {
      return $callback();
    } finally {
      $this->registraTempo($tempos, $tipo, $url, $inicio, $extra);
    }
  }

  // Adiciona uma medicao de tempo na lista usada pelo retorno do crawler.

  public function registraTempo(&$tempos, $tipo, $url, $inicio, $extra = [])
  {
    if (!is_array($tempos)) {
      $tempos = [];
    }

    $segundos = microtime(true) - $inicio;

    $tempos[] = array_merge([
      'tipo' => $tipo,
      'url' => $url,
      'segundos' => round($segundos, 4),
      'milissegundos' => (int) round($segundos * 1000),
    ], $extra);
  }

  // Monta o resumo final dos tempos medidos durante a extracao.

  public function finalizaTempos($tempos, $inicio)
  {
    // Calcula o tempo total desde o inicio da extracao.
    $total = microtime(true) - $inicio;

    // Guarda a soma dos tempos agrupada por tipo de operacao.
    $porTipo = [];

    // Copia a lista de tempos para ordenar sem alterar a lista original.
    $maisLentos = $tempos;

    // Percorre cada tempo registrado durante o crawler.
    foreach ($tempos as $tempo) {
      // Usa o tipo registrado ou "outros" quando ele nao existir.
      $tipo = $tempo['tipo'] ?? 'outros';

      // Cria o agrupamento do tipo na primeira vez que ele aparece.
      if (!isset($porTipo[$tipo])) {
        $porTipo[$tipo] = [
          // Conta quantas operacoes desse tipo aconteceram.
          'quantidade' => 0,
          // Soma o tempo desse tipo em segundos.
          'segundos' => 0,
          // Soma o tempo desse tipo em milissegundos.
          'milissegundos' => 0,
        ];
      }

      // Incrementa a quantidade de operacoes desse tipo.
      $porTipo[$tipo]['quantidade']++;

      // Soma os segundos desse item no total do tipo.
      $porTipo[$tipo]['segundos'] += $tempo['segundos'] ?? 0;

      // Soma os milissegundos desse item no total do tipo.
      $porTipo[$tipo]['milissegundos'] += $tempo['milissegundos'] ?? 0;
    }

    // Arredonda os segundos acumulados de cada tipo para facilitar a leitura.
    foreach ($porTipo as $tipo => $dados) {
      $porTipo[$tipo]['segundos'] = round($dados['segundos'], 4);
    }

    // Ordena as operacoes da mais demorada para a mais rapida.
    usort($maisLentos, function ($a, $b) {
      // Compara usando milissegundos para manter a ordenacao precisa.
      return ($b['milissegundos'] ?? 0) <=> ($a['milissegundos'] ?? 0);
    });

    // Monta o resumo final de tempos que entra no retorno do crawler.
    return [
      // Data e hora aproximadas em que a extracao comecou.
      'inicio' => date('Y-m-d H:i:s', (int) $inicio),

      // Data e hora em que esse resumo foi finalizado.
      'fim' => date('Y-m-d H:i:s'),

      // Tempo total da extracao em segundos.
      'total_segundos' => round($total, 4),

      // Tempo total da extracao em milissegundos.
      'total_milissegundos' => (int) round($total * 1000),

      // Quantidade de medicoes registradas.
      'quantidade' => count($tempos),

      // Totais agrupados por tipo de operacao.
      'por_tipo' => $porTipo,

      // Dez operacoes mais lentas, para achar gargalos rapido.
      'mais_lentos' => array_slice($maisLentos, 0, 10),

      // Lista completa com todas as medicoes registradas.
      'itens' => $tempos,
    ];
  }

  // Executa uma requisicao cURL registrando o tempo gasto.

  public function getCurlCronometrado($url, &$tempos, $tipo = 'requisicao')
  {
    return $this->medeTempo($tempos, $tipo, $url, function () use ($url) {
      return $this->getCurl($url);
    });
  }

  // Baixa uma imagem original registrando o tempo gasto no download.

  public function downloadFileOriginalCronometrado($imgName, $url, $path, &$tempos)
  {
    return $this->medeTempo($tempos, 'download_imagem', $url, function () use ($imgName, $url, $path) {
      return $this->downloadFileOriginal($imgName, $url, $path);
    }, [
      'arquivo' => $imgName,
    ]);
  }

  // Crawler generico de Youtube usado por todos os canais configurados por hash.

  public function buscaYoutubePorHash($hash, $canalYoutube = "")
  {
    // Busca o cadastro do canal pelo hash configurado no banco.
    $channel = Channels::where('hash', '=', $hash)->firstOrFail();

    // Guarda a tag ativa que sera usada para filtrar e montar a busca.
    $tag = null;

    // Guarda o titulo da tag para enviar ao crawler do Youtube.
    $tag_title = "";

    // Guarda a URL final de busca do canal, montada a partir do banco.
    $url = "";

    // Lista de noticias inseridas nessa execucao.
    $array_adicionados = [];

    // Lista de noticias que ja existiam no banco.
    $array_existentes = [];

    // Lista de erros ou itens ignorados durante o crawler.
    $array_erros = [];

    // Marca o inicio da execucao para calcular o tempo total.
    $tempo_inicio = microtime(true);

    // Guarda as medicoes de tempo de cada requisicao/operacao pesada.
    $tempos = [];

    // So tenta montar a busca se o canal existir.
    if ($channel) {
      // Pega a hora atual para encontrar o crawler agendado neste momento.
      $hora = date('H:i:s');

      // Busca os crawlers ativos dentro da janela de horario configurada.
      $crawlers = $this->crawlersNoHorarioAtual($hora);

      // Controla para usar apenas o primeiro crawler encontrado.
      $count = 1;

      // Percorre os crawlers disponiveis no horario atual.
      foreach ($crawlers as $key => $value) {
        // Usa somente o primeiro crawler valido, mantendo o comportamento antigo.
        if ($count == 1) {
          // Busca a tag ativa vinculada ao crawler encontrado.
          $tag = Tags::where('id', '=', $value->tags_id)->where('status', '=', 'active')->firstOrFail();

          // Se encontrou tag, monta o termo e a URL dinamica do Youtube.
          if ($tag) {
            // Guarda o texto da tag para usar na busca e validacao.
            $tag_title = $tag->title;

            // Monta a URL final usando o url_crawler do canal e a tag atual.
            $url = $this->montaUrlBuscaCrawler(trim($channel->url_crawler), $tag->title);
          }
        }

        // Avanca o contador para impedir o uso dos proximos crawlers.
        $count++;
      }
    }

    // Se nao encontrou tag ou URL, retorna sem executar crawler.
    if ($tag_title == "" || $url == "") {
      return [
        // Codigo 003 indica que nao havia configuracao suficiente para buscar.
        'code' => '003',

        // Mantem a estrutura de retorno mesmo sem adicionar noticias.
        'adicionados' => $array_adicionados,

        // Mantem a estrutura de existentes vazia.
        'existentes' => $array_existentes,

        // Mantem a estrutura de erros vazia ou com erros coletados antes.
        'erros' => $array_erros,

        // Retorna o resumo de tempos mesmo em saida antecipada.
        'tempos' => $this->finalizaTempos($tempos, $tempo_inicio),

        // Data da execucao.
        'date' => date("Y-m-d"),

        // Hora da execucao.
        'hour' => date("H:i:s"),
      ];
    }

    // Instancia o fornecedor responsavel por ler resultados do Youtube.
    $comunicaYoutube = new ComunicaYoutube;

    // Executa a busca do canal medindo o tempo gasto nessa requisicao.
    $dados_busca = $this->medeTempo($tempos, 'busca_canal', $url, function () use ($comunicaYoutube, $url, $tag_title, $canalYoutube) {
      // Usa a URL dinamica do banco e limita pela quantidade configurada.
      return $comunicaYoutube->url($url)->prepare($tag_title, $canalYoutube)->get($this->qtd_noticias_por_canal());
    });

    // Registra erro quando o crawler nao conseguiu extrair nenhum video.
    if (count($dados_busca ?? []) == 0) {
      $array_erros[] = $hash . ': nenhum vídeo extraído da URL ' . $url;
    }

    // Processa cada video encontrado na busca.
    foreach ($dados_busca as $item) {
      // Titulo original retornado pelo crawler do Youtube.
      $titulo = $item['noticia'] ?? '';

      // Hash unico da noticia, preservando o sufixo do canal.
      $hashNoticia = Str::slug($titulo . '-' . $hash);

      // Valida se a noticia ainda nao existe na tabela news.
      $validator = Validator::make(
        ['hash' => $hashNoticia],
        [
          // O hash precisa existir e ser unico.
          'hash' => 'required|unique:news',
        ],
        $messages = [
          // Mensagem usada quando o hash ja existe.
          'unique' => 'Notícia já existe.',
        ]
      );

      // Se falhou, a noticia ja existe ou o hash esta invalido.
      if ($validator->fails()) {
        // Busca a noticia existente pelo mesmo hash.
        $news = News::where('hash', '=', $hashNoticia)->first();

        // Se a noticia existe e bate com a tag, corrige data/tag quando necessario.
        if ($news && $tag && $this->validaNoticiaTag($tag, $this->removeEmoji($titulo))) {
          // Corrige datas antigas como 0000-00-00 usando a pagina do video.
          $this->corrigeDataYoutubeExistente($news, $item, $tempos);

          // Verifica se a relacao da noticia com a tag ja existe.
          $news_tags = NewsTags::where('news_id', '=', $news->id)->where('tags_id', '=', $tag->id)->first();

          // Cria a relacao news_tags caso ainda nao exista.
          if (!$news_tags) {
            $insert_news_tags = new NewsTags;
            $insert_news_tags->news_id = $news->id;
            $insert_news_tags->tags_id = $tag->id;
            $insert_news_tags->save();
          }
        }

        // Registra a noticia como existente no retorno.
        $array_existentes[] = $hashNoticia;

        // Pula para o proximo video.
        continue;
      }

      // URL da imagem retornada pelo crawler do Youtube.
      $img = $item['img'] ?? "";

      // Link do video no Youtube.
      $link = $item['url'] ?? "";

      // Data final que sera salva na noticia.
      $data = "";

      // Se nao houver imagem ou link, nao da para salvar a noticia corretamente.
      if ($img == "" || $link == "") {
        // Registra o item incompleto como erro.
        $array_erros[] = $hashNoticia;

        // Continua para o proximo video.
        continue;
      }

      // Garante que o titulo da noticia tenha relacao com a tag buscada.
      if (!$tag || !$this->validaNoticiaTag($tag, $this->removeEmoji($titulo))) {
        // Ignora silenciosamente para manter o comportamento antigo.
        continue;
      }

      // Se existe link do video, entra nele para capturar a data real.
      if ($link != "") {
        // Pausa entre requisicoes para evitar chamadas muito agressivas.
        $this->pauseTime();

        // Baixa o HTML do video cronometrando essa requisicao.
        $data2 = $this->getCurlCronometrado($link, $tempos, 'link_data');

        // Extrai a data real do HTML ou usa a data relativa como fallback.
        $data = $this->dataPublicacaoYoutube($data2, $item['data'] ?? '');
      }

      // Monta um nome unico para salvar a imagem no storage publico.
      $filename = date('Ymdhis') . '_' . Str::slug($this->removeEmoji($titulo)) . '-' . $hash . '.jpg';

      // Caminho fisico onde as imagens de noticia ficam salvas.
      $destinationPath = public_path() . '/uploads/news/';

      // Baixa a imagem original e mede o tempo do download.
      $this->downloadFileOriginalCronometrado($filename, $img, $destinationPath, $tempos);

      // Cria o model de noticia que sera salvo no banco.
      $insert = new News;

      // Salva o titulo sem emoji para evitar problemas de exibicao/banco.
      $insert->title = $this->removeEmoji($titulo);

      // Relaciona a noticia ao canal atual.
      $insert->channels_id = $channel->id;

      // Slug publico baseado no titulo.
      $insert->slug = Str::slug($titulo);

      // Hash unico usado para evitar duplicidade.
      $insert->hash = $hashNoticia;

      // Link original do video.
      $insert->link = $link;

      // Caminho publico da imagem baixada.
      $insert->image = '/uploads/news/' . $filename;

      // Status padrao para exibir a noticia.
      $insert->status = "show";

      // Ordem padrao usada pela listagem.
      $insert->order = 0;

      // Data extraida do Youtube.
      $insert->data = $data;

      // Salva a noticia no banco e guarda o resultado.
      $condition = $insert->save();

      // Se salvou a noticia, garante tambem o relacionamento com a tag.
      if ($condition) {
        // Verifica se a relacao news_tags ja existe.
        $news_tags = NewsTags::where('news_id', '=', $insert->id)->where('tags_id', '=', $tag->id)->first();

        // Cria a relacao news_tags quando ela ainda nao existe.
        if (!$news_tags) {
          $insert_news_tags = new NewsTags;
          $insert_news_tags->news_id = $insert->id;
          $insert_news_tags->tags_id = $tag->id;
          $insert_news_tags->save();
        }

        // Registra a noticia adicionada no retorno.
        $array_adicionados[] = $insert->id . ' ' . $hashNoticia;
      }
    }

    // Retorna o resultado padronizado do crawler.
    return [
      // Codigo 000 indica que a execucao terminou normalmente.
      'code' => '000',

      // Noticias adicionadas nesta execucao.
      'adicionados' => $array_adicionados,

      // Noticias que ja existiam.
      'existentes' => $array_existentes,

      // Erros ou itens ignorados.
      'erros' => $array_erros,

      // Resumo completo dos tempos medidos.
      'tempos' => $this->finalizaTempos($tempos, $tempo_inicio),

      // Data da execucao.
      'date' => date("Y-m-d"),

      // Hora da execucao.
      'hour' => date("H:i:s"),
    ];
  }

  // Wrapper do crawler Youtube para o canal Matando Robos Gigantes.

  public function buscaMatandoRobosGigantesYoutube()
  {
    return $this->buscaYoutubePorHash('matandorobosgigantesyoutube', 'matandorobosgigantes');
  }

  // Wrapper do crawler Youtube para o canal Thiago Romariz.

  public function buscaThiagoRomarizYoutube()
  {
    return $this->buscaYoutubePorHash('thiagoromarizyoutube', 'ThiagoRomariz');
  }

  // Wrapper do crawler Youtube para o canal Entre Migas.

  public function buscaEntreMigasYoutube()
  {
    return $this->buscaYoutubePorHash('entremigasyoutube', 'EntreMigas');
  }

  // Wrapper do crawler Youtube para o canal Miguel Lokia.

  public function buscaMiguelLokiaYoutube()
  {
    return $this->buscaYoutubePorHash('miguellokiayoutube', 'MiguelLokiaMesmo');
  }

  // Wrapper do crawler Youtube para o canal Gustavo Cunha.

  public function buscaGustavoCunhaYoutube()
  {
    return $this->buscaYoutubePorHash('gustavocunhayoutube', 'GustavoCunhavideos');
  }

  // Wrapper do crawler Youtube para o canal Nerd News.

  public function buscaNerdNewsYoutube()
  {
    return $this->buscaYoutubePorHash('nerdnewsyoutube', 'NerdNewsOficial');
  }

  // Wrapper do crawler Youtube para o canal Sessao Nerd.

  public function buscaSessaoNerdYoutube()
  {
    return $this->buscaYoutubePorHash('sessaonerdyoutube', 'SessãoNerdOficial');
  }

  // Wrapper do crawler Youtube para o canal Arena Nerd.

  public function buscaArenaNerdYoutube()
  {
    return $this->buscaYoutubePorHash('arenanerdyoutube', 'ArenaNerdOficial');
  }

  // Wrapper do crawler Youtube para o canal Caldeirao Nerd.

  public function buscaCaldeiraoNerdYoutube()
  {
    return $this->buscaYoutubePorHash('caldeiraonerdyoutube', 'CaldeirãoNerd');
  }

  // Wrapper do crawler Youtube para o canal Nerd Experience.

  public function buscaNerdExperienceYoutube()
  {
    return $this->buscaYoutubePorHash('nerdexperienceyoutube', 'NERDEXPERIENCEOFICIAL');
  }

  // Wrapper do crawler Youtube para o canal Cris Panda.

  public function buscaCrisPandaYoutube()
  {
    return $this->buscaYoutubePorHash('crispandayoutube', 'CoxinhaNerd');
  }

  // Wrapper do crawler Youtube para o canal Nerd Rabugento.

  public function buscaNerdRabugentoYoutube()
  {
    return $this->buscaYoutubePorHash('nerdrabugentoyoutube', 'NerdRabugentoOficial');
  }

  // Wrapper do crawler Youtube para o canal Operacao Cinema.

  public function buscaOperacaoCinemaYoutube()
  {
    return $this->buscaYoutubePorHash('operacaocinemayoutube', 'OperaçãoCinema');
  }

  // Wrapper do crawler Youtube para o canal Quatro Coisas.

  public function buscaQuatroCoisasYoutube()
  {
    return $this->buscaYoutubePorHash('quatrocoisasyoutube', 'Qu4troCoisas');
  }

  // Wrapper do crawler Youtube para o canal Caverna do Caruso.

  public function buscaCavernaDoCarusoYoutube()
  {
    return $this->buscaYoutubePorHash('cavernadocarusoyoutube', 'CAVERNADOCARUSO');
  }

  // Wrapper do crawler Youtube para o canal Caique Izoton.

  public function buscaCaiqueIzotonYoutube()
  {
    return $this->buscaYoutubePorHash('caiqueizotonyoutube', 'CaiqueIzoton');
  }

  // Wrapper do crawler Youtube para o canal Cinema com Rapadura.

  public function buscaCinemaComRapaduraYoutube()
  {
    return $this->buscaYoutubePorHash('cinemacomrapadurayoutube', 'CinemacomRapaduraoficial');
  }

  // Wrapper do crawler Youtube para o canal Nerd Land.

  public function buscaNewsNerdLandYoutube()
  {
    return $this->buscaYoutubePorHash('nerdlandyoutube', 'NerdLand');
  }

  // Wrapper do crawler Youtube para o canal Ei Nerd.

  public function buscaNewsEiNerdYoutube()
  {
    return $this->buscaYoutubePorHash('einerdyoutube', 'einerdtv');
  }

  // Wrapper do crawler Youtube para o canal Pipocando.

  public function buscaNewsPipocandoYoutube()
  {
    return $this->buscaYoutubePorHash('pipocandoyoutube', 'Pipocando');
  }

  // Wrapper do crawler Youtube para o canal Omelete.

  public function buscaNewsOmeleteYoutube()
  {
    return $this->buscaYoutubePorHash('omeleteyoutube', 'omeleteve');
  }

  // Wrapper do crawler Youtube para o canal Jovem Nerd.

  public function buscaNewsJovemNerdYoutube()
  {
    return $this->buscaYoutubePorHash('jovemnerdyoutube', 'JovemNerd');
  }

  // Wrapper do crawler Youtube para o canal Super Oito.

  public function buscaNewsSuperOitoYoutube()
  {
    return $this->buscaYoutubePorHash('superoitoyoutube', 'otaviouga');
  }

  // Crawler do site Jovem Nerd, incluindo segunda requisicao para imagem principal.

  public function buscaNewsJovemNerdSite()
  {

    $channel = Channels::where('hash', '=', 'jovemnerdsite')->firstOrFail();
    $url = "";

    $array_adicionados = [];
    $array_existentes = [];
    $array_erros = [];
    $tempo_inicio = microtime(true);
    $tempos = [];

    if ($channel) {
      $hora = date('H:i:s');
      // echo $hora;
      // echo "<br>";
      // echo $hora_30;
      $crawlers = $this->crawlersNoHorarioAtual($hora);
      $count = 1;
      foreach ($crawlers as $key => $value) {
        // echo "crawler";
        if ($count) {
          $tag = Tags::where('id', '=', $value->tags_id)->where('status', '=', 'active')->firstOrFail();
          if ($tag) {
            $url = $this->montaUrlBuscaJovemNerd(trim($channel->url_crawler), $tag->title);
            // echo $url;
          }
        }
        $count++;
      }
    }
    // echo 'url:'.$url;
    if ($url == "") {
      $retorno = [
        'code' => '003',
        'adicionados' => $array_adicionados,
        'existentes' => $array_existentes,
        'erros' => $array_erros,
        'tempos' => $this->finalizaTempos($tempos, $tempo_inicio),
        'date' => date("Y-m-d"),
        'hour' => date("H:i:s"),
      ];
      return $retorno;
    }

    $html = $this->getCurlCronometrado($url, $tempos, 'busca_listagem');
    $return = ['content' => $this->medeTempo($tempos, 'extracao_listagem', $url, function () use ($html, &$array_erros, &$tempos) {
      return $this->extraiNoticiasJovemNerd($html, $array_erros, $tempos);
    })];

    if (empty($html)) {
      $array_erros[] = 'Jovem Nerd: retorno vazio ao buscar URL ' . $url;
    }

    if (count($return['content'] ?? []) == 0) {
      $array_erros[] = 'Jovem Nerd: nenhuma notícia extraída da URL ' . $url;
    }

    if (count($return['content'] ?? []) > 0) {
      foreach ($return['content'] as $item) {

        //Validando os campos
        $validator = Validator::make(
          ['hash' => Str::slug($item['noticia'] . '-jovemnerdsite')],
          [
            'hash' => 'required|unique:news',
          ],
          $messages = [
            'unique' => 'Notícia já existe.',
          ]
        );

        if ($validator->fails()) {

          $news = News::where('hash', '=', Str::slug($item['noticia'] . '-jovemnerdsite'))->first();

          if ($news && $this->validaNoticiaTag($tag, $this->removeEmoji($item['noticia']))) {
            $news_tags = NewsTags::where('news_id', '=', $news->id)->where('tags_id', '=', $tag->id)->first();

            if (!$news_tags) {
              $insert_news_tags = new NewsTags;
              $insert_news_tags->news_id = $news->id;
              $insert_news_tags->tags_id = $tag->id;
              $insert_news_tags->save();
            }
          }

          // Validation 
          array_push(
            $array_existentes,
            Str::slug($item['noticia'] . '-jovemnerdsite')
          );
        } else {

          $img = "";
          $link = "";
          $data = "";

          if ($item['img']) {
            $img = $item['img'];
          }

          if ($item['url']) {
            $link = $item['url'];
          }

          if ($item['data']) {
            $data = $this->formata_data(1, trim($item['data']));
          }
          if ($img != "" && $link != "") {
            $data_json = "";
            if ($this->validaNoticiaTag($tag, $this->removeEmoji($item['noticia']))) {
              //Baixa imagem
              $file = $img;
              $filename = date('Ymdhis') . '_' . Str::slug($this->removeEmoji($item['noticia'])) . '-jovemnerdsite' . '.jpg';
              $destinationPath = public_path() . '/uploads/news/';

              $upload = $this->downloadFileOriginalCronometrado($filename, $file, $destinationPath, $tempos);

              $insert = new News;
              $insert->title = $this->removeEmoji($item['noticia']);
              $insert->channels_id = $channel->id;
              $insert->slug = Str::slug($item['noticia']);
              $insert->hash = Str::slug($item['noticia'] . '-jovemnerdsite');
              $insert->link = $link;
              $insert->image = '/uploads/news/' . $filename;
              $insert->status = "show";
              $insert->order = 0;

              $insert->data = $data;
              $condition = $insert->save();
              if ($condition) {

                $news_tags = NewsTags::where('news_id', '=', $insert->id)->where('tags_id', '=', $tag->id)->first();

                if (!$news_tags) {
                  $insert_news_tags = new NewsTags;
                  $insert_news_tags->news_id = $insert->id;
                  $insert_news_tags->tags_id = $tag->id;
                  $insert_news_tags->save();
                }

                array_push(
                  $array_adicionados,
                  $insert->id . ' ' . Str::slug($item['noticia'] . '-jovemnerdsite')
                );
              }
            } else {
              array_push(
                $array_erros,
                'Ignorada por não bater com a tag "' . $tag->title . '": ' . $item['noticia']
              );
            }
          } else {
            array_push(
              $array_erros,
              Str::slug($item['noticia'] . '-jovemnerdsite')
            );
          }
        }
      }
    }

    $retorno = [
      'code' => '000',
      'adicionados' => $array_adicionados,
      'existentes' => $array_existentes,
      'erros' => $array_erros,
        'tempos' => $this->finalizaTempos($tempos, $tempo_inicio),
      'date' => date("Y-m-d"),
      'hour' => date("H:i:s"),
    ];
    return $retorno;
  }

  // Crawler do site Omelete usando a busca configurada no banco.

  public function buscaNewsOmeleteSite()
  {

    $channel = Channels::where('hash', '=', 'omeletesite')->firstOrFail();
    $url = "";

    $array_adicionados = [];
    $array_existentes = [];
    $array_erros = [];
    $tempo_inicio = microtime(true);
    $tempos = [];

    if ($channel) {
      $hora = date('H:i:s');
      // echo $hora;
      // echo "<br>";
      // echo $hora_30;
      $crawlers = $this->crawlersNoHorarioAtual($hora);
      $count = 1;
      foreach ($crawlers as $key => $value) {
        // echo "crawler";
        if ($count) {
          $tag = Tags::where('id', '=', $value->tags_id)->where('status', '=', 'active')->firstOrFail();
          if ($tag) {
            $url = $this->montaUrlBuscaCrawler(trim($channel->url_crawler), $tag->title);
            // echo $url;
          }
        }
        $count++;
      }
    }
    // echo 'url:'.$url;
    if ($url == "") {
      $retorno = [
        'code' => '003',
        'adicionados' => $array_adicionados,
        'existentes' => $array_existentes,
        'erros' => $array_erros,
        'tempos' => $this->finalizaTempos($tempos, $tempo_inicio),
        'date' => date("Y-m-d"),
        'hour' => date("H:i:s"),
      ];
      return $retorno;
    }

    // $url = "https://www.omelete.com.br/filmes";

    $html = $this->getCurlCronometrado($url, $tempos, 'busca_listagem');
    $return = ['content' => $this->medeTempo($tempos, 'extracao_listagem', $url, function () use ($html, &$array_erros, $url) {
      return $this->extraiNoticiasOmelete($html, $array_erros, $url);
    })];

    if (empty($html)) {
      $array_erros[] = 'Omelete: retorno vazio ao buscar URL ' . $url;
    }

    if (count($return['content'] ?? []) == 0) {
      $array_erros[] = 'Omelete: nenhuma notícia extraída da URL ' . $url;
    }


    if (count($return['content'] ?? []) > 0) {
      foreach ($return['content'] as $item) {

        //Validando os campos
        $validator = Validator::make(
          ['hash' => Str::slug($item['noticia'] . '-omeletesite')],
          [
            'hash' => 'required|unique:news',
          ],
          $messages = [
            'unique' => 'Notícia já existe.',
          ]
        );

        if ($validator->fails()) {

          $news = News::where('hash', '=', Str::slug($item['noticia'] . '-omeletesite'))->first();

          if ($news && $this->validaNoticiaTag($tag, $this->removeEmoji($item['noticia']))) {
            $news_tags = NewsTags::where('news_id', '=', $news->id)->where('tags_id', '=', $tag->id)->first();

            if (!$news_tags) {
              $insert_news_tags = new NewsTags;
              $insert_news_tags->news_id = $news->id;
              $insert_news_tags->tags_id = $tag->id;
              $insert_news_tags->save();
            }
          }

          // Validation 
          array_push(
            $array_existentes,
            Str::slug($item['noticia'] . '-omeletesite')
          );
        } else {

          $img = "";
          $link = "";
          $data = "";

          if ($item['img']) {
            $img = $item['img'];
          }

          if ($item['url']) {
            $link = $item['url'];
          }

          if ($item['data']) {
            $data = $item['data'];
          }


          if ($img != "" && $link != "") {
            $data_json = "";
            if ($this->validaNoticiaTag($tag, $this->removeEmoji($item['noticia']))) {
              //Baixa imagem
              $file = $img;
              $filename = date('Ymdhis') . '_' . Str::slug($this->removeEmoji($item['noticia'])) . '-omeletesite' . '.jpg';
              $destinationPath = public_path() . '/uploads/news/';
              $upload = $this->downloadFileOriginalCronometrado($filename, $file, $destinationPath, $tempos);

              $insert = new News;
              $insert->title = $this->removeEmoji($item['noticia']);
              $insert->channels_id = $channel->id;
              $insert->slug = Str::slug($item['noticia']);
              $insert->hash = Str::slug($item['noticia'] . '-omeletesite');
              $insert->link = $link;
              $insert->image = '/uploads/news/' . $filename;
              $insert->status = "show";
              $insert->order = 0;

              $insert->data = $data;
              $condition = $insert->save();
              if ($condition) {

                $news_tags = NewsTags::where('news_id', '=', $insert->id)->where('tags_id', '=', $tag->id)->first();

                if (!$news_tags) {
                  $insert_news_tags = new NewsTags;
                  $insert_news_tags->news_id = $insert->id;
                  $insert_news_tags->tags_id = $tag->id;
                  $insert_news_tags->save();
                }

                array_push(
                  $array_adicionados,
                  $insert->id . ' ' . Str::slug($item['noticia'] . '-omeletesite')
                );
              }
            } else {
              array_push(
                $array_erros,
                'Ignorada por não bater com a tag "' . $tag->title . '": ' . $item['noticia']
              );
            }
          } else {
            array_push(
              $array_erros,
              Str::slug($item['noticia'] . '-omeletesite')
            );
          }
        }
      }
    }

    $retorno = [
      'code' => '000',
      'adicionados' => $array_adicionados,
      'existentes' => $array_existentes,
      'erros' => $array_erros,
        'tempos' => $this->finalizaTempos($tempos, $tempo_inicio),
      'date' => date("Y-m-d"),
      'hour' => date("H:i:s"),
    ];
    return $retorno;
  }

  // Extrai titulo, link, imagem e data dos cards do Omelete.

  public function extraiNoticiasOmelete($html, &$erros = [], $urlBase = "")
  {
    $noticias = [];
    $linksEncontrados = [];
    $crawler = new HtmlCrawler($html);
    $cards = $crawler->filter('article.card--news');

    if ($cards->count() == 0) {
      $erros[] = 'Omelete: nenhum card article.card--news encontrado no HTML atual.';
    }

    foreach ($cards as $cardNode) {
      $card = new HtmlCrawler($cardNode);
      $linkNode = $card->filter('a[href]')->first();
      $tituloNode = $card->filter('.card__title, h2')->first();
      $imagemNode = $card->filter('.card__image img, img')->first();
      $dataNode = $card->filter('[data-published]')->first();

      if ($linkNode->count() == 0 || $tituloNode->count() == 0 || $imagemNode->count() == 0) {
        continue;
      }

      $titulo = trim(html_entity_decode($tituloNode->text('', true), ENT_QUOTES | ENT_HTML5, 'UTF-8'));
      $link = $this->normalizaUrlTecMundo($linkNode->attr('href') ?? '', $urlBase);
      $imagem = $imagemNode->attr('data-lazy-src') ?: ($imagemNode->attr('src') ?: ($imagemNode->attr('data-src') ?? ''));
      $imagem = $this->normalizaImagemOmelete($this->normalizaUrlTecMundo($imagem, $urlBase));
      $data = $this->normalizaDataOmelete($dataNode->count() > 0 ? ($dataNode->attr('data-published') ?? '') : '');

      if ($titulo == "" || $link == "" || $imagem == "") {
        $erros[] = 'Omelete: notícia ignorada com dados incompletos: ' . ($titulo ?: '[sem titulo]');
        continue;
      }

      if (isset($linksEncontrados[$link])) {
        continue;
      }

      $linksEncontrados[$link] = true;

      $noticias[] = [
        'url' => $link,
        'noticia' => $titulo,
        'img' => $imagem,
        'data' => $data,
      ];

      if (count($noticias) >= $this->qtd_noticias_por_canal()) {
        break;
      }
    }

    return $noticias;
  }

  // Remove transformacoes de CDN para tentar usar a imagem original do Omelete.

  public function normalizaImagemOmelete($urlImagem)
  {
    $urlImagem = $this->normalizaImagemOriginal($urlImagem);

    if ($urlImagem == "") {
      return "";
    }

    if (preg_match('#^https?://cdn\.ome\.lt/[^/]+=/[^/]+/smart/filters:[^/]+/(extras/conteudos/.+)$#', $urlImagem, $match)) {
      return 'https://cdn.ome.lt/' . $match[1];
    }

    return $urlImagem;
  }

  // Converte datas do Omelete para o formato Y-m-d.

  public function normalizaDataOmelete($data)
  {
    $data = trim($data);

    if ($data == "") {
      return date('Y-m-d');
    }

    $timestamp = strtotime($data);

    if (!$timestamp) {
      return date('Y-m-d');
    }

    return date('Y-m-d', $timestamp);
  }

  // Extrai a data real de publicacao de uma pagina de video do Youtube.

  public function dataPublicacaoYoutube($html, $fallback = "")
  {
    $padroes = [
      '/<meta itemprop="datePublished" content="([^"]+)"/',
      '/"(?:datePublished|publishDate|uploadDate)"\s*:\s*"([^"]+)"/',
    ];

    foreach ($padroes as $padrao) {
      if (preg_match($padrao, $html, $match)) {
        $timestamp = strtotime($match[1]);

        if ($timestamp) {
          return date('Y-m-d', $timestamp);
        }
      }
    }

    return $this->normalizaDataRelativaYoutube($fallback);
  }

  // Corrige datas invalidas de noticias Youtube que ja estavam salvas.

  public function corrigeDataYoutubeExistente($news, $item, &$tempos = [])
  {
    if (!$news || !isset($item['url']) || $item['url'] == "") {
      return;
    }

    if ($news->data != "" && $news->data != "0000-00-00" && !is_null($news->data)) {
      return;
    }

    $this->pauseTime();
    $data2 = $this->getCurlCronometrado($item['url'], $tempos, 'link_data_existente');
    $news->data = $this->dataPublicacaoYoutube($data2, $item['data'] ?? '');
    $news->save();
  }

  // Converte datas relativas do Youtube para o formato Y-m-d.

  public function normalizaDataRelativaYoutube($data)
  {
    $data = trim(mb_strtolower($data));

    if ($data == "") {
      return date('Y-m-d');
    }

    if (strpos($data, 'hoje') !== false) {
      return date('Y-m-d');
    }

    if (strpos($data, 'ontem') !== false) {
      return date('Y-m-d', strtotime('-1 day'));
    }

    if (preg_match('/há\s+(\d+)\s+(segundo|segundos|minuto|minutos|hora|horas|dia|dias|semana|semanas|mês|mes|meses|ano|anos)/u', $data, $match)) {
      $quantidade = (int) $match[1];
      $unidade = $match[2];

      $mapa = [
        'segundo' => 'second',
        'segundos' => 'second',
        'minuto' => 'minute',
        'minutos' => 'minute',
        'hora' => 'hour',
        'horas' => 'hour',
        'dia' => 'day',
        'dias' => 'day',
        'semana' => 'week',
        'semanas' => 'week',
        'mês' => 'month',
        'mes' => 'month',
        'meses' => 'month',
        'ano' => 'year',
        'anos' => 'year',
      ];

      return date('Y-m-d', strtotime('-' . $quantidade . ' ' . ($mapa[$unidade] ?? 'day')));
    }

    if (preg_match('/(\d+)\s+(second|minute|hour|day|week|month|year)s?\s+ago/u', $data, $match)) {
      return date('Y-m-d', strtotime('-' . (int) $match[1] . ' ' . $match[2]));
    }

    $timestamp = strtotime($data);

    if ($timestamp) {
      return date('Y-m-d', $timestamp);
    }

    return date('Y-m-d');
  }

  // Crawler do TecMundo usando HTML e API de busca quando disponivel.

  public function buscaTecMundoSite()
  {

    $channel = Channels::where('hash', '=', 'tecmundosite')->firstOrFail();
    $url = "";

    $array_adicionados = [];
    $array_existentes = [];
    $array_erros = [];
    $tempo_inicio = microtime(true);
    $tempos = [];

    if ($channel) {
      $hora = date('H:i:s');
      // echo $hora;
      // echo "<br>";
      // echo $hora_30;
      $crawlers = $this->crawlersNoHorarioAtual($hora);
      $count = 1;
      foreach ($crawlers as $key => $value) {
        // echo "crawler";
        if ($count) {
          $tag = Tags::where('id', '=', $value->tags_id)->where('status', '=', 'active')->firstOrFail();
          if ($tag) {
            $url = $this->montaUrlBuscaCrawler(trim($channel->url_crawler), $tag->title);
            // echo $url;
          }
        }
        $count++;
      }
    }
    // echo 'url:'.$url;
    if ($url == "") {
      $retorno = [
        'code' => '003',
        'adicionados' => $array_adicionados,
        'existentes' => $array_existentes,
        'erros' => $array_erros,
        'tempos' => $this->finalizaTempos($tempos, $tempo_inicio),
        'date' => date("Y-m-d"),
        'hour' => date("H:i:s"),
      ];
      return $retorno;
    }

    $html = $this->getCurlCronometrado($url, $tempos, 'busca_listagem');
    $return = ['content' => $this->medeTempo($tempos, 'extracao_listagem', $url, function () use ($html, &$array_erros, $url, &$tempos) {
      return $this->extraiNoticiasTecMundo($html, $array_erros, $url, $tempos);
    })];

    if (empty($html)) {
      $array_erros[] = 'TecMundo: retorno vazio ao buscar URL ' . $url;
    }

    if (count($return['content'] ?? []) == 0) {
      $array_erros[] = 'TecMundo: nenhuma notícia extraída da URL ' . $url;
    }

    if (count($return['content'] ?? []) > 0) {
      foreach ($return['content'] as $item) {

        //Validando os campos
        $validator = Validator::make(
          ['hash' => Str::slug($item['noticia'] . '-tecmundosite')],
          [
            'hash' => 'required|unique:news',
          ],
          $messages = [
            'unique' => 'Notícia já existe.',
          ]
        );

        if ($validator->fails()) {

          $news = News::where('hash', '=', Str::slug($item['noticia'] . '-tecmundosite'))->first();

          if ($news && $this->validaNoticiaTag($tag, $this->removeEmoji($item['noticia']))) {
            $news_tags = NewsTags::where('news_id', '=', $news->id)->where('tags_id', '=', $tag->id)->first();

            if (!$news_tags) {
              $insert_news_tags = new NewsTags;
              $insert_news_tags->news_id = $news->id;
              $insert_news_tags->tags_id = $tag->id;
              $insert_news_tags->save();
            }
          }

          // Validation 
          array_push(
            $array_existentes,
            Str::slug($item['noticia'] . '-tecmundosite')
          );
        } else {

          $img = "";
          $link = "";
          $data = "";

          if ($item['img']) {
            $img = $item['img'];
          }

          if ($item['url']) {
            $link = $item['url'];
          }

          if ($item['data']) {
            $data = $this->formata_data(1, trim($item['data']));
          }
          if ($img != "" && $link != "") {
            $data_json = "";
            if ($this->validaNoticiaTag($tag, $this->removeEmoji($item['noticia']))) {
              //Baixa imagem
              $file = $img;
              $filename = date('Ymdhis') . '_' . Str::slug($this->removeEmoji($item['noticia'])) . '-tecmundosite' . '.jpg';
              $destinationPath = public_path() . '/uploads/news/';
              $upload = $this->downloadFileOriginalCronometrado($filename, $file, $destinationPath, $tempos);

              $insert = new News;
              $insert->title = $this->removeEmoji($item['noticia']);
              $insert->channels_id = $channel->id;
              $insert->slug = Str::slug($item['noticia']);
              $insert->hash = Str::slug($item['noticia'] . '-tecmundosite');
              $insert->link = $link;
              $insert->image = '/uploads/news/' . $filename;
              $insert->status = "show";
              $insert->order = 0;

              $insert->data = $data;
              $condition = $insert->save();
              if ($condition) {

                $news_tags = NewsTags::where('news_id', '=', $insert->id)->where('tags_id', '=', $tag->id)->first();

                if (!$news_tags) {
                  $insert_news_tags = new NewsTags;
                  $insert_news_tags->news_id = $insert->id;
                  $insert_news_tags->tags_id = $tag->id;
                  $insert_news_tags->save();
                }

                array_push(
                  $array_adicionados,
                  $insert->id . ' ' . Str::slug($item['noticia'] . '-tecmundosite')
                );
              }
            } else {
              array_push(
                $array_erros,
                'Ignorada por não bater com a tag "' . $tag->title . '": ' . $item['noticia']
              );
            }
          } else {
            array_push(
              $array_erros,
              Str::slug($item['noticia'] . '-tecmundosite')
            );
          }
        }
      }
    }

    $retorno = [
      'code' => '000',
      'adicionados' => $array_adicionados,
      'existentes' => $array_existentes,
      'erros' => $array_erros,
        'tempos' => $this->finalizaTempos($tempos, $tempo_inicio),
      'date' => date("Y-m-d"),
      'hour' => date("H:i:s"),
    ];
    return $retorno;
  }

  // Crawler do site Poltrona Nerd usando a busca configurada no banco.

  public function buscaPoltronaNerdSite()
  {

    $channel = Channels::where('hash', '=', 'poltronanerdsite')->firstOrFail();
    $url = "";

    $array_adicionados = [];
    $array_existentes = [];
    $array_erros = [];
    $tempo_inicio = microtime(true);
    $tempos = [];

    if ($channel) {
      $hora = date('H:i:s');
      // echo $hora;
      // echo "<br>";
      // echo $hora_30;
      $crawlers = $this->crawlersNoHorarioAtual($hora);
      $count = 1;
      foreach ($crawlers as $key => $value) {
        // echo "crawler";
        if ($count) {
          $tag = Tags::where('id', '=', $value->tags_id)->where('status', '=', 'active')->firstOrFail();
          if ($tag) {
            $url = $channel->url_crawler . str_replace(" ", "+", $tag->title);
            // echo $url;
          }
        }
        $count++;
      }
    }
    // echo 'url:'.$url;
    if ($url == "") {
      $retorno = [
        'code' => '003',
        'adicionados' => $array_adicionados,
        'existentes' => $array_existentes,
        'erros' => $array_erros,
        'tempos' => $this->finalizaTempos($tempos, $tempo_inicio),
        'date' => date("Y-m-d"),
        'hour' => date("H:i:s"),
      ];
      return $retorno;
    }

    $html = $this->getCurlCronometrado($url, $tempos, 'busca_listagem');
    $return = ['content' => $this->medeTempo($tempos, 'extracao_listagem', $url, function () use ($html, &$array_erros, $url) {
      return $this->extraiNoticiasPoltronaNerd($html, $array_erros, $url);
    })];

    if (empty($html)) {
      $array_erros[] = 'Poltrona Nerd: retorno vazio ao buscar URL ' . $url;
    }

    if (count($return['content'] ?? []) == 0) {
      $array_erros[] = 'Poltrona Nerd: nenhuma notícia extraída da URL ' . $url;
    }

    if (count($return['content'] ?? []) > 0) {
      foreach ($return['content'] as $item) {

        //Validando os campos
        $validator = Validator::make(
          ['hash' => Str::slug($item['noticia'] . '-poltronanerdsite')],
          [
            'hash' => 'required|unique:news',
          ],
          $messages = [
            'unique' => 'Notícia já existe.',
          ]
        );

        if ($validator->fails()) {

          $news = News::where('hash', '=', Str::slug($item['noticia'] . '-poltronanerdsite'))->first();

          if ($news && $this->validaNoticiaTag($tag, $this->removeEmoji($item['noticia']))) {
            $news_tags = NewsTags::where('news_id', '=', $news->id)->where('tags_id', '=', $tag->id)->first();

            if (!$news_tags) {
              $insert_news_tags = new NewsTags;
              $insert_news_tags->news_id = $news->id;
              $insert_news_tags->tags_id = $tag->id;
              $insert_news_tags->save();
            }
          }

          // Validation 
          array_push(
            $array_existentes,
            Str::slug($item['noticia'] . '-poltronanerdsite')
          );
        } else {

          $img = "";
          $link = "";
          $data = "";

          if ($item['img']) {
            $img = $item['img'];
          }

          if ($item['url']) {
            $link = $item['url'];
          }

          if ($item['data']) {
            $data = $this->formata_data(1, trim($item['data']));
          }
          if ($img != "" && $link != "") {
            $data_json = "";
            if ($this->validaNoticiaTag($tag, $this->removeEmoji($item['noticia']))) {
              //Baixa imagem
              $file = $img;
              $filename = date('Ymdhis') . '_' . Str::slug($this->removeEmoji($item['noticia'])) . '-poltronanerdsite' . '.jpg';
              $destinationPath = public_path() . '/uploads/news/';
              $upload = $this->downloadFileOriginalCronometrado($filename, $file, $destinationPath, $tempos);

              $insert = new News;
              $insert->title = $this->removeEmoji($item['noticia']);
              $insert->channels_id = $channel->id;
              $insert->slug = Str::slug($item['noticia']);
              $insert->hash = Str::slug($item['noticia'] . '-poltronanerdsite');
              $insert->link = $link;
              $insert->image = '/uploads/news/' . $filename;
              $insert->status = "show";
              $insert->order = 0;

              $insert->data = $data;
              $condition = $insert->save();
              if ($condition) {

                $news_tags = NewsTags::where('news_id', '=', $insert->id)->where('tags_id', '=', $tag->id)->first();

                if (!$news_tags) {
                  $insert_news_tags = new NewsTags;
                  $insert_news_tags->news_id = $insert->id;
                  $insert_news_tags->tags_id = $tag->id;
                  $insert_news_tags->save();
                }

                array_push(
                  $array_adicionados,
                  $insert->id . ' ' . Str::slug($item['noticia'] . '-poltronanerdsite')
                );
              }
            } else {
              array_push(
                $array_erros,
                'Ignorada por não bater com a tag "' . $tag->title . '": ' . $item['noticia']
              );
            }
          } else {
            array_push(
              $array_erros,
              Str::slug($item['noticia'] . '-poltronanerdsite')
            );
          }
        }
      }
    }

    $retorno = [
      'code' => '000',
      'adicionados' => $array_adicionados,
      'existentes' => $array_existentes,
      'erros' => $array_erros,
        'tempos' => $this->finalizaTempos($tempos, $tempo_inicio),
      'date' => date("Y-m-d"),
      'hour' => date("H:i:s"),
    ];
    return $retorno;
  }

  // Crawler de podcasts Spotify para Cinema com Rapadura.

  public function buscaNewsCinemaComRapaduraSpotify()
  {
    // Usa a rotina padronizada para permitir novos podcasts sem duplicar codigo.
    return $this->buscaSpotifyPorHash('cinemacomrapaduraspotify');
  }

  // Crawler de podcasts Spotify para Jovem Nerd.

  public function buscaNewsJovemNerdSpotify()
  {
    // Usa a rotina padronizada lendo o link do canal no banco.
    return $this->buscaSpotifyPorHash('jovemnerdspotify');
  }

  // Crawler generico de podcasts Spotify por hash do canal cadastrado.

  public function buscaSpotifyPorHash($hash, $tagTitulo = "")
  {
    // Guarda os novos podcasts salvos nesta execucao.
    $array_adicionados = [];
    // Guarda os podcasts que ja existiam pelo hash unico.
    $array_existentes = [];
    // Guarda problemas reais e episodios ignorados por filtro de tag.
    $array_erros = [];
    // Marca o inicio para devolver o tempo total no mesmo formato dos outros crawlers.
    $tempo_inicio = microtime(true);
    // Lista detalhada de tempos por chamada externa ou etapa pesada.
    $tempos = [];
    // Procura o canal pelo hash, igual aos crawlers de YouTube.
    $channel = Channels::where('hash', '=', $hash)->first();

    if (!$channel) {
      return [
        'code' => '003',
        'adicionados' => $array_adicionados,
        'existentes' => $array_existentes,
        'erros' => ['Canal Spotify nao encontrado para o hash: ' . $hash],
        'tempos' => $this->finalizaTempos($tempos, $tempo_inicio),
        'date' => date("Y-m-d"),
        'hour' => date("H:i:s"),
      ];
    }

    // Usa url_crawler quando existir; nos canais antigos de podcast o link esta no campo link.
    $urlSpotify = trim($channel->url_crawler ?: $channel->link);

    // Extrai o ID do show a partir da URL salva no banco ou de um ID puro.
    $showId = $this->extraiSpotifyShowId($urlSpotify);

    if ($showId == "") {
      return [
        'code' => '004',
        'adicionados' => $array_adicionados,
        'existentes' => $array_existentes,
        'erros' => ['URL/ID Spotify invalido no canal: ' . $urlSpotify],
        'tempos' => $this->finalizaTempos($tempos, $tempo_inicio),
        'date' => date("Y-m-d"),
        'hour' => date("H:i:s"),
      ];
    }

    // Busca a tag dinamica do horario atual quando nenhuma tag foi passada manualmente.
    $tag = $this->tagAtualParaPodcast($tagTitulo);
    // Limita a quantidade para reduzir chamada externa e risco de rate limit.
    $limite = min(max((int) $this->qtd_noticias_por_canal(), 1), 50);
    // Busca os episodios diretamente pela biblioteca do Spotify, usando o show/canal salvo no banco.
    $episodios = $this->buscaEpisodiosSpotifyPorBiblioteca($showId, $limite, $tempos, $array_erros);

    if (count($episodios) == 0) {
      return [
        'code' => '005',
        'adicionados' => $array_adicionados,
        'existentes' => $array_existentes,
        'erros' => $array_erros,
        'tempos' => $this->finalizaTempos($tempos, $tempo_inicio),
        'date' => date("Y-m-d"),
        'hour' => date("H:i:s"),
      ];
    }

    foreach ($episodios as $podcast) {
      // Ignora registros incompletos para evitar salvar lixo no banco.
      if (empty($podcast['name']) || empty($podcast['external_urls']['spotify'])) {
        array_push($array_erros, 'Episodio Spotify ignorado por falta de nome ou link.');
        continue;
      }

      // Aplica a tag no titulo e na descricao do episodio, quando houver tag ativa.
      if (!$this->validaPodcastSpotifyPorTag($tag, $podcast)) {
        array_push($array_erros, 'Ignorado por nao bater com a tag "' . $tag->title . '": ' . $podcast['name']);
        continue;
      }

      // Monta hash preservando o padrao antigo dos dois canais ja existentes.
      $hashPodcast = Str::slug($podcast['name'] . '-' . $this->sufixoSpotifyPodcast($hash));

      // Valida se o podcast ja existe antes de tentar salvar.
      $validator = Validator::make(
        ['hash' => $hashPodcast],
        [
          'hash' => 'required|unique:podcasts',
        ],
        $messages = [
          'unique' => 'Podcast ja existe.',
        ]
      );

      if ($validator->fails()) {
        array_push($array_existentes, $hashPodcast);
        continue;
      }

      // Limpa descricao para resumo curto e mantem a descricao completa quando a API enviar.
      $description = trim(strip_tags($podcast['description'] ?? $podcast['html_description'] ?? ''));
      // Cria o registro de podcast com as mesmas informacoes usadas pelos crawlers antigos.
      $insert = new Podcasts;
      $insert->title = $this->removeEmoji($podcast['name']);
      $insert->channels_id = $channel->id;
      $insert->slug = Str::slug($podcast['name']);
      $insert->hash = $hashPodcast;
      $insert->link = $podcast['external_urls']['spotify'];
      $insert->image = $this->imagemSpotifyPodcast($podcast);
      $insert->keywords = !empty($tag) ? $tag->title : null;
      $insert->status = "show";
      $insert->order = 0;
      $insert->description_short = Str::limit($description, 250, '');
      $insert->description = $podcast['html_description'] ?? $podcast['description'] ?? null;
      $insert->data = $podcast['release_date'] ?? date('Y-m-d');

      if ($insert->save()) {
        array_push($array_adicionados, $insert->id . ' ' . $hashPodcast);
      }
    }

    return [
      'code' => '000',
      'adicionados' => $array_adicionados,
      'existentes' => $array_existentes,
      'erros' => $array_erros,
      'tempos' => $this->finalizaTempos($tempos, $tempo_inicio),
      'date' => date("Y-m-d"),
      'hour' => date("H:i:s"),
    ];
  }

  // Busca episodios do show Spotify usando a biblioteca instalada no projeto.

  public function buscaEpisodiosSpotifyPorBiblioteca($showId, $limite, &$tempos, &$erros)
  {
    try {
      $resposta = $this->medeTempo($tempos, 'spotify_biblioteca_show_episodes', 'spotify:show:' . $showId, function () use ($showId, $limite) {
        return Spotify::showEpisodes($showId)
          ->limit(min(max((int) $limite, 1), 50))
          ->get();
      });

      return $this->normalizaEpisodiosSpotifyApi($resposta['items'] ?? []);
    } catch (\Exception $e) {
      $erros[] = 'Erro biblioteca Spotify ao buscar episodios do show ' . $showId . ': ' . $e->getMessage();
      return [];
    }
  }

  public function normalizaEpisodiosSpotifyApi($itens)
  {
    $episodios = [];

    foreach ($itens as $item) {
      if (empty($item['id']) || empty($item['name'])) {
        continue;
      }

      $link = $item['external_urls']['spotify'] ?? ('https://open.spotify.com/episode/' . $item['id']);

      $episodios[$link] = [
        'name' => $item['name'],
        'external_urls' => [
          'spotify' => $link,
        ],
        'images' => $item['images'] ?? [],
        'description' => $item['description'] ?? '',
        'html_description' => $item['html_description'] ?? $item['description'] ?? '',
        'release_date' => $item['release_date'] ?? date('Y-m-d'),
      ];
    }

    return array_values($episodios);
  }

  // Extrai o ID do show Spotify de uma URL completa ou retorna o proprio ID.

  public function extraiSpotifyShowId($urlOuId)
  {
    // Remove espacos e barras finais vindos do cadastro.
    $urlOuId = trim((string) $urlOuId);

    if ($urlOuId == "") {
      return "";
    }

    // Remove query string, como ?si=..., para ficar apenas com o caminho.
    $semQuery = explode('?', $urlOuId)[0];

    // Captura o ID em links do tipo https://open.spotify.com/show/{id}.
    if (preg_match('/open\.spotify\.com\/show\/([A-Za-z0-9]+)/', $semQuery, $matches)) {
      return $matches[1];
    }

    // Captura tambem URIs do tipo spotify:show:{id}.
    if (preg_match('/spotify:show:([A-Za-z0-9]+)/', $semQuery, $matches)) {
      return $matches[1];
    }

    // Quando o banco ja tiver apenas o ID, valida o formato basico e usa direto.
    if (preg_match('/^[A-Za-z0-9]+$/', $semQuery)) {
      return $semQuery;
    }

    return "";
  }

  // Resolve a tag do podcast por parametro ou pelo crawler ativo no horario atual.

  public function tagAtualParaPodcast($tagTitulo = "")
  {
    // Se uma tag foi passada manualmente, busca essa tag ativa pelo titulo.
    if (trim($tagTitulo) != "") {
      $tag = Tags::where('status', '=', 'active')->where('title', '=', $tagTitulo)->first();

      // Quando a tag nao existe no banco, usa o texto mesmo assim para permitir teste manual.
      return $tag ?: (object) ['title' => trim($tagTitulo)];
    }

    // Reaproveita a mesma janela de horario usada nos outros crawlers.
    $crawlerAtual = $this->crawlersNoHorarioAtual()->first();

    if (!$crawlerAtual || empty($crawlerAtual->tags_id)) {
      return null;
    }

    return Tags::where('id', '=', $crawlerAtual->tags_id)->where('status', '=', 'active')->first();
  }

  // Valida se o episodio combina com a tag ativa.

  public function validaPodcastSpotifyPorTag($tag, $podcast)
  {
    // Sem tag ativa, o podcast entra normalmente para manter compatibilidade com o crawler antigo.
    if (empty($tag)) {
      return true;
    }

    // Compara a tag contra titulo e descricao, pois podcasts costumam citar o assunto no resumo.
    $texto = ($podcast['name'] ?? '') . ' ' . strip_tags($podcast['description'] ?? $podcast['html_description'] ?? '');

    return $this->validaNoticiaTag($tag, $texto);
  }

  // Escolhe a melhor imagem enviada pelo Spotify.

  public function imagemSpotifyPodcast($podcast)
  {
    // A API normalmente envia imagens em ordem de tamanho; usa a primeira como maior disponivel.
    if (!empty($podcast['images'][0]['url'])) {
      return $podcast['images'][0]['url'];
    }

    // Mantem compatibilidade com o indice antigo caso a resposta venha diferente.
    if (!empty($podcast['images'][1]['url'])) {
      return $podcast['images'][1]['url'];
    }

    return "";
  }

  // Mantem os sufixos historicos dos podcasts ja cadastrados para evitar duplicidade.

  public function sufixoSpotifyPodcast($hash)
  {
    // Mapa dos canais antigos que tinham sufixo manual no hash salvo.
    $sufixos = [
      'jovemnerdspotify' => 'jovemnerd-spotify',
      'cinemacomrapaduraspotify' => 'cinema-com-rapadura-spotify',
    ];

    // Novos canais usam o proprio hash do canal como sufixo padrao.
    return $sufixos[$hash] ?? $hash;
  }

  // Executa requisicao HTTP com cURL e configuracoes padrao do crawler.

  public function getCurl($url)
  {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_MAXREDIRS, 5);
    curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36');
    curl_setopt($ch, CURLOPT_ENCODING, '');
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
      'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      'Accept-Language: pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7',
    ]);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 20);
    curl_setopt($ch, CURLOPT_TIMEOUT, 20);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

    $file_contents = curl_exec($ch);

    if ($file_contents === false) {
      $file_contents = '';
    }

    curl_close($ch);

    return $file_contents;
  }

  // Extrai noticias do TecMundo via API, __NEXT_DATA__ ou fallback HTML.

  public function extraiNoticiasTecMundo($html, &$erros = [], $urlBase = "", &$tempos = [])
  {
    $noticias = [];
    $linksEncontrados = [];
    $dados = [];

    $crawler = new HtmlCrawler($html);
    $dados = $this->extraiNoticiasTecMundoApi($urlBase, $erros, $tempos);

    if (count($dados) == 0) {
      $nextData = $crawler->filter('script#__NEXT_DATA__')->first();

      if ($nextData->count() > 0) {
        $json = json_decode(html_entity_decode($nextData->text('', false), ENT_QUOTES | ENT_HTML5, 'UTF-8'), true);
        $dados = $json['props']['pageProps']['latestArticles'] ?? [];
      }
    }

    if (count($dados) == 0) {
      $erros[] = 'TecMundo: resultados não encontrados na API nem no __NEXT_DATA__.';
      $dados = $this->extraiNoticiasTecMundoHtml($crawler);
    }

    foreach ($dados as $item) {
      $titulo = trim(html_entity_decode($item['title'] ?? '', ENT_QUOTES | ENT_HTML5, 'UTF-8'));
      $link = $this->normalizaUrlTecMundo($item['full_url'] ?? ($item['slug'] ?? ($item['url'] ?? '')), $urlBase);
      $imagem = $this->normalizaImagemOriginal($this->normalizaUrlTecMundo($this->imagemOriginalTecMundo($item), $urlBase));
      $data = $this->normalizaDataTecMundo($item['publishedAt'] ?? ($item['scheduled_datetime'] ?? ($item['data'] ?? '')));

      if ($titulo == "" || $link == "" || $imagem == "") {
        $erros[] = 'TecMundo: notícia ignorada com dados incompletos: ' . ($titulo ?: '[sem titulo]');
        continue;
      }

      if (isset($linksEncontrados[$link])) {
        continue;
      }

      $linksEncontrados[$link] = true;

      $noticias[] = [
        'url' => $link,
        'noticia' => $titulo,
        'img' => $imagem,
        'data' => $data,
      ];

      if (count($noticias) >= $this->qtd_noticias_por_canal()) {
        break;
      }
    }

    return $noticias;
  }

  // Consulta a API de busca do TecMundo e retorna os posts encontrados.

  public function extraiNoticiasTecMundoApi($urlBase, &$erros = [], &$tempos = [])
  {
    $partes = parse_url($urlBase);

    if (!isset($partes['scheme']) || !isset($partes['host'])) {
      return [];
    }

    $termo = "";

    if (isset($partes['query'])) {
      parse_str($partes['query'], $query);
      $termo = $query['q'] ?? ($query['search'] ?? ($query['s'] ?? ""));
    }

    if ($termo == "") {
      $path = trim($partes['path'] ?? "", '/');
      $segmentos = array_values(array_filter(explode('/', $path)));
      $indiceBusca = array_search('busca', $segmentos);

      if ($indiceBusca !== false && isset($segmentos[$indiceBusca + 1])) {
        $termo = rawurldecode($segmentos[$indiceBusca + 1]);
      }
    }

    if ($termo == "") {
      return [];
    }

    $apiUrl = $partes['scheme'] . '://' . $partes['host'] . '/api/posts?endpoint=posts-by-search&order=desc&page=1&pageSize=' . $this->qtd_noticias_por_canal() . '&search=' . rawurlencode($termo);
    $json = $this->getCurlCronometrado($apiUrl, $tempos, 'api_busca');

    if (empty($json)) {
      $erros[] = 'TecMundo: API de busca retornou vazia: ' . $apiUrl;
      return [];
    }

    $dados = json_decode($json, true);

    if (!is_array($dados)) {
      $erros[] = 'TecMundo: API de busca retornou JSON inválido: ' . $apiUrl;
      return [];
    }

    return $dados['data'] ?? [];
  }

  // Escolhe a melhor URL de imagem disponivel no item retornado pelo TecMundo.

  public function imagemOriginalTecMundo($item)
  {
    $possiveis = [
      $item['thumb']['url'] ?? "",
      $item['banner']['url'] ?? "",
      $item['img'] ?? "",
      $item['thumb']['formats']['large']['url'] ?? "",
      $item['banner']['formats']['large']['url'] ?? "",
    ];

    foreach ($possiveis as $imagem) {
      if (trim($imagem) != "") {
        return $imagem;
      }
    }

    return "";
  }

  // Monta uma URL de busca generica usando o termo/tag recebido.

  public function montaUrlBuscaCrawler($urlCrawler, $termo)
  {
    $urlCrawler = trim($urlCrawler);
    $termo = trim($termo);

    if ($urlCrawler == "" || $termo == "") {
      return $urlCrawler;
    }

    if (strpos($urlCrawler, '{tag}') !== false) {
      return str_replace('{tag}', rawurlencode($termo), $urlCrawler);
    }

    if (substr($urlCrawler, -1) == '=') {
      return $urlCrawler . urlencode($termo);
    }

    $separador = (strpos($urlCrawler, '?') !== false) ? '&q=' : '/';

    if ($separador == '&q=') {
      return $urlCrawler . $separador . urlencode($termo);
    }

    return rtrim($urlCrawler, '/') . '/' . rawurlencode($termo);
  }

  // Monta a URL de busca do Jovem Nerd respeitando os parametros do site.

  public function montaUrlBuscaJovemNerd($urlCrawler, $termo)
  {
    $urlCrawler = trim($urlCrawler);
    $termo = trim($termo);

    if ($urlCrawler == "" || $termo == "") {
      return $urlCrawler;
    }

    if (strpos($urlCrawler, '{tag}') !== false) {
      return str_replace('{tag}', rawurlencode($termo), $urlCrawler);
    }

    $partes = parse_url($urlCrawler);

    if (isset($partes['query'])) {
      parse_str($partes['query'], $query);

      if (array_key_exists('full_search', $query)) {
        $query['full_search'] = $termo;

        if (!isset($query['type'])) {
          $query['type'] = 'news';
        }

        $path = $partes['path'] ?? '';
        $porta = isset($partes['port']) ? ':' . $partes['port'] : '';

        return ($partes['scheme'] ?? 'https') . '://' . ($partes['host'] ?? 'jovemnerd.com.br') . $porta . $path . '?' . http_build_query($query);
      }
    }

    if (strpos($urlCrawler, '?s=') !== false || substr($urlCrawler, -1) == '=') {
      return $urlCrawler . urlencode($termo);
    }

    $separador = (strpos($urlCrawler, '?') !== false) ? '&' : '?';

    return rtrim($urlCrawler, '?&') . $separador . 'full_search=' . rawurlencode($termo) . '&type=news';
  }

  // Fallback de extracao HTML para o TecMundo quando API e JSON nao retornam dados.

  public function extraiNoticiasTecMundoHtml($crawler)
  {
    $noticias = [];
    $cards = $crawler->filter('a[href]');

    foreach ($cards as $linkNode) {
      $linkCrawler = new HtmlCrawler($linkNode);
      $href = $linkCrawler->attr('href') ?? '';
      $titulo = trim(preg_replace('/\s+/u', ' ', $linkCrawler->text('', true)));
      $img = $linkCrawler->filter('img')->first();

      if ($titulo == "" || $href == "" || $img->count() == 0) {
        continue;
      }

      $noticias[] = [
        'title' => $titulo,
        'slug' => $href,
        'thumb' => ['url' => $img->attr('src') ?? ($img->attr('data-src') ?? '')],
        'publishedAt' => '',
      ];
    }

    return $noticias;
  }

  // Transforma URLs relativas ou sem protocolo em URLs absolutas.

  public function normalizaUrlTecMundo($url, $urlBase = "")
  {
    $url = trim($url);

    if ($url == "") {
      return "";
    }

    if (strpos($url, '//') === 0) {
      return 'https:' . $url;
    }

    if (strpos($url, 'http://') === 0 || strpos($url, 'https://') === 0) {
      return $url;
    }

    $base = parse_url($urlBase);

    if (!isset($base['scheme']) || !isset($base['host'])) {
      return '/' . ltrim($url, '/');
    }

    return $base['scheme'] . '://' . $base['host'] . '/' . ltrim($url, '/');
  }

  // Converte datas do TecMundo para texto no formato usado pelo sistema.

  public function normalizaDataTecMundo($data)
  {
    if ($data == "") {
      return "";
    }

    $timestamp = strtotime($data);

    if (!$timestamp) {
      return $data;
    }

    $meses = [
      '01' => 'janeiro',
      '02' => 'fevereiro',
      '03' => 'março',
      '04' => 'abril',
      '05' => 'maio',
      '06' => 'junho',
      '07' => 'julho',
      '08' => 'agosto',
      '09' => 'setembro',
      '10' => 'outubro',
      '11' => 'novembro',
      '12' => 'dezembro',
    ];

    return date('d', $timestamp) . ' de ' . $meses[date('m', $timestamp)] . ' de ' . date('Y', $timestamp);
  }

  // Extrai titulo, link, imagem e data dos cards do Poltrona Nerd.

  public function extraiNoticiasPoltronaNerd($html, &$erros = [], $urlBase = "")
  {
    $noticias = [];
    $linksEncontrados = [];
    $crawler = new HtmlCrawler($html);
    $cards = $crawler->filter('.upk-checkerboard-item');

    if ($cards->count() == 0) {
      $erros[] = 'Poltrona Nerd: nenhum card .upk-checkerboard-item encontrado no HTML atual.';
    }

    foreach ($cards as $cardNode) {
      $card = new HtmlCrawler($cardNode);
      $tituloNode = $card->filter('.upk-title a')->first();
      $imagemNode = $card->filter('.upk-checkerboard-img img')->first();
      $dataNode = $card->filter('.upk-date')->first();

      if ($tituloNode->count() == 0 || $imagemNode->count() == 0) {
        continue;
      }

      $titulo = trim(html_entity_decode($tituloNode->attr('title') ?: $tituloNode->text('', true), ENT_QUOTES | ENT_HTML5, 'UTF-8'));
      $link = $this->normalizaUrlTecMundo($tituloNode->attr('href') ?? '', $urlBase);
      $imagem = $imagemNode->attr('data-orig-file') ?: ($imagemNode->attr('data-large-file') ?: ($imagemNode->attr('src') ?? ''));
      $imagem = $this->normalizaImagemOriginal($this->normalizaUrlTecMundo($imagem, $urlBase));
      $data = $this->normalizaDataPoltronaNerd($dataNode->count() > 0 ? $dataNode->text('', true) : '');

      if ($titulo == "" || $link == "" || $imagem == "") {
        $erros[] = 'Poltrona Nerd: notícia ignorada com dados incompletos: ' . ($titulo ?: '[sem titulo]');
        continue;
      }

      if (isset($linksEncontrados[$link])) {
        continue;
      }

      $linksEncontrados[$link] = true;

      $noticias[] = [
        'url' => $link,
        'noticia' => $titulo,
        'img' => $imagem,
        'data' => $data,
      ];

      if (count($noticias) >= $this->qtd_noticias_por_canal()) {
        break;
      }
    }

    return $noticias;
  }

  // Converte datas do Poltrona Nerd para o formato textual esperado.

  public function normalizaDataPoltronaNerd($data)
  {
    $data = trim($data);

    if ($data == "") {
      return "";
    }

    if (preg_match('/^(\d{2})\/(\d{2})\/(\d{4})$/', $data, $match)) {
      $meses = [
        '01' => 'janeiro',
        '02' => 'fevereiro',
        '03' => 'março',
        '04' => 'abril',
        '05' => 'maio',
        '06' => 'junho',
        '07' => 'julho',
        '08' => 'agosto',
        '09' => 'setembro',
        '10' => 'outubro',
        '11' => 'novembro',
        '12' => 'dezembro',
      ];

      return $match[1] . ' de ' . ($meses[$match[2]] ?? $match[2]) . ' de ' . $match[3];
    }

    return $data;
  }

  // Extrai noticias da pagina de busca do Jovem Nerd.

  public function extraiNoticiasJovemNerd($html, &$erros = [], &$tempos = [])
  {
    $noticias = [];
    $linksEncontrados = [];

    $crawler = new HtmlCrawler($html);
    $cards = $crawler->filter('[id^="news-"]');

    if ($cards->count() == 0) {
      $erros[] = 'Jovem Nerd: nenhum card id="news-..." encontrado no HTML atual.';
    }

    foreach ($cards as $cardNode) {
      $card = new HtmlCrawler($cardNode);
      $cardId = $card->attr('id') ?? '';
      $imagemCard = $card->filter('img[src^="https://uploads.jovemnerd.com.br"]')->first();

      if ($imagemCard->count() == 0) {
        $erros[] = 'Jovem Nerd: card ' . $cardId . ' ignorado sem imagem de upload.';
        continue;
      }

      $titulo = trim(html_entity_decode($imagemCard->attr('alt') ?? '', ENT_QUOTES | ENT_HTML5, 'UTF-8'));

      if ($titulo == "") {
        $erros[] = 'Jovem Nerd: card ' . $cardId . ' ignorado sem título no alt da imagem.';
        continue;
      }

      $link = $this->linkPrincipalJovemNerd($card, $titulo);

      if ($link == "") {
        $erros[] = 'Jovem Nerd: card ' . $cardId . ' ignorado sem link principal para o título "' . $titulo . '".';
        continue;
      }

      if (isset($linksEncontrados[$link])) {
        continue;
      }

      $linksEncontrados[$link] = true;

      $data = "";
      $textoCard = trim(preg_replace('/\s+/u', ' ', $card->text('', true)));

      if (preg_match('/\b(\d{2})\.([a-z]{3})\.(\d{2})\b/iu', $textoCard, $matchData)) {
        $data = $this->normalizaDataCurtaJovemNerd($matchData[0]);
      }

      $imagemNoticia = $this->imagemPrincipalJovemNerd($link, $erros, $tempos);

      if ($imagemNoticia == "") {
        $imagemNoticia = $imagemCard->attr('src');
        $erros[] = 'Jovem Nerd: usando imagem do card como fallback para "' . $titulo . '".';
      }

      $noticias[] = [
        'url' => $link,
        'noticia' => $titulo,
        'img' => $imagemNoticia,
        'data' => $data,
      ];

      if (count($noticias) >= $this->qtd_noticias_por_canal()) {
        break;
      }
    }

    return $noticias;
  }

  // Busca a noticia do Jovem Nerd e extrai a imagem principal em maior qualidade.

  public function imagemPrincipalJovemNerd($urlNoticia, &$erros = [], &$tempos = [])
  {
    if ($urlNoticia == "") {
      return "";
    }

    $this->pauseTime();

    $htmlNoticia = $this->getCurlCronometrado($urlNoticia, $tempos, 'link_imagem_principal');

    if (empty($htmlNoticia)) {
      $erros[] = 'Jovem Nerd: HTML vazio ao buscar imagem da notícia ' . $urlNoticia;
      return "";
    }

    $crawler = new HtmlCrawler($htmlNoticia);
    $seletoresImagem = [
      'img.aspect-video.w-full.object-cover[src^="https://uploads.jovemnerd.com.br"]' => 'src',
      'img.aspect-video[src^="https://uploads.jovemnerd.com.br"]' => 'src',
      'meta[property="og:image"]' => 'content',
      'meta[name="twitter:image"]' => 'content',
      'link[rel="preload"][as="image"]' => 'href',
      'img[src^="https://uploads.jovemnerd.com.br"]' => 'src',
    ];

    foreach ($seletoresImagem as $seletor => $atributo) {
      $imagemNode = $crawler->filter($seletor)->first();

      if ($imagemNode->count() == 0) {
        continue;
      }

      $imagem = $this->normalizaImagemJovemNerd(trim($imagemNode->attr($atributo) ?? ''));

      if ($imagem != "") {
        return $imagem;
      }
    }

    $erros[] = 'Jovem Nerd: nenhuma imagem principal encontrada na notícia ' . $urlNoticia;

    return "";
  }

  // Normaliza URLs de imagem do Jovem Nerd antes do download.

  public function normalizaImagemJovemNerd($urlImagem)
  {
    if ($urlImagem == "") {
      return "";
    }

    if (strpos($urlImagem, '//') === 0) {
      $urlImagem = 'https:' . $urlImagem;
    }

    return $this->normalizaImagemOriginal($urlImagem);
  }

  // Remove parametros de corte/filtro para tentar baixar a imagem original.

  public function normalizaImagemOriginal($urlImagem)
  {
    if ($urlImagem == "") {
      return "";
    }

    $query = parse_url($urlImagem, PHP_URL_QUERY);

    if ($query && (strpos($query, 'ims=') !== false || strpos($query, 'filters') !== false)) {
      return preg_replace('/\?.*$/', '', $urlImagem);
    }

    return $urlImagem;
  }

  // Localiza o link principal da noticia dentro de um card do Jovem Nerd.

  public function linkPrincipalJovemNerd($card, $titulo)
  {
    $links = $card->filter('a[href^="/noticias/"]');

    foreach ($links as $link) {
      $link = new HtmlCrawler($link);
      $href = $link->attr('href') ?? '';
      $texto = trim(preg_replace('/\s+/u', ' ', $link->text('', true)));

      if ($texto == $titulo && substr_count($href, '/') >= 3) {
        return 'https://jovemnerd.com.br' . $href;
      }
    }

    foreach ($links as $link) {
      $link = new HtmlCrawler($link);
      $href = $link->attr('href') ?? '';

      if (substr_count($href, '/') >= 3) {
        return 'https://jovemnerd.com.br' . $href;
      }
    }

    return "";
  }

  // Converte datas curtas do Jovem Nerd para formato textual completo.

  public function normalizaDataCurtaJovemNerd($data)
  {
    $meses = [
      'jan' => 'janeiro',
      'fev' => 'fevereiro',
      'mar' => 'março',
      'abr' => 'abril',
      'mai' => 'maio',
      'jun' => 'junho',
      'jul' => 'julho',
      'ago' => 'agosto',
      'set' => 'setembro',
      'out' => 'outubro',
      'nov' => 'novembro',
      'dez' => 'dezembro',
    ];

    $partes = explode('.', strtolower($data));

    if (count($partes) != 3 || !isset($meses[$partes[1]])) {
      return "";
    }

    return $partes[0] . ' de ' . $meses[$partes[1]] . ' de 20' . $partes[2];
  }

  // Busca HTML usando file_get_contents com User-Agent customizado.

  public function getHtml($url)
  {

    $context = stream_context_create(
      array(
        "http" => array(
          "header" => "User-Agent: " . $this->getRandAgent()
        )
      )
    );

    return file_get_contents($url, false, $context);
  }

  // Retorna um User-Agent aleatorio para requisicoes HTTP.

  public function getRandAgent()
  {

    $agents = [
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',
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
      'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)'
    ];

    return $agents[rand(0, count($agents) - 1)];
  }

  // Remove emojis e caracteres problematicos de textos usados em titulos e slugs.

  public function removeEmoji($text)
  {
    $string = $text;
    $string = str_replace("?", "{%}", $string);
    $string = mb_convert_encoding($string, "ISO-8859-1", "UTF-8");
    $string = mb_convert_encoding($string, "UTF-8", "ISO-8859-1");
    $string = str_replace(array("?", "? ", " ?"), array(""), $string);
    $string = str_replace("{%}", "?", $string);

    $tweet = preg_replace('/#/', '', $string);

    return trim($tweet);
  }

  // Baixa conteudo bruto de uma URL usando cURL.

  public function file_get_contents_curl($url)
  {

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_MAXREDIRS, 5);
    curl_setopt($ch, CURLOPT_USERAGENT, $this->getRandAgent());
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 20);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($ch, CURLOPT_URL, $url);
    $data = curl_exec($ch);
    curl_close($ch);

    return $data;
  }

  // Baixa uma imagem e redimensiona para largura padrao antiga.

  public function downloadFile($imgName, $url, $path)
  {

    // $data = $this->file_get_contents_curl($url);
    // $status = file_put_contents($path . $imgName, $data);
    // return $status;

    if (! is_dir($path)) {
      mkdir($path, 0775, true);
    }

    $data = $this->file_get_contents_curl($url);
    $image = ImageResize::createFromString($data);
    $image->resizeToWidth(268);
    $return = $image->save($path . $imgName);
    return $return;
  }

  // Baixa e salva uma imagem sem redimensionar.

  public function downloadFileOriginal($imgName, $url, $path)
  {
    if (! is_dir($path)) {
      mkdir($path, 0775, true);
    }

    $data = $this->file_get_contents_curl($url);

    if ($data === false || $data == "") {
      return false;
    }

    $filePath = $path . $imgName;
    $saved = file_put_contents($filePath, $data);

    if ($saved === false) {
      return false;
    }

    // Os crawlers gravam o caminho com extensao JPG no banco; mantemos esse
    // contrato e otimizamos dimensoes, qualidade e peso logo apos o download.
    try {
      $this->imageOptimizer->optimize($filePath, 'jpg');
    } catch (\Throwable $exception) {
      @unlink($filePath);
      throw $exception;
    }

    return filesize($filePath);
  }

  // Converte diferentes formatos de data antigos para Y-m-d.

  public function formata_data($type, $data)
  {

    // 1 - 13 de julho de 2020 //JOVEM NERD SITE
    // 2 - 15.04.202111H51 //OMELETE  SITE
    // 3 - 2018-01-15T22:00:57Z //YOUTUBE
    // 4 - 13 de out. de 2017  //YOUTUBE Site
    $mes = array(
      'referencia' => array('/ de janeiro de /', '/ de fevereiro de /', '/ de março de /', '/ de abril de /', '/ de maio de /', '/ de junho de /', '/ de julho de /', '/ de agosto de /', '/ de setembro de /', '/ de outubro de /', '/ de novembro de /', '/ de dezembro de /'),
      'correcao' => array('/01/', '/02/', '/03/', '/04/', '/05/', '/06/', '/07/', '/08/', '/09/', '/10/', '/11/', '/12/')
    );

    $mes2 = array(
      'referencia' => array('/ de jan. de /', '/ de fev. de /', '/ de mar. de /', '/ de abr. de /', '/ de mai. de /', '/ de jun. de /', '/ de jul. de /', '/ de ago. de /', '/ de set. de /', '/ de out. de /', '/ de nov. de /', '/ de dez. de /'),
      'correcao' => array('/01/', '/02/', '/03/', '/04/', '/05/', '/06/', '/07/', '/08/', '/09/', '/10/', '/11/', '/12/')
    );

    if ($data != "" && $type == 1) {
      $data_final = preg_replace($mes['referencia'], $mes['correcao'], $data);
      $array = explode("/", $data_final);
      $data_final = $array[2] . '-' . $array[1] . '-' . $array[0];
      return $data_final;
    } else if ($data != "" && $type == 2) {
      $array = explode(".", $data);
      $data_final = substr($array[2], 0, 4) . '-' . $array[1] . '-' . $array[0];
      return $data_final;
    } else if ($data != "" && $type == 3) {
      $data_final = substr($data, 0, -10);
      return $data_final;
    } else if ($data != "" && $type == 4) {

      try {
        if (strpos($data, 'hoje') !== false) {
          return date('Y-m-d');
        }

        $data = str_replace('Estreou em ', '', $data);
        $data = str_replace('Transmitido ao vivo em ', '', $data);

        $data_final = preg_replace($mes['referencia'], $mes['correcao'], $data);
        $data_final = preg_replace($mes2['referencia'], $mes2['correcao'], $data_final);
        $array = explode("/", $data_final);

        $data_final = $array[2] . '-' . $array[1] . '-' . $array[0];
        return $data_final;
      } catch (Exception $e) {
        return date('Y-m-d');
      }
    }
  }

  // Compara tag e titulo para decidir se a noticia pertence ao termo buscado.

  function validaNoticia($search, $title, $porcentagemMatch = 60)
  {
    $search = strtolower($this->removerAcentos($this->removeArtigosPreposicoes($search)));
    $title = strtolower($this->removerAcentos($this->removeArtigosPreposicoes($title)));
    $palavras = array_values(array_filter(preg_split('/[^a-z0-9]+/i', $search)));
    $palavrasTitle = array_values(array_filter(preg_split('/[^a-z0-9]+/i', $title)));

    if (empty($palavras) || empty($palavrasTitle)) {
      return false;
    }

    $aliases = ['dr' => 'doutor', 'dra' => 'doutora'];
    $palavras = array_map(fn ($palavra) => $aliases[$palavra] ?? $palavra, $palavras);
    $palavrasTitle = array_map(fn ($palavra) => $aliases[$palavra] ?? $palavra, $palavrasTitle);
    $similaridadeTotal = 0.0;
    $indicesUsados = [];

    foreach ($palavras as $palavraSearch) {
      $melhorSimilaridade = 0.0;
      $melhorIndice = null;

      foreach ($palavrasTitle as $indice => $palavraTitle) {
        if (isset($indicesUsados[$indice])) {
          continue;
        }

        if ($palavraSearch === $palavraTitle) {
          $similaridade = 100.0;
        } elseif (strlen($palavraSearch) >= 5
          && strlen($palavraTitle) >= 5
          && $palavraSearch[0] === $palavraTitle[0]
          && substr($palavraSearch, -1) === substr($palavraTitle, -1)) {
          similar_text($palavraSearch, $palavraTitle, $similaridade);
        } else {
          $similaridade = 0.0;
        }

        if ($similaridade > $melhorSimilaridade) {
          $melhorSimilaridade = $similaridade;
          $melhorIndice = $indice;
        }
      }

      if ($melhorIndice !== null) {
        $indicesUsados[$melhorIndice] = true;
      }

      $similaridadeTotal += $melhorSimilaridade;
    }

    $percentualFinal = $similaridadeTotal / count($palavras);

    return $percentualFinal >= max(1, min(100, (int) $porcentagemMatch));
  }

  // Testa o titulo principal e os aliases cadastrados antes do IMDb ID nas keywords.

  function validaNoticiaTag($tag, $title)
  {
    if (empty($tag) || empty($tag->title)) {
      return false;
    }

    $aliases = [$tag->title];
    foreach (array_map('trim', explode(',', (string) ($tag->keywords ?? ''))) as $keyword) {
      if ($keyword === '' || preg_match('/^tt\d+$/i', $keyword)) {
        break;
      }
      $aliases[] = $keyword;
    }

    foreach (array_unique($aliases) as $alias) {
      if ($this->validaNoticia($alias, $title, $this->percentualMatchTag($tag))) {
        return true;
      }
    }

    return false;
  }

  // Retorna o percentual configurado na tag, usando 60% para cadastros antigos.

  function percentualMatchTag($tag)
  {
    return max(1, min(100, (int) ($tag->match_percentage ?? 60)));
  }

  // Remove artigos e preposicoes para melhorar a comparacao textual.

  function removeArtigosPreposicoes($frase)
  {

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

    foreach ($artigos as $artigo) {
      //no meio da frase
      $frase = preg_replace("/\s$artigo\s/i", ' ', $frase);
      //no inicio da linha
      $frase = preg_replace("/^$artigo\s/i", ' ', $frase);
      //no final da linha
      $frase = preg_replace("/\s$artigo.$/i", '.', $frase);
    }

    return $frase;
  }

  // Remove acentos de um texto para comparacoes mais tolerantes.

  function removerAcentos($texto)
  {
    return preg_replace(array("/(á|à|ã|â|ä)/", "/(Á|À|Ã|Â|Ä)/", "/(é|è|ê|ë)/", "/(É|È|Ê|Ë)/", "/(í|ì|î|ï)/", "/(Í|Ì|Î|Ï)/", "/(ó|ò|õ|ô|ö)/", "/(Ó|Ò|Õ|Ô|Ö)/", "/(ú|ù|û|ü)/", "/(Ú|Ù|Û|Ü)/", "/(ñ)/", "/(Ñ)/", "/(ç)/", "/(Ç)/"), explode(" ", "a A e E i I o O u U n N c C"), $texto);
  }

  // Detecta o IP do usuario a partir dos headers da requisicao.

  function getUserIP()
  {
    $ipaddress = '';
    if (isset($_SERVER['HTTP_CLIENT_IP']))
      $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
    else if (isset($_SERVER['HTTP_X_FORWARDED_FOR']))
      $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
    else if (isset($_SERVER['HTTP_X_FORWARDED']))
      $ipaddress = $_SERVER['HTTP_X_FORWARDED'];
    else if (isset($_SERVER['HTTP_X_CLUSTER_CLIENT_IP']))
      $ipaddress = $_SERVER['HTTP_X_CLUSTER_CLIENT_IP'];
    else if (isset($_SERVER['HTTP_FORWARDED_FOR']))
      $ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
    else if (isset($_SERVER['HTTP_FORWARDED']))
      $ipaddress = $_SERVER['HTTP_FORWARDED'];
    else if (isset($_SERVER['REMOTE_ADDR']))
      $ipaddress = $_SERVER['REMOTE_ADDR'];
    else
      $ipaddress = 'UNKNOWN';
    return $ipaddress;
  }

  // Aplica uma pausa aleatoria entre requisicoes externas.

  function pauseTime()
  {
    // Sorteia uma das pausas abaixo para reduzir chamadas em sequencia.
    $sorteio = rand(1, 5);

    if ($sorteio == 1) {
      // Pausa de 3.056872 segundos, ou 3056.872 milissegundos.
      return usleep(3056872);
    } else if ($sorteio == 2) {
      // Pausa de 1.925713 segundos, ou 1925.713 milissegundos.
      return usleep(1925713);
    } else if ($sorteio == 3) {
      // Pausa de 2.004567 segundos, ou 2004.567 milissegundos.
      return usleep(2004567);
    } else if ($sorteio == 4) {
      // Pausa de 3.354781 segundos, ou 3354.781 milissegundos.
      return usleep(3354781);
    } else if ($sorteio == 5) {
      // Pausa de 1 segundo, ou 1000 milissegundos.
      return usleep(1000000);
    }
  }

  // Verifica se um canal esta ativo na configuracao do crawler.

  function crawler_canais_ativos($hash_channel)
  {
    $crawler_configs = CrawlerConfigs::where('id', '=', 1)->first();
    $array_canais_ativos = json_decode($crawler_configs->array_canais_ativos, true);

    if (in_array($hash_channel, $array_canais_ativos)) {
      return true;
    }
    return false;
  }

  // Busca crawlers ativos dentro da janela de horario atual.

  function crawlersNoHorarioAtual($hora = null)
  {
    $hora = $hora ?: date('H:i:s');
    $hora_30 = date('H:i:s', strtotime('-30 minute', strtotime($hora)));

    return DB::table('crawler')
      ->where('status', '=', 'active')
      ->where('tags_id', '!=', 0)
      ->where(function ($query) use ($hora, $hora_30) {
        if ($hora_30 <= $hora) {
          $query->whereBetween('time_initial', [$hora_30, $hora]);
        } else {
          $query->where('time_initial', '>=', $hora_30)
            ->orWhere('time_initial', '<=', $hora);
        }
      })
      ->orderBy('time_initial', 'desc')
      ->get();
  }

  // Retorna a quantidade de noticias configurada por canal.

  function qtd_noticias_por_canal()
  {
    $crawler_configs = CrawlerConfigs::where('id', '=', 1)->first();
    if (!empty($crawler_configs)) {
      return $crawler_configs->qtd_noticias_por_canal;
    } else {
      return 20;
    }
  }

  // Redimensiona imagens de noticias ja salvas no storage.

  function resize()
  {
    $news = News::where('image', '!=', '')->get();
    foreach ($news as $key => $item) {
      echo $key . ' ' . $item->image;
      if (!file_exists(public_path($item->image))) continue;

      $image = new ImageResize(public_path($item->image));
      // $image->scale(50);
      $image->resizeToWidth(268);
      $image->save(public_path($item->image));
    }
    return false;
  }
}
