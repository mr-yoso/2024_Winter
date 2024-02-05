<?php


// $_GET
// $_SERVER

// echo "<pre>";var_dump($_GET);

$controller = (isset($_GET['controller'])) ? $_GET['controller'] : "home";
$action = (isset($_GET["action"])) ? $_GET["action"] : "index";
$id = (isset($_GET["id"])) ? intval($_GET["id"]) : -1;

var_dump($controller);
$classname = ucfirst($controller) . "Controller";
include_once "Controllers/$classname.php";
$contr = new $classname();
$contr->route();

?>