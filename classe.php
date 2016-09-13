<?php

/**
 * Fixa elementos e metodos
 * @author Claudio Souza Jr. <claudio@uerr.edu.br>
 */
class system {

    public $http_code_id;
    public $http_code_tipo;
    public $http_code_msg;
    public $http_code;
    public $http_conn;
    public $path;
    public $home;
    private $config;

    /**
     * Fixa as variaveis de ambiente
     */
    function __construct() {
        include 'config.php';
        $this->config = $config;
        $this->http_code = http_response_code();
        $this->http_conn = $this->HttpConn();
        $this->SysPath();
    }

    /**
     * Define o tipo de conexao usada na requisicao.
     * @return string String com o metodo de conexao.
     */
    function HttpConn() {
        $ServerPort = htmlspecialchars($_SERVER['SERVER_PORT']);
        if ($ServerPort == "443") {
            $http_conn = 'https';
        }
        else {
            $http_conn = 'http';
        }
        return $http_conn;
    }

    /**
     * Efetua a limpeza de uma variavel
     * @param varchar $value Valor a limpar
     * @param integer $type Tipo de limpeza a executar
     * @author Claudio Souza Jr. <claudio@uerr.edu.br>
     * @return integer Valor limpo (sem caracteres especiais)
     */
    function Cleaner($value, $type) {
        //Limpar um numero inteiro
        if ($type == '1') {
            $value = preg_replace("/[^a-zA-Z0-9]/", "", $value);
            return $value;
        }
        //Limpar URL
        elseif ($type == '2') {
            $value = str_replace('?', "", $value);
            $value = strtok($value, '?');
            return $value;
        }
        else {
            return FALSE;
        }
    }

    /**
     * Calcula caminho absoluto do sistema.
     * @return string Path absoluto do sistema.
     */
    function SysPath() {
        $PathName = htmlspecialchars($_SERVER['SCRIPT_FILENAME']);
        $ServerName = htmlspecialchars($_SERVER['SERVER_NAME']);
        $PathParts = pathinfo($PathName);
        $array = explode('*', $PathParts['dirname']);
        foreach ($array as $value) {
            $path = $value;
            $this->path = $path;
        }
        $arrayHome = explode("/", $PathParts['dirname']);
        foreach ($arrayHome as $valueHome) {
            $SystemDirname = $valueHome;
            $home = $this->Cleaner($this->http_conn . "://" . $ServerName . "/" . $SystemDirname . "/", 2);
            $this->home = $home;
        }
    }

    function SysEvent($http_code_id) {
        $array = $this->config['system']['httpcodes'];
        foreach ($array as $cod=>$var) {
            if ($cod == $http_code_id) {
                $this->http_code_id = $cod;
                $this->http_code_tipo = $var[0];
                $this->http_code_msg = $var[1];
            }
        }
    }
}
