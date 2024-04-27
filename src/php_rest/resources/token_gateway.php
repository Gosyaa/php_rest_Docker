<?php

//require('db.php');

class TokenGateway{
    private PDO $conn;
    public function __construct(DataBase $db){
        $this->conn = $db->getConn();
    }

    public function createToken ($user_id): string{
        $token = bin2hex(random_bytes(512));
        $validDate = date("Y-m-d H:i:s", time() + 10800 + 3600);   
        $sql = "INSERT INTO token (token, userId, validTill) VALUES (?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute(array($token, $user_id, $validDate));
        return $token;
    }

    public function getUserIdByToken ($token){
        $sql = "SELECT userId, validTill FROM token WHERE token = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute(array($token));
        $userId = null;
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
            if (is_null($row['validTill']) || strtotime($row['validTill']) >= time() + 10800)
                $userId = $row['userId'];
        }
        return $userId;
    }
}