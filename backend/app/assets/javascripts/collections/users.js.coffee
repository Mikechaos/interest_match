class InterestMatch.Collections.Users extends Backbone.Collection
	url: "http://ec2-54-200-102-151.us-west-2.compute.amazonaws.com:3000/users.json"
	model: InterestMatch.Models.User

	retrieveUser: (id) ->
		@findWhere id: id

	checkIfEmailExists: (email) ->
		if (user = @findWhere email: email)? then user else false

	fbConnectUser: (fbConnect) ->
		userExists = @checkIfEmailExists fbConnect.email
		if userExists
			InterestMatch.setCurrentUser(userExists.id)
		else
			@createFbConnect()
		@updateUserCoords()
	
	createFbConnect: (fbConnect) ->
		user = new InterestMatch.Models.User
		# do some setting up head
		user.save()
		InterestMatch.setCurrentUser(user.id)

	updateUserCoords: ->
		app.triggerGeoLocation()
