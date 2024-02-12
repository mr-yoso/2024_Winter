<?php
namespace app\core;

class Controller
{
	function view($name, $data=null)
	{
		// Load the view files to present them to the client
		include('app/views/' . $name . '.php');
	}
}