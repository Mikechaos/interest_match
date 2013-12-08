class InterestMatch.Views.InterestsIndex extends Backbone.View

	template: JST['interests/index']

	events: 
		"click .interest_field": "showDesc"
	intialize: ->
	
	render: ->
		i = 0
		@$el.html @template()
		_.each @collection, (interest) =>
			++i
			interest.setUser()
			return if interest.user is InterestMatch.currentUser
			distance = InterestMatch.helpers.calculateDistance(InterestMatch.currentUser.get('lat'), InterestMatch.currentUser.get('lon'), interest.get('lat'), interest.get('lon'))
			@$('tbody').append "<tr id='interest#{interest.id}' class='interest_field'>" +
          "<td>#{interest.user.get('first_name')}</td>" +
          "<td>#{interest.get('name')}</td>" +
          "<td>#{Math.round((distance / 5280) * 100) / 100} miles</td>" +
        "</tr><tr style='background-color: rgb(75, 75, 75); display:none;' class='desc' id='interest#{interest.id}'><td>#{interest.get('description')}</td></tr>"
		@$('#matchCount').html(i)
		@
		
	
	showDesc: (e) ->
		@$('tr.desc#' + e.currentTarget.id).slideDown()
