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