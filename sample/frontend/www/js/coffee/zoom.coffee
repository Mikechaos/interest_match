$ ->
	$('#settings_selection').on 'change', (e) ->
		$('#'+$(this).val()).focus()
	$('#radius_selection').on 'change', (e) ->
		app.zoom.update $(this).val();
app.zoom = 
	update: (level) ->
		app.socket.push 'update',
			radius:level