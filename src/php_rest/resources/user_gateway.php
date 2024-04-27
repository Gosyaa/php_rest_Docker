<?php

/*require ('db.php');
require ('token_gateway.php');*/

class UserGateway{
    private PDO $conn;
    public function __construct (DataBase $db){
        $this->conn = $db->getConn();
    }

    public function getUserByUsername ($username): array{
        $sql = "SELECT * FROM user WHERE username = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute(array($username));
        $user = array();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC))
            $user = $row;
        return $user;
    }
    public function getUsernameByUserId ($userId){
        $sql = "SELECT username FROM user WHERE userId = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute(array($userId));
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC))
            return $row['username'];
        return null;
    }
    public function createUser ($username, $password){
        $passwordHash = password_hash($password, PASSWORD_DEFAULT);
        $sql = "INSERT INTO user (username, passwordHash) VALUES (?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt -> execute(array($username, $passwordHash));
        return $this->conn->lastInsertId();
    }

    public function loginUser ($username, $password, TokenGateway &$tokenGateway){
        $user = $this->getUserByUsername($username);
        if (password_verify($password, $user['passwordHash']))
            return $tokenGateway->createToken($user['userId']);
        else
            return null;
    }
}