<?php 
	include_once dirname(__FILE__).'/api/api.php';
	include_once dirname(__FILE__).'/api/sun.php';
	include_once dirname(__FILE__).'/api/subscription.php';

	$construct = array();
	$params    = array();

	// Set des différente variables
	$api = $_GET['api'];

	if(isset($_GET['params_construct']))
		$construct = $_GET['params_construct'];

	$method    = $_GET['method'];

	if(isset($_GET['params']))
		$params    = $_GET['params'];

	error_log('TEST');
	//Appelle de la bonne méthode et envoie des params de constructeur
	$api = new $api($construct);
	//Apelle de la méthode et envoie des params
	$api->$method($params);

 ?>