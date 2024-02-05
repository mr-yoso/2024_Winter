<?php
include_once "Controllers/Controller.php";
class HomeController extends Controller
{

    function route()
    {
        parent::route();

        $this->render("Home", "index");
    }
}

?>