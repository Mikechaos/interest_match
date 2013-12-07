$ ->
	$('input.username').keyup (e) ->
		key = (e.keyCode || e.which)
		console.log key
		if key == 13
			loginUser()
	$('.btn.join').click (e) ->
		loginUser()

	loginUser = ->
		val = $('input.username').val()
		val = val.replace(/^\s+|\s+$/g, '')
		$('.alert').hide 0
		
		if val
			$('input.username').attr 'disabled', 'disabled'
			app.ready val
		else
			$('.alert.empty').slideDown 500
				

app.user = 
	count: 0
	selector:
		user_list:null
	init: ->
		@selector.user_list = $ 'ul.user-list'
		app.on 'subscribers-list', app.user.add
		@
	add: (data) ->
		obj = app.user
		$('.user.count').text data.list.length
		raff_hack = $ 'ul.user-list'
		raff_hack.html ''
		raff_hack.append "<li>#{username}</li>" for username in data.list



