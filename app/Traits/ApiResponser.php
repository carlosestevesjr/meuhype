<?php

namespace App\Traits;

use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Cache;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Validator;
use Illuminate\Pagination\LengthAwarePaginator;

trait ApiResponser{

    protected function successResponseAPI($data, $message = null, $code = 200)
	{
        return response()->json([
            'code'  => '000',
            'type'=>'Success',
            'content' => $data,
            'message' => $message, 
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
		], $code);

	}

	protected function errorResponseAPI($message = null, $code)
	{
        return response()->json([
            'code'  => '999',
            'type'=>'Error',
            'content' => "",
            'message' => $message, 
            'date'         => date("Y-m-d"),
            'hour'         => date("H:i:s"),
		], $code);

	}

}