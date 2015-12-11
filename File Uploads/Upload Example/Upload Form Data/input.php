<?php

if (count($_GET) > 0) {
    $message = "Values sent with GET variables...\n";
    foreach($_GET as $key => $value) {
        $message.="  $key => $value\n";
    }
    
    echo "Get data received...";
} elseif (count($_POST) > 0) {
    $message = "Values sent with POST variables...\n";
    foreach($_POST as $key => $value) {
        $message.="  $key => $value\n";
    }
    
    echo "Post data received...";
} elseif ($_SERVER["CONTENT_TYPE"] == "application/json") {
    $inputJSON = file_get_contents('php://input');
    $input= json_decode( $inputJSON, TRUE ); //convert JSON into array
    echo "Post data received as JSON: \n";
    
    print_r($input);
    $message = "POST request received, with data encoded in JSON\n";
    foreach($input as $key => $value) {
        $message.="  $key => $value\n";
    }
} else {
    $message = "No data has been received!";
    echo "No data received...";
}

if ($_SERVER["CONTENT_TYPE"] != "application/json") {
    echo "\n\nRequest Data:\n";
    print_r($_REQUEST);
}

if ($message) {
    file_put_contents("output.txt", $message);
}

?>