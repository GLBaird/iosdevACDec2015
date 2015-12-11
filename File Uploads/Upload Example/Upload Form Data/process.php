<?php

// upload file assets
$name = $_FILES['image']['name'][0];
$type = $_FILES['image']['type'][0];
$path = $_FILES['image']['tmp_name'][0];
$err  = $_FILES['image']['error'][0];
$size = $_FILES['image']['size'][0];

$description = $_POST['description'];


if ($err == UPLOAD_ERR_OK) {
    echo "UPLOAD COMPLETE: $name,\ntype: $type, size: $size\nPATH: $path\n";
    echo "Description: $description\n\n";
    if (!file_exists("uploads")) {
        mkdir("uploads");
    }

    if (move_uploaded_file($path, "uploads/$name")) {
        echo "Uploaded file moved\n";
        $files = scandir("uploads");
        echo"\n\nFile List:\n";
        foreach($files as $file) {
            echo "  FILE: $file\n";
        }
    } else {
        echo "Failed to move file.\n";
    }
} else {
    echo "Error uploading image\n";
}

?>