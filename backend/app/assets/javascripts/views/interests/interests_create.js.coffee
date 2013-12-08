class InterestMatch.Views.InterestsCreate extends Backbone.View
	template: JST['interests/create']
	events:
		"click button": "createInterest"

	initialize: ->

	render: ->
		@$el.html @template()
		@

	createInterest: ->
		@model.set 'name', @$('#interest_name').val()
		@model.set 'description', @$('#interest_description').val()
		# console.log @$('#interest_description').val()
		# console.log @model
		@model.save()
