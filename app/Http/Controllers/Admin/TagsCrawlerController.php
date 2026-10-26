<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Http\Controllers\Controller;

//Auth facade
use Auth;
use Validator;
use File;
use Session;

use App\Tags;
use App\Services\ImdbTagCrawler;
use App\Services\TagImageOptimizer;


class TagsCrawlerController extends Controller
{

    public function __construct()
	{
        $this->page_dados = array(
            'title' => 'Tags',
            'description' => 'Descrição',
            'route_controler' => 'tags',
            'route_view' => 'tags',
            'prefix_auth' => 'admin',
            'diretorio_aquivo' => 'arquivos',
            'diretorio_image' => 'fotos'
        );
	}

    public function index(Request $request)
    {
        $search = "";
        $qtd = 10;
        
        $search = $request->input('search');
        $qtd = $request->input('qtd');
        
        $string =  '%' . $search . '%';
        $lista = Tags::where( 'title',  'LIKE',  $string )
                        ->orderBy('title', 'Asc')
                        ->paginate($qtd);
        

        return view($this->page_dados['prefix_auth'] .'.pages.'. $this->page_dados['route_view'] .'.index' , compact('lista','search','qtd'))
                ->with('page_dados', $this->page_dados);
    }

    public function create()
    {
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.create')
                ->with('page_dados', $this->page_dados);
    }

    public function crawlerImdb(Request $request, ImdbTagCrawler $crawler)
    {
        $inicio = microtime(true);
        $inicioFormatado = date('Y-m-d H:i:s');
        $validator = Validator::make($request->all(), [
            'limit' => 'nullable|integer|min:1|max:100',
        ]);

        if ($validator->fails()) {
            return $this->retornoCrawlerImdb([
                'code' => '005',
                'adicionados' => [],
                'existentes' => [],
                'erros' => $validator->errors()->all(),
            ], $inicio, $inicioFormatado, (int) $request->input('limit', 30), 422);
        }

        try {
            $result = $crawler->import((int) $request->input('limit', 30));
            $result['code'] = '005';
        } catch (\Throwable $exception) {
            $result = [
                'code' => '005',
                'adicionados' => [],
                'existentes' => [],
                'erros' => ['Falha ao consultar o IMDb: ' . $exception->getMessage()],
            ];
        }

        return $this->retornoCrawlerImdb(
            $result,
            $inicio,
            $inicioFormatado,
            (int) $request->input('limit', 30)
        );
    }

    public function optimizeImages(Request $request, TagImageOptimizer $optimizer)
    {
        $inicio = microtime(true);
        $inicioFormatado = date('Y-m-d H:i:s');
        $validator = Validator::make($request->all(), [
            'limit' => 'nullable|integer|min:1|max:1000',
            'after_id' => 'nullable|integer|min:0',
        ]);

        if ($validator->fails()) {
            return $this->retornoOtimizacaoImagens([], $validator->errors()->all(), $inicio, $inicioFormatado, 422);
        }

        set_time_limit(60);
        $limit = (int) $request->input('limit', 1000);
        $afterId = (int) $request->input('after_id', 0);
        $batchSize = min(3, $limit);
        $items = [];
        $errors = [];
        $processedIds = [];

        Tags::whereNotNull('image')
            ->where('image', '!=', '')
            ->where('id', '>', $afterId)
            ->orderBy('id')
            ->limit($batchSize)
            ->get()
            ->each(function (Tags $tag) use ($optimizer, &$items, &$errors, &$processedIds) {
                try {
                    $metadata = $optimizer->optimize(public_path($tag->image));
                    $tag->image = str_replace(public_path(), '', $metadata['path']);
                    $tag->image_width = $metadata['width'];
                    $tag->image_height = $metadata['height'];
                    $tag->image_size_bytes = $metadata['after_bytes'];
                    $tag->image_optimized_at = now();
                    $tag->save();

                    $items[] = [
                        'tag_id' => $tag->id,
                        'tag' => $tag->title,
                        'arquivo' => $tag->image,
                        'dimensoes' => $metadata['width'] . 'x' . $metadata['height'],
                        'antes_kb' => round($metadata['before_bytes'] / 1024, 1),
                        'depois_kb' => round($metadata['after_bytes'] / 1024, 1),
                        'economia_kb' => round($metadata['saved_bytes'] / 1024, 1),
                        'alterada' => $metadata['changed'],
                    ];
                } catch (\Throwable $exception) {
                    $errors[] = $tag->title . ': ' . $exception->getMessage();
                } finally {
                    $processedIds[] = $tag->id;
                }
            });

        $lastId = $processedIds ? max($processedIds) : null;

        $nextUrl = null;
        if ($lastId && Tags::whereNotNull('image')->where('image', '!=', '')->where('id', '>', $lastId)->exists()) {
            $nextUrl = route('tags.optimize-images', [
                'after_id' => $lastId,
                'limit' => $limit,
            ]);
        }

        return $this->retornoOtimizacaoImagens(
            $items,
            $errors,
            $inicio,
            $inicioFormatado,
            200,
            $afterId,
            $nextUrl
        );
    }

    private function retornoOtimizacaoImagens(
        array $items,
        array $errors,
        float $inicio,
        string $inicioFormatado,
        int $status = 200,
        int $afterId = 0,
        ?string $nextUrl = null
    ) {
        $fim = microtime(true);
        $retorno = [
            'Otimizacao_Imagens_Tags' => [
                'code' => '006',
                'processadas' => $items,
                'total_processadas' => count($items),
                'total_alteradas' => count(array_filter($items, fn ($item) => $item['alterada'])),
                'economia_total_kb' => round(array_sum(array_column($items, 'economia_kb')), 1),
                'erros' => $errors,
                'lote_apos_id' => $afterId,
                'proximo_lote' => $nextUrl,
                'continuacao_automatica' => $nextUrl !== null,
                'tempos' => [
                    'inicio' => $inicioFormatado,
                    'fim' => date('Y-m-d H:i:s'),
                    'total_segundos' => round($fim - $inicio, 4),
                    'total_milissegundos' => (int) round(($fim - $inicio) * 1000),
                ],
                'date' => date('Y-m-d'),
                'hour' => date('H:i:s'),
            ],
        ];

        $refresh = $nextUrl
            ? '<meta http-equiv="refresh" content="1;url=' . htmlspecialchars($nextUrl, ENT_QUOTES, 'UTF-8') . '">'
            : '';
        $message = $nextUrl
            ? '<p>Este lote terminou. O próximo será iniciado automaticamente...</p>'
            : '<p>Otimização concluída.</p>';

        return response(
            '<!doctype html><html><head><meta charset="UTF-8"><title>Otimização de imagens</title>'
            . $refresh
            . '</head><body>'
            . $message
            . '<pre>' . htmlspecialchars(print_r($retorno, true), ENT_QUOTES, 'UTF-8') . '</pre>'
            . '</body></html>',
            $status,
            ['Content-Type' => 'text/html; charset=UTF-8']
        );
    }

    private function retornoCrawlerImdb(array $result, float $inicio, string $inicioFormatado, int $limit, int $status = 200)
    {
        $fim = microtime(true);
        $adicionados = $result['adicionados'] ?? [];
        $existentes = $result['existentes'] ?? [];
        $agendamentos = $result['agendamentos'] ?? [];
        $erros = $result['erros'] ?? [];
        $total = $fim - $inicio;

        $retorno = [
            'IMDb_Tags' => [
                'code' => $result['code'] ?? '005',
                'limite_solicitado' => $limit,
                'adicionados' => $adicionados,
                'existentes' => $existentes,
                'agendamentos_criados' => $agendamentos,
                'erros' => $erros,
                'tempos' => [
                    'inicio' => $inicioFormatado,
                    'fim' => date('Y-m-d H:i:s'),
                    'total_segundos' => round($total, 4),
                    'total_milissegundos' => (int) round($total * 1000),
                    'quantidade' => count($adicionados) + count($existentes) + count($erros),
                ],
                'date' => date('Y-m-d'),
                'hour' => date('H:i:s'),
            ],
        ];

        return response(
            '<pre>' . htmlspecialchars(print_r($retorno, true), ENT_QUOTES, 'UTF-8') . '</pre>',
            $status,
            ['Content-Type' => 'text/html; charset=UTF-8']
        );
    }

    public function store(Request $request)
    {
    
        $valida_dados =  $request->all();
        $valida_dados['slug'] = Str::slug($request->input('title'));
       
		//Validando os campos
        $validator = Validator::make($valida_dados, [
                'title' => 'required|max:255',
                'slug' => 'required|unique:tags',
                'imdb_url' => 'nullable|url|max:255',
                'imdb_rating' => 'nullable|numeric|min:0|max:10',
                'imdb_vote_count' => 'nullable|integer|min:0',
                'imdb_popularity' => 'nullable|integer|min:1',
                'match_percentage' => 'required|integer|min:1|max:100'
                // 'image' => 'file|required|max:500',
                // 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
            ],
            $messages = [
                // 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
                'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
                'title.unique'    => 'Esta tag já existe.',
                'title.required' => 'O campo nome deve ser preenchido.',
                'slug.unique'    => 'O titulo já existe.',
                'match_percentage.required' => 'O percentual de match deve ser preenchido.',
                'match_percentage.integer' => 'O percentual de match deve ser um número inteiro.',
                'match_percentage.min' => 'O percentual de match deve ser no mínimo 1%.',
                'match_percentage.max' => 'O percentual de match deve ser no máximo 100%.',
                // 'image.required' => 'Faça upload de uma imagem.',
            ]
        );

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/create')
                    ->withErrors($validator)
                    ->withInput();
        }else{

            // Cadastrando um novo Registro
			$insert = new Tags;
            $insert->title = $request->input('title');
            $insert->slug = Str::slug($request->input('title'));
            $insert->description = $request->input('description');
            $insert->description_short = $request->input('description_short');
            $insert->keywords = $request->input('keywords');
            $insert->imdb_url = $request->input('imdb_url');
            $insert->imdb_rating = $request->input('imdb_rating');
            $insert->imdb_vote_count = $request->input('imdb_vote_count');
            $insert->imdb_popularity = $request->input('imdb_popularity');
            $insert->match_percentage = $request->input('match_percentage', 60);
            $insert->order = $request->input('order');
            $insert->status = $request->input('status');

            //Image
            if ($request->file('image')) {
                //deleta o arquivo anterior
				//delete image existente
				if($insert->image){
		            $delete_arquivo1 = public_path().$insert->image;
		            File::delete($delete_arquivo1);
		        }
                $file = $request->file('image');
                $destinationPath = public_path().'/uploads/'. $this->page_dados['diretorio_image'] .'/';
                $filename =  date('Ymdhis'). '_' . Str::studly( $file->getClientOriginalName());
                $upload = $request->file('image')->move($destinationPath, $filename);
                $insert->image = '/uploads/'. $this->page_dados['diretorio_image'] .'/' . $filename;
            }else{
                $insert->image = "";
            }
            $condition = $insert->save();

            if($condition){
                $request->session()->flash('message','Cadastrado com sucesso !');
            }
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler']);
        }
    }

    public function show($id)
    {

        $item = Tags::findOrFail($id);
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.show', compact('item'))
                ->with('page_dados', $this->page_dados);
    }

    public function edit($id)
    {
        $item = Tags::find($id);
        // dd($item);
        return view($this->page_dados['prefix_auth'].'.pages.'. $this->page_dados['route_view'] .'.edit', compact('item'))
                ->with('page_dados', $this->page_dados);
    }

    public function update(Request $request, $id)
    {
        //Validando os campos
		$validator = Validator::make($request->all(), [
                'title' => 'required|max:255',
                'imdb_url' => 'nullable|url|max:255',
                'imdb_rating' => 'nullable|numeric|min:0|max:10',
                'imdb_vote_count' => 'nullable|integer|min:0',
                'imdb_popularity' => 'nullable|integer|min:1',
                'match_percentage' => 'required|integer|min:1|max:100',
                // 'image' => 'file|required|max:500',
                // 'image' => 'file|required|max:500|dimensions:max_width=1366,max_height=768',
            ],
            $messages = [
                // 'dimensions' => 'A imagem não esta nas dimenssões especificadas abaixo do campo.',
                'max'    => 'A imagem :attribute não tem o tamanho correto - :max kb.', // Peso da imagem em KB
                'title.required' => 'O campo nome deve ser preenchido.',
                'match_percentage.required' => 'O percentual de match deve ser preenchido.',
                'match_percentage.integer' => 'O percentual de match deve ser um número inteiro.',
                'match_percentage.min' => 'O percentual de match deve ser no mínimo 1%.',
                'match_percentage.max' => 'O percentual de match deve ser no máximo 100%.',
                // 'image.required' => 'Faça upload de uma imagem.',
            ]
        );

        if ($validator->fails()) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler'] .'/'.$id.'/edit')
                    ->withErrors($validator)
                    ->withInput();
        }else{

            // Cadastrando um novo Registro
			$insert = Tags::find($id);
            $insert->title = $request->input('title');
            $insert->slug = $request->input('slug');
            $insert->description = $request->input('description');
            $insert->description_short = $request->input('description_short');
            $insert->keywords = $request->input('keywords');
            $insert->imdb_url = $request->input('imdb_url');
            $insert->imdb_rating = $request->input('imdb_rating');
            $insert->imdb_vote_count = $request->input('imdb_vote_count');
            $insert->imdb_popularity = $request->input('imdb_popularity');
            $insert->match_percentage = $request->input('match_percentage', 60);
            $insert->order = $request->input('order');
            $insert->status = $request->input('status');
            
            //Image
            if ($request->file('image')) {
                //deleta o arquivo anterior
				//delete image existente
				if($insert->image){
		            $delete_arquivo1 = public_path().$insert->image;
		            File::delete($delete_arquivo1);
		        }
                $file = $request->file('image');
                $destinationPath = public_path().'/uploads/'. $this->page_dados['diretorio_image'] .'/';
                $filename =  date('Ymdhis'). '_' . Str::studly($file->getClientOriginalName());
                $upload = $request->file('image')->move($destinationPath, $filename);
                $insert->image = '/uploads/'. $this->page_dados['diretorio_image'] .'/' . $filename;
            }
            $condition = $insert->save();

            if($condition){
                $request->session()->flash('message','Editado com sucesso !');
            }
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler']);
        }
    }

    public function destroy($id)
    {
        $item = Tags::find($id);

        if (!$item) {
            return redirect('/'. $this->page_dados['prefix_auth'].'/'. $this->page_dados['route_controler']);
        }

        if($item->image){
            $delete_arquivo1 = public_path().$item->image;
            File::delete($delete_arquivo1);
        }

        $condition = $item->delete();

        if($condition){
            return 'deletado';
        }elseif($condition == false){
            return 'erro';
        }
    }

}
