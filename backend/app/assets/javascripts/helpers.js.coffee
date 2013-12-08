Number.prototype.toRad = ->
	this * Math.PI / 180;

window.InterestMatch.helpers =

	calculateDistance:(lat1, lon1, lat2, lon2) ->
	
		R = 6371; # km
		dLat = (lat2-lat1).toRad();
		dLon = (lon2-lon1).toRad();

		lat1 = lat1.toRad();
		lat2 = lat2.toRad();

		a = Math.sin(dLat/2) * Math.sin(dLat/2) +
		Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2);
		c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
		d = R * c;
		d*1000*3.2808399; #In feets
