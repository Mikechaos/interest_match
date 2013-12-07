app.localisation = 
	update: (lon, lat) ->
		app.socket.push 'update', [lon, lat]