<?php

use OpenApi\Annotations as OA;

/**
 * @OA\Info(
 *     version="1.0",
 *     title="Notes-API",
 *     description="API для доступа к спискам заметок и их фильтрации",
 *     @OA\Contact(name="Swagger API Team")
 * ),
 * @OA\SecurityScheme(
 *     type="http",
 *     scheme="bearer",
 *     securityScheme="bearerAuth",
 *     description="Введите авторизационный токен"
 * )
 */
class NoteController{
    private $data;
    public function __construct(private NoteGateway &$noteGateway, 
    private TokenGateway &$tokenGateway, private UserGateway &$userGateway){}
    //Перенаправление запростов на соответствующие методы
    public function proccessRequest($method, $extra=null){
        $this->data = json_decode(file_get_contents('php://input'), true);
        switch ($method){
            case 'GET':
                if (isset($_GET['id']))
                    $this->getNoteById($_GET['id']);
                else 
                    http_response_code(400);
                break;
            case 'POST':
                if ($extra == 'new')
                    $this->createNewNote();
                else if (is_null($extra))
                    $this->getNotes();
                else
                    http_response_code(404);
                break;
            case 'PUT':
                if (isset($_GET['id']))
                    $this->editNote($_GET['id']);
                else
                    http_response_code(400);
                break;
            case 'DELETE':
                if (isset($_GET['id']))
                    $this->deleteNote($_GET['id']);
                else
                    http_response_code(400);
                break;
            default:
                http_response_code(404);
                exit;
        }
    }
    //Приведение заметки к требуемоу формату
    private function transformNote(&$note): array{
        $token = substr(getallheaders()['Authorization'] ?? null, 7);
        $note['author'] = $this->userGateway->getUsernameByUserId($note['authorId']);
        if (!empty($token) && $note['authorId'] == $this->tokenGateway->getUserIdByToken($token))
            $note['isAuthor'] = true;
        else if(!is_null($token) && !empty($token))
            $note['isAuthor'] = false;
        unset($note['authorId']);
        if (isset($note['timeAdded']))
            unset($note['timeAdded']);
        return $note;
    }

    /**
     * @OA\Get(
     *     path="/php_rest/note/",
     *     summary="Метод для получения заметки по ID",
     *     tags={"notes"},
     *     security={{"bearerAuth": {}}},
     *     @OA\Parameter(
     *         name="id",
     *         in="query",
     *         required=true,
     *         description="The ID of the Note",
     *         @OA\Schema(
     *             type="string"
     *         )
     *     ),
     *     @OA\Response(response="200", description="Возвращена заметка"),
     *     @OA\Response(response="404", description="Заметка не найдена"),
     *     @OA\Response(response="500", description="Ошибка на стороне сервера"),
     * )
     */
    private function getNoteById($id){
        $note = $this->noteGateway->getNote($id);
        if(empty($note)){
            http_response_code(404);
            exit;
        }
        $note = $this->transformNote($note);
        echo json_encode($note);
        http_response_code(200);
    }

    /**
     * @OA\Post(
     *    path="/php_rest/note/new",
     *    summary="Метод для вставки новой заметки (Обязательна авторизация)",
     *    tags={"notes"},
     *    security={{"bearerAuth": {}}},
     *    @OA\RequestBody(
     *      @OA\MediaType(
     *          mediaType="application/json",
     *          @OA\Schema(
     *              @OA\Property(
     *                  property="title",
     *                  type="string"
     *              ),
     *              @OA\Property(
     *                  property="text",
     *                  type="string"
     *              )
     *          )
     *      )     
     *    ),
     *    @OA\Response(response="201", description="Возвращён id новой заметки"),
     *    @OA\Response(response="400", description="Отсутствуют необходимые параметры"),
     *    @OA\Response(response="401", description="Нет доступа"),
     *    @OA\Response(response="500", description="Ошибка на стороне сервера")
     * )
     */
    private function createNewNote(){
        if (!isset($this->data['title']) || !isset($this->data['text']) || strlen($this->data['title']) > 50){
            http_response_code(400);
            exit;
        }
        $token = substr(getallheaders()['Authorization'] ?? null, 7);
        $userId = $this->tokenGateway->getUserIdByToken($token);
        if (is_null($userId)){
            http_response_code(401);
            exit;
        }
        $noteId = $this->noteGateway->newNote($this->data['title'], $this->data['text'], $userId);
        echo json_encode($noteId);
        http_response_code(201);
    }

    /**
     * @OA\Post(
     *    path="/php_rest/note",
     *    summary="Метод для получения списка заметок по фильтру",
     *    tags={"notes"},
     *    security={{"bearerAuth": {}}},
     *    @OA\RequestBody(
     *      @OA\MediaType(
     *          mediaType="application/json",
     *          @OA\Schema(
     *              @OA\Property(
     *                  property="user-id",
     *                  type="int"
     *              ),
     *              @OA\Property(
     *                  property="username",
     *                  type="string"
     *              ),
     *              @OA\Property(
     *                  property="date",
     *                  type="date"
     *              ),
     *              @OA\Property(
     *                  property="date-start",
     *                  type="date"
     *              ),
     *              @OA\Property(
     *                  property="date-end",
     *                  type="date"
     *              )
     *          )
     *      )     
     *    ),
     *    @OA\Response(response="200", description="Возвращён список заметок"),
     *    @OA\Response(response="500", description="Ошибка на стороне сервера"),
     * )
     */
    private function getNotes(){
        $userId = $this->data['user-id'] ?? null;
        if (is_null($userId) && isset($this->data['username'])){
            $userId = $this->userGateway->getUserByUsername($this->data['username'])['userId'] ?? 0;
        }
        if (isset($this->data['date']))
            $notes = $this->noteGateway->getNotesOnDate($this->data['date'], $userId);
        else if (isset($this->data['date-start']) || isset($this->data['date-end'])){
            $dateStart = $this->data['date-start'] ?? null;
            $dateEnd = $this->data['date-end'] ?? null;
            $notes = $this->noteGateway->getNotesOnRange($dateStart, $dateEnd, $userId);
        }
        else
            $notes = $this->noteGateway->getAllNotes($userId);
        foreach ($notes as &$note)
            $note = $this->transformNote($note);
        echo json_encode($notes);
        http_response_code(200);
    }
    //Проверка, может ли текущий пользователь редактировать или удалять выбранную заметку
    private function editableNote(array $note): bool{
        if (empty($note))
            return false;
        $token = substr(getallheaders()['Authorization'] ?? null, 7);
        if ($this->tokenGateway->getUserIdByToken($token) != $note['authorId'])
            return false;
        if (strtotime($note['timeAdded']) + 86400 < time() + 10800)
            return false;
        return true;
    }

    /**
     * @OA\Put(
     *    path="/php_rest/note/",
     *    summary="Метод для вставки новой заметки (Обязательна авторизация)",
     *    tags={"notes"},
     *    security={{"bearerAuth": {}}},
     *    @OA\Parameter(
     *         name="id",
     *         in="query",
     *         required=true,
     *         description="The ID of the Note",
     *         @OA\Schema(
     *             type="string"
     *         )
     *    ),
     *    @OA\RequestBody(
     *      @OA\MediaType(
     *          mediaType="application/json",
     *          @OA\Schema(
     *              @OA\Property(
     *                  property="title",
     *                  type="string"
     *              ),
     *              @OA\Property(
     *                  property="text",
     *                  type="string"
     *              )
     *          )
     *      )     
     *    ),
     *    @OA\Response(response="201", description="Возвращена изменённая заметка"),
     *    @OA\Response(response="400", description="Отсутствуют необходимые параметры"),
     *    @OA\Response(response="401", description="Нет доступа"),
     *    @OA\Response(response="500", description="Ошибка на стороне сервера")
     * )
     */
    private function editNote($id){
        $note = $this->noteGateway->getNote($id);
        if (empty($note)){
            http_response_code(404);
            exit;
        }
        $title = $this->data['title'] ?? null;
        if (!$this->editableNote($note)){
            http_response_code(401);
            exit;
        }
        if ((!is_null($title) && strlen($title)) > 50){
            http_response_code(400);
            exit;
        }
        $text = $this->data['text'] ?? null;
        $note = $this->noteGateway->updateNote($id, $title, $text);
        $note = $this->transformNote($note);
        echo json_encode($note);
        http_response_code(201);
    }

    /**
     * @OA\Delete(
     *     path="/php_rest/note/",
     *     summary="Метод для получения заметки по ID (Обязательна авторизация)",
     *     tags={"notes"},
     *     security={{"bearerAuth": {}}},
     *     @OA\Parameter(
     *         name="id",
     *         in="query",
     *         required=true,
     *         description="The ID of the Note",
     *         @OA\Schema(
     *             type="string"
     *         )
     *     ),
     *     @OA\Response(response="204", description="Заметка удалена"),
     *     @OA\Response(response="404", description="Заметка не найдена"),
     *     @OA\Response(response="500", description="Ошибка на стороне сервера"),
     * )
     */
    private function deleteNote($id){
        $note = $this->noteGateway->getNote($id);
        if (empty($note)){
            http_response_code(404);
            exit;
        }
        if (!$this->editableNote($note)){
            http_response_code(401);
            exit;
        }
        $this->noteGateway->deleteNote($id);
        http_response_code(204);
    }
}