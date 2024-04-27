<?php

class DataBase {
    public function __construct(private $host, private $name, private $user, private $password){}
    public function getConn(): PDO{
        //$s = "mysql:host=$this->host;dbname=$this->name";
        $conn = new PDO("mysql:host=$this->host;dbname=$this->name", $this->user, $this->password);
        return $conn;
    }
}