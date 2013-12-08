class InterestMatch.Views.InterestsCreate extends Backbone.View
	template: JST['interests/create']
	events:
		"click #createButton": "createInterest"

	initialize: ->

	render: ->
		@$el.html @template()
		@


	formElem: ['#interest_name', '#interest_description', '#interest_lat', '#interest_lon']
	createInterest: ->
		@model.set 'name', @$('#interest_name').val()
		@model.set 'description', @$('#interest_description').val()
		@model.set 'lat', InterestMatch.currentUsers.get('lat')
		@model.set 'lon', InterestMatch.currentUsers.get('lon')
		@model.save()

	cleanForm: ->
		
