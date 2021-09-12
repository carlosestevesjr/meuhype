<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title> Meu Hype Crawler</title>
</head>
<body>
    <table style="font-size:14px;">
        <tr>
            <td>Data:</td>
            <td><strong>{{ date("d/m/Y H:i:s") }}</strong></td>
        </tr>
        <tr>
            <td>Tempo:</td>
            <td><strong>{{ $hora_inicial }} - {{ $hora_final }}</strong></td>
        </tr>
        <tr>
            <td>Dados:</td>
        
            <td>
                <strong> 
                    <?php
                        echo '<pre>';
                        print_r($data);
                        echo '</pre>';
                    ?>
                </strong>
               
            </td>
        </tr>
       
    </table>
</body>
</html>
