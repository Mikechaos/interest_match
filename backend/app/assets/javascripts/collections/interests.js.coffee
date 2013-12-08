class InterestMatch.Collections.Interests extends Backbone.Collection
	url: 'http://ec2-54-200-102-151.us-west-2.compute.amazonaws.com:3000/interests.json'
	model: InterestMatch.Models.Interest

	filterByUserId: (userId) ->
		@where user_id: userId

	filterByGender: (gender) ->
		@filter (interest) ->
			interest.user.get('gender') is gender
	filterByAge: (minAge, maxAge) ->
		@filter (interest) ->
			(age = interest.user.get('age')) >= minAge or age <= maxAge or not age?

	filterByRadius: (radius) ->
		currentLat = InterestMatch.currentUser.lat
		currentLon = InterestMatch.currentUser.lon
		distanceFromCurrent = InterestMatch.helpers.calculateDistance.bind null, currentLat, currentLon
		@filter (interest) ->
			distanceFromCurrent(interest.get('lat'), interest.get('lon')) <= radius

	filterByKeyword: (keywords) ->
		list = []
		_.each keywords, (keyword) =>
			reg = new RegExp '.*#{keyword}.*', 'ig'
			list = list.concat @filter (interest) ->
				interest.get('name').search(keyword) isnt -1 or interest.get('description').search(keyword) isnt -1
		list

