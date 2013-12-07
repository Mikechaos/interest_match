AppController = Backbone.Router.extend
	routes:
		#"":"homepage"
		"user":"user"
		"message":"message"
		"bid":"bid"
		'*actions':'default'

	showPage: (key) ->
		$('.page').hide 0
		$("#content-#{key}").show 0
		$('footer [data-item-uid]').removeClass 'active'
		$("footer [data-item-uid=#{key}]").addClass 'active'
		klass = $('body').attr 'data-loaded-class'
		$('body').removeClass 'page-'+klass
		$('body').attr 'data-loaded-class', key
		$('body').addClass 'page-'+key
		app.analytics.event 'page/'+key
		if key == 'home'
			$('input.username').focus()




app.controller = new AppController


app.controller.on 'route:default', (action) ->
	if not app.user.authenticate
		app.controller.showPage 'home'
	else
		app.controller.showPage 'message'

app.controller.on 'route:user', (action) ->
	if app.user.authenticate
		app.controller.showPage 'user'
	else
		app.controller.showPage 'home'

app.controller.on 'route:message', (action) ->
	if app.user.authenticate
		app.controller.showPage 'message'
	else
		app.controller.showPage 'home'

app.controller.on 'route:bid', (action) ->
	if app.user.authenticate
		app.controller.showPage 'bid'
	else
		app.controller.showPage 'home'




