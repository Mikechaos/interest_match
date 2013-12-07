<?php 
	/**
	* Sunrise, Sunset API
	*/
	class Sun_API extends APP_API
	{
		public function get_sun($params){
			// Find sunrise and sunset
	 		$sunrise = date_sunrise(time()+(60*60*24), SUNFUNCS_RET_TIMESTAMP, $params['lat'], $params['long'], 90, 1);
	 		$sunset  = date_sunset(time(), SUNFUNCS_RET_TIMESTAMP, $params['lat'], $params['long'], 90, 1);
	 		
	 		$return = json_encode(array('sunrise'=>$sunrise, 'sunset'=>$sunset));

		 	echo $return;
		}

		public function room_open($params){
			$sunrise = date_sunrise(time()+(60*60*24), SUNFUNCS_RET_TIMESTAMP, $params['lat'], $params['long'], 90, 1);
			$sunset  = date_sunset(time(), SUNFUNCS_RET_TIMESTAMP, $params['lat'], $params['long'], 90, 1);
			
			$now = new DateTime();
			$time_sunset = new DateTime(date('d F Y H:i:s', $sunset));
			$time_sunrise = new DateTime(date('d F Y H:i:s', $sunrise));

			if($now >= $time_sunset && $now < $time_sunrise){
				echo '1';
			}
			else{
				echo '0';
			}
		}

		public function open_in($params){
			$sunset  = date_sunset(time()+(60*60*24), SUNFUNCS_RET_TIMESTAMP, $params['lat'], $params['long'], 90, 1);
			$now = new DateTime();
			$time_sunset = new DateTime(date('d F Y H:i:s', $sunset));

			$difference = $now->diff($time_sunset);	

			echo $difference->format('%h')*60*60 + $difference->format('%i')*60 + $difference->format('%s');
		}
	}
 ?>