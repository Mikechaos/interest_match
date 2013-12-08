class InterestMatch.Collections.Users extends Backbone.Collection
	url: "http://ec2-54-200-102-151.us-west-2.compute.amazonaws.com:3000/users.json"
	model: InterestMatch.Models.User

	retrieveUser: (id) ->
		@findWhere id: id
