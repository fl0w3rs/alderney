<?php
require __DIR__ . '/config.php';

error_reporting(E_ALL);
ini_set('display_errors', config['dev_mode'] ? 'On' : 'Off');

require __DIR__ . '/../vendor/autoload.php';

require __DIR__ . '/database.php';

function responseJson(array $arr) {
    header("Content-type: application/json");
    return json_encode($arr, JSON_UNESCAPED_UNICODE);
}

$input = json_decode(file_get_contents("php://input"), true);
if(is_array($input)) {
    $_POST = array_merge($_POST, $input);
}