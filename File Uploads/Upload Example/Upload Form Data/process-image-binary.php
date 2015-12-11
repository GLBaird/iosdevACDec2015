<?php

if ($_SERVER["CONTENT_TYPE"] == "image/jpeg") {
    
    echo "Request header is image/jpeg\n";
    
    $fileDetails = $_SERVER["HTTP_CONTENT_DISPOSITION"];
    echo $fileDetails."\n";
    $pattern = "/filename=\"(.+?)\"/i";
    if (preg_match($pattern, $fileDetails, $matches)) {
        echo "Filename matched as {$matches[1]}\n";
        $imageData = file_get_contents('php://input');
        if (file_put_contents("uploads/{$matches[1]}", $imageData)) {
            echo "File successfully moved";
        } else {
            echo "Failed to move file!";
        }
    } else {
        echo "Invalid filename provided.";
    }
    
} else {
    echo "No JPEG image format declaired on request header!";
}

?>