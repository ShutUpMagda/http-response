<?php
include 'classe.php';
$system = new system();
$system->SysEvent($system->http_code);?>
<!DOCTYPE html>
<html>
    <head>
        <title><?= $system->http_code .": ". $system->http_code_tipo ?></title>
        <base href="<?= $system->home ?>">
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <script src="http-response.js"></script>
        <link href="http-response.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="http-response.png">
    </head>
    <body>
        <div class="caixa">
            <div class="caixa_erro">
                <img src="<?= $system->home ?>http-response.png">
                <?= $system->http_code_id ?>
            </div>
            <center>
                <?= $system->http_code_msg ?>
            </center>
        </div>
    </body>
</html>
