<?php 
	/**
	* Sunrise, Sunset API
	*/
	class Subscription_API extends APP_API
	{
		public function add_user($params){
			//$this->redis->LPUSH('email', clean_email($params['email']));
			error_log('ADD EMAIL');
			$email = $this->clean_email($params['email']);
			$this->redis->SADD('subscription:email', $email);
		}

		private function clean_email($email){
			return strtolower(trim($email));
		}
	}
 ?>