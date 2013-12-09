class InterestMatch.Views.InterestsCreate extends Backbone.View
	template: JST['interests/create']
	events:
		"click #createButton": "createInterest"
		"click #mainView": "showMainView"
		"click #interestsView": "showMyInterestsView"
	initialize: ->

	render: ->
		@$el.html @template()
		@


	formElem: ['#interest_name', '#interest_description', '#interest_lat', '#interest_lon']
	createInterest: ->
		@model.set 'name', @$('#interest_name').val()
		@model.set 'description', @$('#interest_description').val()
		@model.set 'lat', InterestMatch.currentUser.get('lat')
		@model.set 'lon', InterestMatch.currentUser.get('lon')
		@model.save null,
			success: => @proceedForm()
			error: => @proceedForm()

	proceedForm: ->
		@cleanForm()
		InterestMatch.showMyInterestsView()

	cleanForm: ->
		_.each @formElem, (elem) =>
			console.log @$(elem)
			@$(elem).val('')

	showMainView: ->
		InterestMatch.showMainView()

	showMyInterestsView: ->
		InterestMatch.showMyInterestsView()
