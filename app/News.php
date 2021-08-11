<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class News extends Model
{
    protected $table = 'news';

    public function tags()
    {
        //$this->belongsToMany('relacao', 'nome da tabela pivot', 'key ref. authors em pivot', 'key ref. books em pivot')
        return $this->belongsToMany(Tags::class, 'news_tags', 'news_id', 'tags_id');

    }
   
}
