class InterestMatch.Models.Interest extends Backbone.Model
	urlRoot : 'http://ec2-54-200-102-151.us-west-2.compute.amazonaws.com:3000/interests'
	defaults:
		name: ""
		description: ""
		lat: 0
		lon: 0
		user: 0

	initialize: ->
