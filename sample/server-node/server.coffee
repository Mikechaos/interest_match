#/** Converts numeric degrees to radians */
Number.prototype.toRad = ->
	return this * Math.PI / 180;

App = 
	io: null
	redisWorker:null
	httpServer:null
	fs:null
	clients:{
		objects:{}
		usernameMap:{
			#alexleclair:'asdadsads'
		}
		socketMap:{},
		subscribers:{}
		subscribees:{}
	}
	config:
		port:8080
		redisHost:'127.0.0.1'
		redisPort:6379

	init: (config)->
		# Load libs only on init
		if config?
			@config = @_mergeOptions @config config

		@fs = require('fs');
		@httpServer = require('http').createServer(@_handleHttpRequest);
		@httpServer.listen(@config.port)
		@io = require('socket.io').listen(@httpServer);
		@io.set('log level', 1);



		@io.sockets.on('connection', (socket)-> 
			console.log('CONNECTED')
			socket.on 'authenticate', (data) ->
				response = 
					authenticated:true
					usernameTaken:false

				if(data? && data.token?)
					#Do not check username if the user already has a username associated to its account.
					response.usernameTaken = App.getClient(data.token) == false && App._validateUsername if data? and data.username? then data.username else null #Validate Usernames
					closeSocket = true;
					try
						if !response.usernameTaken 
							App.clients.objects[data.token] = App._createClient(socket, if data? then data else null)
						closeSocket = false;
					catch e
						console.log e.message
					if closeSocket
						console.log 'close socket'
						socket.disconnect()
						return
					socket.emit 'authenticateResponse', response

			socket.on 'message', (msg) ->
				console.log('RECEIVED MESSAGE', msg);
				from = App.getClientBySocket(socket);
				_data = {
					type:'message'
					username:from.username,
					message:msg.content
					mention:false;
				}
				App.sendUpdate from, _data;

			socket.on 'update', (data) ->
				_client = App.getClientBySocket(socket.id)
				if(_client)
					if data.location?
						_client.location = data.location 
					if data.radius?
						_client.radius = data.radius 
					#App._updateOwnSubscribers _client;
					App._updateSubscribers _client, 'local';
					App._updateSubscribers _client, 'remote';
		);

	sendUpdate: (from, data, type='remote') ->
		if type=='remote'
			for token of App.clients.subscribers[from.deviceToken]
				try
					if(data? && data.type? && data.type=='message')
						data.mention = false;
						if (+' '+data.message.toLowerCase()+' ').indexOf('@'+from.username.toLowerCase())
							data.mention = true;
					App.clients.objects[token].socket.emit('update', data);
					console.log from.deviceToken, 'sending to', token
				catch e
					# ...
		else #local
			try
				from.socket.emit('update', data);
			catch e
				console.log e.message;

	_updateSubscribers:(client, type="local")->
		subscribers = {}
		count = 0;
		_currentLoc = 
			latitude:client.location[0],
			longitude:client.location[1]
		_localUsernames = []

		for _token of App.clients.objects
			try
				if App.clients.objects[_token].username?
					#console.log('Find client', App.clients.objects[_token].username);
					distance = App._calculateDistance(_currentLoc, {
						latitude:  App.clients.objects[_token].location[0]
						longitude: App.clients.objects[_token].location[1]
						})
					if(distance < 0 || distance > if type=="local" then client.radius else App.clients.objects[_token].radius)
						continue;
					if type=='local'
						_localUsernames.push App.clients.objects[_token].username
					++count;
					subscribers[_token] = true;	
				# ...
			catch e
				console.log e.message
				# ...

			if type=="local"
				App.clients.subscribers[client.deviceToken] = subscribers

				App.sendUpdate client, {
					type:'subscribers-list',
					list:_localUsernames
				}

			else #REMOTE
				try
					for token of App.clients.subscribees[client.deviceToken] #Get old subscribers, remove ourselves from it.
						try
							App.clients.subscribers[token][client.deviceToken] = null

				for token of subscribers #Push it back into the new ones
					console.log token, type
					App.clients.subscribers[token][client.token] = true

				App.clients.subscribees[client.deviceToken] = subscribers
		return count;
		

	getClientBySocket: (socket) ->
		try
			if socket? && App.clients.socketMap[if socket.id? then socket.id else socket]?
				return App.clients.objects[App.clients.socketMap[if socket.id? then socket.id else socket]]
		return false

	getClient: (token) ->
		try
			if token? && App.clients.objects[token]?
				return App.clients.objects[token]
			return false
		return false;

	_validateUsername: (username) ->
		return App.clients.usernameMap[username]?

	deleteClient: (token) ->
		if not token?
			return false;			
		client = App.getClient token
		if client
			try
				client.socket.disconnect();
			catch e
				# ...
			try
				if client.username?
					App.clients.usernameMap[client.username] = null;
				App.clients.socketMap[client.id] = null;
				App.clients.objects[client.token] = null;
				return true;

		return false;

	_createClient: (socket, data) ->
		_client = 
			id:socket.id
			socket:socket
			location:data.location
			username:data.username
			deviceToken:data.token
			authenticated:true
			radius: data.radius

		App.clients.objects[data.token] = _client;
		App.clients.usernameMap[_client.username] = data.token
		App.clients.socketMap[_client.id] = data.token
		App._updateSubscribers(_client, 'local');
		App._updateSubscribers(_client, 'remote');
		return _client;
	_handleHttpRequest: (req, res) ->
		App.fs.readFile __dirname + req.url.split('?')[0], (err, data)->
			if(err)
				res.writeHead '500'
				return res.end('Error loading index.html')
			res.writeHead '200'
			res.end data;

	_calculateDistance:(pos1, pos2)->
		try
			lat1 = pos1.latitude;
			lat2 = pos2.latitude;

			lon1 = pos1.longitude;
			lon2 = pos2.longitude;

			R = 6371; # km

			dLat = (lat2-lat1).toRad();
			dLon = (lon2-lon1).toRad();

			lat1 = lat1.toRad();
			lat2 = lat2.toRad();

			a = Math.sin(dLat/2) * Math.sin(dLat/2) +
			Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2); 
			c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
			d = R * c;
			return d*1000; #In meters

		return -1;


	_mergeOptions:(obj1, obj2) ->
		obj3 = {}
		for attrname of obj1
			obj3[attrname] = obj1[attrname]
		for attrname of obj2
			obj3[attrname] = obj2[attrname]
		return obj3

App.init()
