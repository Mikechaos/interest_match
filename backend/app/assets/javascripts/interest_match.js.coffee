window.InterestMatch =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}

	initialize: ->
		@bindEvents()
		@fetchUsers()
		@fetchInterests()
		@initializedGeo.then =>
			@createInterestView()

	createInterestView: ->
		@interestView = new InterestMatch.Views.InterestsCreate model: new InterestMatch.Models.Interest lon: @currentLon, lat: @currentLat
		@interestView.render()
		@interestView.$el.show()
		# console.log @interestView.el
		$('#create_interest').html(@interestView.el)

	bindEvents: ->
		@initializedGeo = $.Deferred();
		document.addEventListener('deviceready', @onDeviceReady, false)
		# @triggerNavigator()

	# usefull for testing on laptopg
	triggerNavigator: ->
		navigator.geolocation.getCurrentPosition(((position) => @onSuccess(position)), @onError, maximumAge: 0, timeout: 5000, enableHighAccuracy: true )

	fetchUsers: ->
		@users = new InterestMatch.Collections.Users
		@users.fetch success: => console.log @users

	fetchInterests: ->
		@interests = new InterestMatch.Collections.Interests
		@interests.fetch success: => console.log @interests
	   
	# Bind Event Listeners
	#
	# Bind any events that are required on startup. Common events are:
	# 'load', 'deviceready', 'offline', and 'online'.
	   
	# deviceready Event Handler
	#
	# The scope of 'this' is the event. In order to call the 'receivedEvent'
	# function, we must explicity call 'app.receivedEvent(...);'
	onDeviceReady: ->
		app.receivedEvent('deviceready')
		alert 'yes'
		navigator.geolocation.getCurrentPosition(@onSuccess, @onError, maximumAge: 0, timeout: 5000, enableHighAccuracy: true )

	onSuccess: (position) ->
		console.log position
		@currentLon = position.coords.longitude
		@currentLat = position.coords.latitude
		@initializedGeo.resolve[17~()
	onError: ->
		alert 'shit'

	# Update DOM on a Received Event
	receivedEvent: (id) ->
		parentElement = document.getElementById(id);
		listeningElement = parentElement.querySelector('.listening');
		receivedElement = parentElement.querySelector('.received');

		listeningElement.setAttribute('style', 'display:none;');
		receivedElement.setAttribute('style', 'display:block;');
	
		console.log('Received Event: ' + id);

$(document).ready ->
	InterestMatch.initialize()
