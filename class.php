<?php

/**
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
     * Declares the environment variables
     */
    function __construct() {
        include 'config.php';
        $this->config = $config;
        $this->http_code = http_response_code();
        $this->http_conn = $this->HttpConn();
        $this->SysPath();
    }

    /**
     * Defines the type of the connection used
     * @return string String with the connection mode
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
     * Does a cleaning job in '$value'
     * @param string $value Value to clear
     * @param integer $type Type of cleaning
     * @author Claudio Souza Jr. <claudio@uerr.edu.br>
     * @return void Clean value with no special characters
     */
    function Cleaner($value, $type) {
        // Clear integer variable
        if ($type == '1') {
            $value = preg_replace("/[^a-zA-Z0-9]/", "", $value);
            return $value;
        }
        // Clear URL string
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
     * Calculates the absolute path of the system
     * @return string Absolute path
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
