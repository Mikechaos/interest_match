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
		alert 'here'
		user = new InterestMatch.Models.User
		user.email = fbConnect.email
		user.name = fbConnect.name
		user.first_name = fbConnect.first_name
		user.last_name = fbConnect.last_name

		#birthday = new Date(fbConnect.birthday);
		#user.age = ~~((Date.now() - birthday) / (31557600000));

		#if fbConnect.gender
		#	user.gender = if fbConnect.gender is 'female' then 1 else 2;


		alert user.email

		user.save null,
			success: -> alert('coool')
			error: -> alert('not so coool!!')
		alert 1
		alert user
		InterestMatch.setCurrentUser(user.id)

	updateUserCoords: ->
		app.triggerGeoLocation()
