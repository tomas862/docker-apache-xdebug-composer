<?php

require_once 'vendor/autoload.php';

echo (new \Rivsen\Demo\Hello('Docker'))->hello();

// Create connection
$conn = new mysqli('db', 'root', 'root', 'test_db', 3306);

// Check connection
if ($conn->connect_error) {
    die("Connection to mysql failed: " . $conn->connect_error);
}

echo phpinfo();

