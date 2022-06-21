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
            <td><strong><?php echo $name;?> </strong></td>
        </tr>
        <tr>
            <td>Email:</td>
            <td><strong><?php echo $email;?> </strong></td>
        </tr>
        <!-- <tr>
            <td>Telefone:</td>
            <td><strong> $tel </strong></td>
        </tr> -->
        <tr>
            <td>Mensagem:</td>
            <td>
                <strong>
                <?php echo $m;?>
                </strong>
            </td>
        </tr>
        <tr>
            <td>Data:</td>
            <td><strong><?php echo date("d/m/Y H:i:s");?>  </strong></td>
        </tr>
    </table>
</body>
</html>
