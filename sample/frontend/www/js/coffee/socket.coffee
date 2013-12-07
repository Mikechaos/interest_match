app.socket =
	engine:null
	config:
		init:false
		radius:5000
		username:null
		token:null
		position:null
		notifyOnMention:true
		isConnected:false
		socketEndpoint: 'http://getnightowl.com:8080'
	init: ->
		@engine = io.connect(@config.socketEndpoint);
		@engine.on 'connect', (socket) ->
			app.analytics.event 'session/connect'
	
		@engine.on 'authenticateResponse', (data) ->
			console.log data
			if data.usernameTaken
				$('.alert.already-use').slideDown 500
				$('input.username').removeAttr 'disabled'
				$('input.username').val ''
				$('input.username').focus()
			else
				app.user.authenticate = true
				window.location = '#message'
				app.analytics.event 'session/authenticate'
		@engine.on 'update', (data) ->
			app.trigger data.type, data
		@engine.on 'disconnect', (socket) ->
			app.user.authenticate = false
			app.analytics.event 'session/disconnect'
			window.location = '#'
	connect: ->
		app.user = 
			username:app.socket.config.username
			token:app.socket.config.token
			location:app.socket.config.position
			authenticate:false
		app.socket.push 'authenticate', app.user
	push: (name, data) ->
		app.socket.engine.emit name, data
		app.analytics.event 'push/'+name
		console.log data


