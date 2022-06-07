<?php

namespace App\Exceptions;

use Throwable;

use App\Traits\ApiResponser;
use Exception;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Validation\ValidationException;
use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Symfony\Component\HttpKernel\Exception\MethodNotAllowedHttpException;
use Symfony\Component\HttpKernel\Exception\HttpException;

class Handler extends ExceptionHandler
{
    use ApiResponser;

    /**
     * A list of the exception types that are not reported.
     *
     * @var array
     */
    protected $dontReport = [
        //
    ];

    /**
     * A list of the inputs that are never flashed for validation exceptions.
     *
     * @var array
     */
    protected $dontFlash = [
        'password',
        'password_confirmation',
    ];

    /**
     * Report or log an exception.
     *
     * @param  \Throwable  $exception
     * @return void
     *
     * @throws \Throwable
     */
    public function report(Throwable $exception)
    {
        parent::report($exception);
    }

    /**
     * Render an exception into an HTTP response.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Throwable  $exception
     * @return \Symfony\Component\HttpFoundation\Response
     *
     * @throws \Throwable
     */
    public function render($request, Throwable $exception)
    {
        $response = $this->handleException($request, $exception);
        return $response;
    }
    

    public function handleException($request, Exception $exception)
    {
        
        if ($exception instanceof MethodNotAllowedHttpException) {
            return $this->errorResponseAPI('metodo para requisição é inválido', 405);
        }

        if ($exception instanceof NotFoundHttpException) {
            return $this->errorResponseAPI('URL não encontrada', 404);
        }

        if ($exception instanceof HttpException) {
            return $this->errorResponseAPI($exception->getMessage(), $exception->getStatusCode());
        }

        if (config('app.debug')) {
            return parent::render($request, $exception);            
        }
       
        return $this->errorResponseAPI('Ocorreu uma falha na plataforma. Por favor, entre em contato com o atendimento.', 500);

    }
    
    // Código	Nome	Descrição
    // 200	OK	O recurso solicitado foi processado e retornado com sucesso.
    // 201	Created	O recurso informado foi criado com sucesso.
    // 401	Unauthorized	A chave da API está desativada, incorreta ou não foi informada corretamente. Consulte a seção sobre autenticação da documentação.
    // 402	Payment Required	A chave da API está correta, porém a conta foi bloqueada por inadimplência. Neste caso, acesse o painel para verificar as pendências.
    // 403	Forbidden	O acesso ao recurso não foi autorizado. Este erro por ocorrer por dois motivos: (1) Uma conexão sem criptografia foi iniciada. Neste caso utilize sempre HTTPS. (2) As configurações de perfil de acesso não permitem a ação desejada. Consulte as configurações de acesso no painel de administração.
    // 404	Not Found	O recurso solicitado ou o endpoint não foi encontrado.
    // 406	Not Acceptable	O formato enviado não é aceito. O cabeçalho Content-Type da requisição deve contar obrigatoriamente o valor application/json para requisições do tipo POST e PUT.
    // 422	Unprocessable Entity	A requisição foi recebida com sucesso, porém contém parâmetros inválidos. Para mais detalhes, verifique o atributo errors no corpo da resposta.
    // 429	Too Many Requests	O limite de requisições foi atingido. Verifique o cabeçalho Retry-After para obter o tempo de espera (em segundos) necessário para a retentativa.
    // 400	Bad Request	Não foi possível interpretar a requisição. Verifique a sintaxe das informações enviadas.
    // 500	Internal Server Error	Ocorreu uma falha na plataforma Vindi. Por favor, entre em contato com o atendimento.
    // Nomes e códigos seguem a RFC 2616 do IETF.
    
    // Observações:
    
    // Métodos usados para buscas (GET /customers, por exemplo) retornam o código 200 mesmo que nenhum recurso tenha sido encontrado. Neste caso, o corpo da resposta conterá um array vazio.
    // Requisições do tipo DELETE e PUT retornam o código 200 se forem processadas com sucesso.
}
