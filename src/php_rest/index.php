<?php

require('resources/db.php');
require('resources/user_controller.php');
require('resources/note_controller.php');
require('resources/user_gateway.php');
require('resources/note_gateway.php');
require('resources/token_gateway.php');
require('resources/error_handler.php');

set_error_handler("ErrorHandler::handleError");
set_exception_handler("ErrorHandler::handleException");

header("Content-type: application/json");

$parts = explode('/', $_SERVER['REQUEST_URI']);

//echo json_encode($parts);
$db = new DataBase("mysql_db", "notes_db_vk", "root", "");

$userGateway = new UserGateway($db);
$tokenGateway = new TokenGateway($db);
$noteGateway = new NoteGateway($db);

$userController = new UserController($userGateway, $tokenGateway);
$noteController = new NoteController($noteGateway, $tokenGateway, $userGateway);

switch ($parts[2]){
    case 'user':
        if (isset($parts[3]))
            $userController->proccessRequest($_SERVER['REQUEST_METHOD'], $parts[3]);
        break;
    case 'note':
        $noteController->proccessRequest($_SERVER['REQUEST_METHOD'], $parts[3] ?? null);
        break;
    default:
        http_response_code(404);
        exit;
}