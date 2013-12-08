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
		@model.set 'lat', @$('#interest_lat').val()
		@model.set 'lon', @$('#interest_lon').val()
		@model.save()


	cleanForm: ->
		
