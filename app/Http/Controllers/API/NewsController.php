<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;

use App\News;
use DB;

use Illuminate\Http\Request;

class NewsController extends Controller
{

    public function listaNews(Request $request)
    {
     
        if($request->id){
            $lista =DB::table('news')
                        ->where('channels_id', '=', $request->id) 
                        ->join('channels', 'news.channels_id', '=', 'channels.id')
                        ->select('news.*', 'channels.name as channel', 'channels.image as channel_logo', 'channels.type as channel_type')
                        ->orderBy('data', 'desc')
                        ->paginate(15);
        }else{
            $lista =DB::table('news')
                        ->join('channels', 'news.channels_id', '=', 'channels.id')
                        ->select('news.*', 'channels.name as channel', 'channels.image as channel_logo', 'channels.type as channel_type')
                        ->orderBy('data', 'desc')
                        ->paginate(15);
        }
        
        $array = [];
        foreach($lista->items() as $key => $item) {
            $array[$key]['new'] = $item;
            $new = News::find($item->id);
            foreach( $new->tags as $tagskey => $tags) {
                $array[$key]['tags'][$tagskey] = $tags;
            }
        }
       
        $lista = [
            'data' =>  $array, 
        ];
        
        if($lista){
            $retorno =  [
                'code'  => '000',
                'content' => [
                                'dados' =>  $lista, 
                            ],
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            
            return response()->json($retorno , 200);
        }else{
            $retorno =  [
                'code'  => '000',
                'content' => [
                                'dados' =>  [], 
                            ],
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return response()->json($retorno , 200);
        }
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\News  $news
     * @return \Illuminate\Http\Response
     */
    public function show(News $news)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\News  $news
     * @return \Illuminate\Http\Response
     */
    public function edit(News $news)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\News  $news
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, News $news)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\News  $news
     * @return \Illuminate\Http\Response
     */
    public function destroy(News $news)
    {
        //
    }
}
