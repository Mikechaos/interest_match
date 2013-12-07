Owl = 
	socket:null
	config:
		radius:5000
		username:"alexleclair2"
		notifyOnMention:true
		isConnected:false
		socketEndpoint: 'http://127.0.0.1:8080'
	connect: (config)->
		@socket = io.connect('http://localhost');
		@socket.on 'connect', (socket) ->
			console.log('CONNECTED !')
			_data = 
				username:Owl.config.username
				token:"MYTOKEN22s2"
				location:[0,0]
			console.log(_data);
			Owl.socket.emit('authenticate', _data)
		@socket.on 'authenticateResponse', (data) ->
			console.log('GOT RESPONSE', data)
			newData = 
				location:[56.33343,-67.7777123]
				radius:8882
			Owl.socket.emit('update', newData)
Owl.connect(Owl.config)