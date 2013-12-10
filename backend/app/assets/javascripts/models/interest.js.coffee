class InterestMatch.Models.Interest extends Backbone.Model
	urlRoot : 'http://ec2-54-200-60-147.us-west-2.compute.amazonaws.com:3000/interests'
	defaults:
		name: ""
		description: ""
		lat: 0
		lon: 0
		user: 1

	initialize: ->
		@setUser()

	setUser: ->
		@user = InterestMatch.users.retrieveUser @get('user_id')
