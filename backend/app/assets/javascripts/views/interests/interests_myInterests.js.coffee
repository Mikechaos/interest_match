class InterestMatch.Views.MyInterests extends Backbone.View
	template: JST['interests/myInterests']
	events:
		"click #mainView": "showMainView"

	initialize: ->
			console.log 'testestest', @collection, arguments

	render: ->
		@$el.html @template()
		_.each @collection, (interest) =>
			@$('.list-group').append '<a href="#" class="list-group-item">' + interest.get('name') +
	      '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
		    '</a>'

		@

	showMainView: ->
		InterestMatch.showMainView()
