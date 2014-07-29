class EventDispatcher
	on:(evt, handler)->
		if !@_events
			@_events = {}
		if !@_events[evt]
			@_events[evt] = []
		if !(handler in @_events[evt])
			@_events[evt].unshift(handler)
	off:(evt = null, handler = null)->
		if !@_events
			@_events = {}
		if !evt
			@_events = {}
			return
		if events = @_events[evt]
			if !handler
				@_events[evt].length = 0
			else
				while (i = events.indexOf(handler)) >= 0
					events.splice(i, 1)
				@_events[evt] = events
	trigger:(evt, data = null)=>
		if !@_events
			@_events = {}
		events = @_events[evt]
		if !events || events.length == 0
			return
		e = {type: evt, target: @, currentTarget: @}
		if typeof(data) == 'object'
			for k, v of data
				if !e[k]
					e[k] = v
		i = events.length
		while i-- > 0
			events[i]?(e, data)
class EventUtils
	@init:()->
		if document.addEventListener
			@_eventAdder = @_addEventListener
			@_eventRemover = @_removeEventListener
		else if document.attachEvent
			@_eventAdder = @_attachEvent
			@_eventRemover = @_detachEvent
		else
			@_eventAdder = @_callbackFunction
			@_eventRemover = @_removeCallbackFunction
	@on:(target, eventName, callback)->
		@_eventAdder(target, eventName, callback)
	@_addEventListener:(target, eventName, callback)->
		target.addEventListener(eventName, callback, false)
	@_attachEvent:(target, eventName, callback)->
		target.attachEvent('on' + eventName, callback)
	@_callbackFunction:(target, eventName, callback)->
		target['on' + eventName] = callback

	@off:(target, eventName, callback)->
		@_eventRemover(target, eventName, callback)
	@_removeEventListener:(target, eventName, callback)->
		target.removeEventListener(eventName, callback, false)
	@_detachEvent:(target, eventName, callback)->
		target.detachEvent('on' + eventName, callback)
	@_removeCallbackFunction:(target, eventName, callback)->
		if target['on' + eventName] == callback
			target['on' + eventName] = null

EventUtils.init()

### --------------------------------------------
     Begin Main.coffee
-------------------------------------------- ###

#@codekit-prepend EventDispatcher.coffee

class Main extends EventDispatcher
	constructor:()->

		$.ajax({
			url : "oldDuke.txt",
			success : @onLoadText
		})

		@output = $('.output')

		$("input[name='btn1']").click(@btn1Click)
		$("input[name='btn2']").click(@btn2Click)
		return false
			
	onLoadText:(data)=>
		@oldDukePhrases = data.split("\n")

	# 1 - Literal Characters ############################
	# BASIC SEARCH - /abc/
	# case-sensitive - /abc/
	# case-insensitive - /abc/i
	btn1Click:(e)=>
		txt = ''
		for phrase in @oldDukePhrases
			searchUP = phrase.search(/up/)
			if (searchUP>-1)
				txt += 'UP: ' + phrase + '<br/>'
			searchDown = phrase.search(/down/i)
			if (searchDown>-1)
				txt += 'DOWN: ' + phrase + '<br/>'
		@addText(txt)


	# 2 Standard (non-global) matching ################
	# Earliest (leftmost) match is always prefered
	# /zz/ mactches the first set of z's in pizzazz
	# Global matching
	# /zz/g All matches the both sets od z's in pizzazz
	btn2Click:(e)=>
		txt = ''
		for phrase,i in @oldDukePhrases
			txt += i, phrase.replace(/a/g, '<b>a</b>') + '<br/>' 
		@addText(txt)







	
	###################################################
	addText:(newText)->
		@output.empty()
		@output.append(newText)




	# MODES ###########################################
	# Standard: 		/re/
	# GLOBAL: 			/re/g
	# Case-insensitive:	/re/i
	# Multiline:		/re/m
	# Dot-matches-all:	/re/s 
	# 
	# MODES it's a modifier for the way that this 
	# regular expression ought to be handled. 
	###################################################



init = ()->
	main = new Main()


$(window).ready(init)