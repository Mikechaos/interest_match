#Libs
$ = window.jQuery
Backbone = window.Backbone
_ = window._
io = window.io

window.app = 
	debug:true
	user:
		authenticate:false
app = window.app

_.extend app, Backbone.Events

isPhoneGap = () ->
	if document.URL.indexOf("file://") == 0
		true
	else
		false

window.phoneGap = isPhoneGap()

app.ready = (username) ->
	if window.phoneGap

		app.socket.config.username = username
		app.socket.config.token = device.uuid

		onSuccess = (position) ->
			app.socket.config.position = [position.coords.longitude, position.coords.latitude]
			app.socket.connect()

		onError = (error) ->
			$('.alert.localisation').slideDown 500
			app.analytics.event 'error/no_position'
			$('input.username').removeAttr 'disabled'

		navigator.geolocation.getCurrentPosition(onSuccess, onError)
	else
		app.socket.config.username = username
		randLetter = String.fromCharCode(65 + Math.floor(Math.random() * 26))
		uniqid = randLetter + Date.now()
		app.socket.config.token = "broswer-#{uniqid}"
		#alert uniqid
		app.socket.config.position = [45.5081,73.5550] #Montreal Hardcoded
		app.socket.connect()



app.init = ->
	app.user.init()
	app.message.init()
	Backbone.history.start()
	app.socket.init()
	app.analytics.event 'session/new'
	
