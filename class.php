<?php

/**
 * Uses PHP's 'http_response_code()' to generate customized Apache response pages
 * @author Claudio Souza Jr. <claudio@uerr.edu.br>
 */
class system {

    public $http_code_id;
    public $http_code_type;
    public $http_code_msg;
    public $http_code;
    public $http_conn;
    private $config;

    /**
     * Declares the environment variables
     */
    function __construct() {
        include 'config.php';
        $this->config = $config;//See the 'config.php' file above
        $this->http_code = http_response_code();
        $this->http_conn = $this->httpconn();
        $this->sysevent($this->http_code);
    }

    /**
     * Defines the type of the connection used
     * @return string String with the connection mode
     */
    function httpconn() {
        if(!empty($_SERVER['HTTPS'])){
            return 'https://';
        }
        else{
            return 'http://';
        }
    }

    /**
     * Does a cleaning job in '$value'
     * @param string $value Value to clear
     * @param integer $type Type of cleaning
     * @author Claudio Souza Jr. <claudio@uerr.edu.br>
     * @return void Clean value with no special characters
     */
    function cleaner($value, $type) {
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
     * Returns the absolute URL of the system
     * @return string Absolute path
     */
    function baseurl() {
        return str_replace(
            'index.php',//remove this expression of the URL
            '',
            $this->cleaner(
                $this->http_conn.$_SERVER['HTTP_HOST'].$_SERVER['PHP_SELF'],
                '2'
            )
        );
    }

    /**
     * Extracts the information of the code based on the HTTP request
     * @param type $http_code_id
     * @return void
     */
    function sysevent($http_code_id) {
        $array = $this->config['system']['httpcodes'];
        foreach ($array as $cod=>$var) {
            if ($cod == $http_code_id) {
                $this->http_code_id = $cod;
                $this->http_code_type = $var[0];
                $this->http_code_msg = $var[1];
            }
        }
    }
}
