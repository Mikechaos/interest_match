$ ->
	$('input.message-creator').keyup (e) ->
		key = (e.keyCode || e.which)
		$this = $ this
		if key == 13
			val = $this.val()
			if val
				$this.val ''
				$this.focus()
				app.message.create val

	$('.message-list').on 'click', (e) ->
		$('.message-creator').val('@'+$('.username',$(this)).first().text()+': ')
		$('.message-creator').focus()

app.message = 
	count: 0
	selector:
		message_list:null 
	init: ->
		@selector.message_list = $ 'ul.message-list.regular'
		app.on 'message', app.message.add
	add: (data) ->
		obj = app.message
		obj.count++
		$('.message.count').text obj.count
		time = window.moment().format 'h:mm'
		obj.selector.message_list.prepend "<li><span class='message'>"+$('<div/>').text(data.message).html()+"</span><span class='time'>#{time}</span><br/><span class='username'>"+$('<div/>').text(data.username).html()+"</span></li>"
		$('input.message-creator').blur()
		window.scrollTo(0,0)

	create: (text) ->
		app.socket.push 'message',
			content:text
			type:'text'

