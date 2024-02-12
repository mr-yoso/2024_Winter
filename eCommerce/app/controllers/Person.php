<?php

namespace app\controllers;

class Person extends \app\core\Controller
{
	function __construct()
	{
	}

	function greet()
	{
		$personName = (isset($_GET['personName']) ?
			$_GET['personName'] : 'Friend');
		$someArray = ['one', 'two', 'three']; //sequential
		$assocArray = [
			'first_name' => 'Alice',
			'last_name' => 'Cooper'
		]; //associative array (dictionary)
		$this->view('Person/greet', [
			'Person_name' => $personName,
			'numbers' => $someArray,
			'profile' => $assocArray
		]);
	}
	function greet_again()
	{
		$personName = (isset($_GET['personName']) ? 
			$_GET['personName'] : 'Friend');
		$someArray = ['one', 'two', 'three']; //sequential
		$assocArray = [
			'first_name' => 'Alice',
			'last_name' => 'Cooper'
		]; //associative array (dictionary)
		$profileObj = new \stdClass(); //profile object
		$profileObj->first_name = 'Alice';
		$profileObj->last_name = 'Cooper';
		$this->view('Person/greet', [
			'Person_name' => $personName,
			'numbers' => $someArray,
			'profile' => $assocArray
		]);
	}
}
