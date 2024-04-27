<?php 

/*require('user_gateway.php');
require ('token_gateway.php');*/

class UserController{
    private $data;
    public function __construct(private UserGateway &$userGateway, private TokenGateway &$tokenGateway) {}
    public function proccessRequest($method, $request){
        $this->data = json_decode(file_get_contents('php://input'), true);
        if ($method != 'POST' || !isset($this->data['username']) || !isset($this->data['password'])){
            http_response_code(400);
            exit;
        }
        switch ($request){
            case 'login':
                $this->proccessLogin();
                break;
            case 'register':
                $this->proccessRegister();
                break;
            default:
                http_response_code(404);
                exit;
        }
    }

    /**
     * @OA\Post(
     *    path="/php_rest/user/login",
     *    summary="Метод для логина пользователя",
     *    tags={"users"},
     *    security={{"bearerAuth": {}}},
     *    @OA\RequestBody(
     *      @OA\MediaType(
     *          mediaType="application/json",
     *          @OA\Schema(
     *              @OA\Property(
     *                  property="username",
     *                  type="string"
     *              ),
     *              @OA\Property(
     *                  property="password",
     *                  type="string"
     *              )
     *          )
     *      )     
     *    ),
     *    @OA\Response(response="200", description="Возвращён авторизационный токен"),
     *    @OA\Response(response="401", description="Неверные данные для входа"),
     *    @OA\Response(response="404", description="Пользователь не найден"),
     *    @OA\Response(response="500", description="Ошибка на стороне сервера"),
     * )
     */
    private function proccessLogin(){
        if (empty($this->userGateway->getUserByUsername($this->data['username']))){
            http_response_code(404);
            exit;
        }
        $token = $this->userGateway->loginUser($this->data['username'], $this->data['password'], $this->tokenGateway);
        if (is_null($token))
            http_response_code(401);
        else{
            http_response_code(200);
            echo json_encode(array($token));
        }
    }

    /**
     * @OA\Post(
     *    path="/php_rest/user/register",
     *    summary="Метод для регистрации пользователя",
     *    tags={"users"},
     *    security={{"bearerAuth": {}}},
     *    @OA\RequestBody(
     *      @OA\MediaType(
     *          mediaType="application/json",
     *          @OA\Schema(
     *              @OA\Property(
     *                  property="username",
     *                  type="string"
     *              ),
     *              @OA\Property(
     *                  property="password",
     *                  type="string"
     *              )
     *          )
     *      )     
     *    ),
     *    @OA\Response(response="201", description="Возвращён id нового пользователя"),
     *    @OA\Response(response="400", description="Имя пользователя занято"),
     *    @OA\Response(response="500", description="Ошибка на стороне сервера"),
     * )
     */
    private function proccessRegister(){
        if (empty($this->userGateway->getUserByUsername($this->data['username'])) &&
            strlen($this->data['password']) >= 6 && strlen($this->data['password']) <= 100
            && strlen($this->data['username']) <= 50){
            $newUserId = $this->userGateway->createUser($this->data['username'], $this->data['password']);
            echo json_encode($newUserId);
            http_response_code(201);
        }
        else{
            http_response_code(400);
            exit;
        }
    }
}