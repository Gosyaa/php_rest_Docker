<?php

class NoteGateway{
    private PDO $conn;
    public function __construct(DataBase $db){
        $this->conn = $db->getConn();
    }
    public function newNote($title, $text, $userId){
        $sql = "INSERT INTO note (noteTitle, noteText, authorId, timeAdded) VALUES (?, ?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute(array($title, $text, $userId, date("Y-m-d H:i:s", time() + 10800)));
        return $this->conn->lastInsertId();
    }
    public function getNote($noteId){
        $sql = "SELECT noteTitle, noteText, authorId, timeAdded FROM note WHERE noteId = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute(array($noteId));
        while ($row = $stmt->fetch((PDO::FETCH_ASSOC)))
            return $row;
        return array();
    }
    public function getAllNotes($userId=null){
        $sql = "SELECT noteTitle, noteText, authorId, timeAdded FROM note";
        $arguments = array();
        if (!is_null($userId)){
            $sql = $sql . " WHERE authorId = ?";
            $arguments[] = $userId;
        }
        $sql .= ' ORDER BY timeAdded ASC';
        $stmt = $this->conn->prepare($sql);
        $stmt->execute($arguments);
        $notes = array();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
            $notes[] = $row;
        }
        return $notes;
    }
    public function getNotesOnDate($date, $userId=null): array{
        return $this->getNotesOnRange($date, $date, $userId);
    }
    public function getNotesOnRange($dateStart=null, $dateEnd=null, $userId=null){
        if (is_null($dateStart) && is_null($dateEnd))
            return $this->getAllNotes($userId);
        $dateStart = $dateStart ?? '1970-01-02';
        $dateStart .= ' 00:00:00';
        $dateEnd = $dateEnd ?? '2038-01-18';
        $dateEnd .= ' 23:59:59';

        $sql = "SELECT noteTitle, noteText, authorId FROM note
        WHERE timeAdded >= ? AND timeAdded <= ? ORDER BY timeAdded ASC";
        $arguments = array($dateStart, $dateEnd);
        if (!is_null($userId)){
            $sql = $sql . " AND authorId = ?";
            $arguments[] = $userId;
        }
        $stmt = $this->conn->prepare($sql);
        $stmt->execute($arguments);
        $notes = array();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
            $notes[] = $row;
        }
        return $notes;
    }
    public function updateNote($noteId, $noteTitle = null, $noteText = null){
        if (is_null($noteText) && is_null($noteTitle)){
            return $this->getNote($noteId);
        }
        $note = $this->getNote($noteId);
        $sql = "UPDATE note SET timeAdded = ?";
        $arguments = array($note['timeAdded']);
        if (!is_null($noteTitle)){
            $sql .= ', noteTitle = ?';
            $arguments[] = $noteTitle;
        }
        if (!is_null($noteText)){
            $sql .= ', noteText = ?';
            $arguments[] = $noteText;
        }
        $sql .= ' WHERE noteId = ?';
        $arguments[] = $noteId;
        $stmt = $this->conn->prepare($sql);
        $stmt->execute($arguments);
        return $this->getNote($noteId);
    }
    public function deleteNote($noteId){
        $sql = "DELETE FROM note WHERE noteId = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute(array($noteId));
    }
}