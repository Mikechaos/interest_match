window.InterestMatch =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}

	initialize: ->
		@fetchElements()
		@createInterestView()

	setCurrentUser: ->
		InterestMatch.userInitialized.then =>
			@currentUser = @users.findWhere id: 1
		
	createInterestView: ->
		@interestView = new InterestMatch.Views.InterestsCreate model: new InterestMatch.Models.Interest
		@interestView.render()
		@interestView.$el.show()
		$('#create_interest').html(@interestView.el)

	fetchElements: ->
		@fetchUsers()
		InterestMatch.userInitialized.then =>
			@setCurrentUser()
			@fetchInterests()
	fetchUsers: ->
		InterestMatch.userInitialized = $.Deferred();
		@users = new InterestMatch.Collections.Users
		@users.fetch success: => console.log @users; InterestMatch.userInitialized.resolve()

	fetchInterests: ->
		@interests = new InterestMatch.Collections.Interests
		@interests.fetch success: => console.log @interests

$(document).ready ->
	InterestMatch.initialize()
