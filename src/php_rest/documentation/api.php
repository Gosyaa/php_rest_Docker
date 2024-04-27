<?php
require("../vendor/autoload.php");

require('../resources/db.php');
require('../resources/user_controller.php');
require('../resources/note_controller.php');
require('../resources/user_gateway.php');
require('../resources/note_gateway.php');
require('../resources/token_gateway.php');
require('../resources/error_handler.php');

$openapi = \OpenApi\Generator::scan([$_SERVER['DOCUMENT_ROOT'].'/php_rest/resources']);

header('Content-Type: application/json');
echo $openapi->toJSON();