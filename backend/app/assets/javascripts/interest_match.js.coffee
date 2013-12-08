window.InterestMatch =
	Models: {}
	Collections: {}
	Views: {}
	Routers: {}

	initialize: ->
		@fetchElements()
		@createInterestView()

	setCurrentUser: (id = 100) ->
		InterestMatch.userInitialized.then =>
			@currentUser = @users.findWhere id: id

	showCurrentView: ->
		@currentView.render()
		@currentView.$el.show()
		$('#create_interest').html(@currentView.el)
	closeCurrentView: ->
		# @currentView.close()
	showMyInterestsView: ->
		@closeCurrentView()
		@currentView = new InterestMatch.Views.MyInterests collection: @interests.filterByUserId(InterestMatch.currentUser.id)
		@showCurrentView()
	showMainView: ->
		@closeCurrentView()
		@currentView = new InterestMatch.Views.InterestsIndex collection: @interests.filterByRadius(15*5280)
		@showCurrentView()
	createInterestView: ->
		@currentView = new InterestMatch.Views.InterestsCreate model: new InterestMatch.Models.Interest
		@showCurrentView()

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
