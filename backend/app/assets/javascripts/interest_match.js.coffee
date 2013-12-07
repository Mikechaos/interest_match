window.InterestMatch =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}

	initialize: ->
		@fetchUsers()
		@fetchInterests()

	fetchUsers: ->
		@users = new InterestMatch.Collections.Users
		@users.fetch()
		console.log @users

	fetchInterests: ->
		@interests = new InterestMatch.Collections.Interests
		@interests.fetch()
		console.log @interests

$(document).ready ->
	InterestMatch.initialize()
