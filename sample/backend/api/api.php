<?php 
	require_once dirname(__FILE__).'/../lib/Predis/Autoloader.php';
	
	abstract class APP_API
	{
		private $user_info;
		protected $redis;
		protected $redis_transit;
		protected $init_messages;
		
		function __construct( $params )
		{
			Predis\Autoloader::register();
			$this->connect();
			//$this->user_info( $params['id'] );
		}

		private function connect(){
			$this->redis = new Predis\Client(array(
				'host' => '127.0.0.1',
				'port' => 6379,
				'database' => 0
			));

			$this->redis_transit = new Predis\Client(array(
				'host' => '127.0.0.1',
				'port' => 6379,
				'database' => 4
			));	
		}

		protected function user_info( $id ){
			//$this->user_info = $this->redis->get( $id );
		}
	}
 ?>