class InterestMatch.Models.User extends Backbone.Model
	urlRoot : 'http://ec2-54-200-102-151.us-west-2.compute.amazonaws.com:3000/users'
	defaults:
		phone: null
		skype: null
		birthday: null
		gender: null
		lon: null
		lat: null

	initialize: ->
