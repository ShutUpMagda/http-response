<?php
include '../class.php';
$sys = new system();
?>
<!DOCTYPE html>
<html>
    <head>
        <base href="<?= $sys->baseurl() ?>">
        <title><?= $sys->http_code .": ". $sys->http_code_type ?></title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <script src="http-response.js"></script>
        <link href="http-response.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="http-response.png">
    </head>
    <body>
        <div class="caixa">
            <div class="caixa_erro">
                <img src="http-response.png">
                <?= $sys->http_code_id ?>
            </div>
            <center>
                <?= $sys->http_code_msg ?>
            </center>
        </div>
    </body>
</html>
