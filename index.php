<?php

require_once 'vendor/autoload.php';

echo (new \Rivsen\Demo\Hello('Docker'))->hello();

// Create connection
$conn = new mysqli('db', $_ENV['MYSQL_USER'], $_ENV['MYSQL_PASSWORD'], $_ENV['MYSQL_DATABASE'], 3306);

// Check connection
if ($conn->connect_error) {
    die("Connection to mysql failed: " . $conn->connect_error);
}

echo phpinfo();

