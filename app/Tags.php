<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Tags extends Model
{
    protected $table = 'tags';

    public  $timestamps   = true;

    // public function blogs()
    // {
    //     //$this->belongsToMany('relacao', 'nome da tabela pivot', 'key ref. authors em pivot', 'key ref. books em pivot')
    //     return $this->belongsToMany('App\Blog','blog', 'id_tagblog', 'id_blog');

    // }

    /**
     * The users that belong to the role.
     */
    public function news()
    {
        return $this->belongsToMany(News::class, 'news');
    }
}
