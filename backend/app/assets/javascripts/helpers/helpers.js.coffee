Number.prototype.toRad = ->
	this * Math.PI / 180;

@InterestMatch.helpers =

	calculateDistance:(lat1, lon1, lat2, lon2) ->
	
		earthRadius = 3958.75 # In miles
		dLat = (lat2-lat1).toRad();
		dLon = (lon2-lon1).toRad();

		lat1 = lat1.toRad();
		lat2 = lat2.toRad();

		a = Math.sin(dLat/2) * Math.sin(dLat/2) +
		Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2);
		c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
		d = earthRadius * c;
		d*5280; # In feets
