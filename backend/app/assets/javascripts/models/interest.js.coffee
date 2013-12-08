class InterestMatch.Models.Interest extends Backbone.Model
	urlRoot : '/interests'
	defaults:
		name: ""
		description: ""
		lat: 0
		lon: 0
		user: 0

	initialize: ->
