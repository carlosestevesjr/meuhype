<!doctype html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title> Contato Pelo App Meu Hype</title>
</head>
<body>
    <table style="font-size:14px;">
        <tr>
            <td>Nome:</td>
            <td><strong>{{ $name }}</strong></td>
        </tr>
        <tr>
            <td>Email:</td>
            <td><strong>{{ $email }}</strong></td>
        </tr>
        <tr>
            <td>Telefone:</td>
            <td><strong>{{ $tel }}</strong></td>
        </tr>
        <tr>
            <td>Mensagem:</td>
            <td><strong>{{ $mensagem }}</strong></td>
        </tr>
        <tr>
            <td>Data:</td>
            <td><strong>{{ date("d/m/Y H:i:s") }}</strong></td>
        </tr>
    </table>
</body>
</html>
