<?php

include_once dirname(__FILE__).'/lib/Predis/Autoloader.php';
Predis\Autoloader::register();
$redis = new Predis\Client(array(
	'host' => 'HOST_ICI',
	'port' => 6379,
	'database' => 0
));


?>