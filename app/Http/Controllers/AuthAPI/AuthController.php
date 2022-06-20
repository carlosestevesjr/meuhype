<?php

namespace App\Http\Controllers\AuthAPI;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;

use App\User;
use App\TokenNotification;
use Validator;

class AuthController extends Controller
{
    private $apiToken;
    public function __construct()
    {
        // Unique Token
        $this->apiToken = uniqid(Str::random(60));
    }

    
    public function setTokenPush(Request $request)
    {
        
        $params = $request->all();
        $token_notification = TokenNotification::where( 'token',  '=', $params['token']  )->first();

        if($token_notification == null ){
    
            $insert = new TokenNotification;
    
            $insert->token = $params['token'];
            $insert->platform = $params['platform'];
            if($insert->token != ""){
                $condition = $insert->save();
                if($condition){
                    return "sucesso";
                }else{
                    return "erro";
                }
            }else{
                throw new \Exception("Necessario token");
            }

        }else{
            $token_notification->token = $params['token'];
            $token_notification->platform = $params['platform'];
            $token_notification->updated_at = now();
            $condition = $token_notification->save();
            if($condition){
                return "sucesso";
            }else{
                return "erro";
            }
        }

    }

    /**
     * Login
     */
    public function postLogin(Request $request)
    {
        // Validations
        $rules = [
            'email'=>'required|email',
            'password'=>'required|min:8'
        ];

        $messages = [
            'email.required' => 'O campo email deve ser preenchido.',
            'password.required' => 'O campo senha deve ser preenchido.',
            'password.min' => 'A senha deve conter no mínimo 8 caracteres.',
        ];

        $validator = Validator::make($request->all(), $rules, $messages);

        if ($validator->fails()) {

            return $this->ResponseAPI( 
                [
                    'dados' => [
                        'errors' => [
                            $validator->messages()
                        ], 
                    ], 
                ]
                ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '999'
            );

        }else {

            // User
            $user = User::where('email',$request->email)->first();

            if($user) {
                // Verifique o password
                if( password_verify($request->password, $user->password) ) {

                    // Update Token
                    $postArray = ['api_token' => $this->apiToken];
                    $login = User::where('email',$request->email)->update($postArray);
                    
                    if($login) {

                        return $this->ResponseAPI( 
                            [
                                'dados' => [
                                    'id'         => $user->id,
                                    'name'         => $user->name,
                                    'email'        => $user->email,
                                    'api_token' => $postArray['api_token'],
                                ], 
                            ]
                            ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '000'
                        );

                    }

                }else {
                    return $this->ResponseAPI( 
                        [
                            'dados' => [
                                'errors' => [
                                    'Senha inválida'
                                ], 
                               
                            ], 
                        ]
                        ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '999'
                    );

                }
            } else {

                return $this->ResponseAPI( 
                    [
                        'dados' => [
                            'errors' => [
                                'Usuário não existe'
                            ], 
                        ], 
                    ]
                    ,"O recurso solicitado foi processado e retornado com sucesso.", 401, '999'
                );

            }
        }
    }

    /**
     * Register
    */
    public function postRegister(Request $request)
    {

        $code_permition = $request->header('Authorization');
        if($code_permition === "cinemando"){

             // Validations
            $rules = [
                'name'     => 'required|min:3',
                'sexo'     => 'required',
                'email'    => 'required|unique:users,email',
                'password' => 'required|min:8'
            ];

			$messages = [
				'name.min'    => 'O nome deve conter no minimo 3 caracteres',
                'name.required' => 'O campo nome deve ser preenchido.',
                'sexo.required' => 'O campo sexo deve ser preenchido.',
                'email.unique' => 'O email já existe.',
                'email.required' => 'O campo email deve ser preenchido.',
                'password.required' => 'O campo senha deve ser preenchido.',
                'password.min' => 'A senha deve conter no mínimo 8 caracteres.',
            ];
            
            $validator = Validator::make($request->all(), $rules, $messages);
            if ($validator->fails()) {
                
                return response()->json([
                    'code'         => '001',
                    'message' => $validator->messages(),
                ]);

            } else {

                $postArray = [
                    'name'      => $request->name,
                    'email'     => $request->email,
                    'sexo'     => $request->sexo,
                    'password'  => Hash::make($request->password),
                    'api_token' => $this->apiToken
                ];
                
                $insert = new User;
                $insert->name = $request->name;
                $insert->email = $request->email;
                $insert->sexo = $request->sexo;
                $insert->password = Hash::make($request->password);
                $insert->api_token = $this->apiToken;
                $condition = $insert->save();

                if($condition) {

                    $retorno = [
                        'code'  => '000',
                        'content' => [
                                        'dados' => [
                                            'id'         => $insert->id,
                                            'name'         => $insert->name,
                                            'email'        => $insert->email,
                                            'sexo'         => $insert->sexo,
                                            'access_token' => $insert->api_token,
                                        ], 
                                    ],
                        'date'         => date("Y-m-d"),
                        'hour'         => date("H:i:s"),
                    ];
                    return response()->json($retorno , 201);

                } else {

                    $retorno = [
                        'code'         => '001',
                        'errors' => [
                            'O registro falhou, por favor tente novamente.'
                        ], 
                        'date'         => date("Y-m-d"),
                        'hour'         => date("H:i:s"),
                    ];
                    return response()->json($retorno , 400);

                }
            }
        }else{

            $retorno = [
                'code'         => '001',
                'errors' => [
                    'Token inválido'
                ], 
                'date'         => date("Y-m-d"),
                'hour'         => date("H:i:s"),
            ];
            return response()->json($retorno , 401);

        }
    }

    /**
    * Logout
    */
    public function postLogout(Request $request)
    {
        $params = $request->all();
        
        $token =  $params['apiToken'];
        $user = User::where('api_token', $token)->first();
        if($user) {
            $postArray = ['api_token' => null];
            $logout = User::where('id',$user->id)->update($postArray);
            if($logout) {
                return $this->ResponseAPI( 
                    [
                        'dados' => [
                            "message" => 'Login encerrado'
                        ], 
                    ]
                    ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '000'
                );
            }
        } else {
            return $this->ResponseAPI( 
                [
                    'dados' => [
                        'errors' => [
                            'Usuário não existe'
                        ], 
                    ], 
                ]
                ,"O recurso solicitado foi processado e retornado com sucesso.", 401, '999'
            );
            
        }
    }



}