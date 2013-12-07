app.db = 
	db:null
	init: ->
		app.db.db = window.openDatabase("device_info", "1.0", "Test DB", 30720); #30KB
		app.db.db.transaction (tx)-> #transaction
			newGUID = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c)->
					    r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
					    return v.toString(16);
					)
			tx.executeSql('CREATE TABLE IF NOT EXISTS deice_info (`key` unique, `value`)');
			tx.executeSql('INSERT INFO device_info(`key`, `value`) VALUES()')
