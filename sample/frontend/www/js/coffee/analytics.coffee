app.analytics = 
	event: (name, data) ->
		_gaq.push ['_trackPageview', "/event/#{name}"]
		console.log "Event: #{name}" if app.debug