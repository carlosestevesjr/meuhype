<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Support\Str;

use Illuminate\Http\Request;

use Mail;
use Validator;

use App\Contact;
use DB;

class ContactController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function contato(Request $request)
    {      

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

        // dd($request->all());

        //Validando os campos
        $validator = Validator::make($request->all(),
            [
                'name' => 'required|max:255',
                'email' => 'required|email',
                // 'tel' => 'required',
                'message' => 'required',
            ],
            $messages = [
                'name.required' => 'O campo nome deve ser preenchido.',
                'email.required' => 'O campo email deve ser preenchido.',
                // 'tel.required' => 'O campo telefone deve ser preenchido.',
                'message.required' => 'O campo menssagem deve ser preenchido.',
            ]
        );

        if( $validator->fails() ){
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
           
        }else{

            $params = $request->all();
           
            $dados = [ 
                'name'  => $params['name'],
                'email' =>  $params['email'],
                'm' => $params['message']
            ];
           

            $insert =  new Contact;
            $insert->name = $request->name;
            $insert->email = $request->email;
            $insert->assunto = 'Contato Pelo Site';
            $insert->message = $request->message;

            $condition = $insert->save();

            if($condition){
                
                Mail::send('emails.apicontato', $dados, function ($message) {
                    $message->from('inthemovie@nocinema.kinghost.net', 'Contato Meu Hype');
                    $message->subject('Contato Pelo App Meu Hype');
                    $message->to('carlosestevesjr0@gmail.com');
                    // $message->bcc('');
                });

                return $this->ResponseAPI( 
                    [
                        'dados' =>[
                            'message' => 'Email enviado com sucesso.',
                        ], 
                    ]
                    ,"O recurso solicitado foi processado e retornado com sucesso.", 201, '001'
                );

            }elseif(!$condition){
                return $this->ResponseAPI( 
                    [
                        'dados' =>[
                            'message' => 'Não foi inserir no banco de dados.',
                        ], 
                    ]
                    ,"O recurso solicitado foi processado e retornado com sucesso.", 200, '999'
                );
            }

            // Mail::send('emails.apicontato', $dados, function ($message) {
            //     $message->from('inthemovie@nocinema.kinghost.net', 'Contato Meu Hype');
            //     $message->subject('Contato Pelo App Meu Hype');
            //     $message->to('carlosestevesjr0@gmail.com');
            //     // $message->bcc('');
            // });

           
            
        }
        
        
        
    }

}