# Some workarounds to older browsers that do not natively support like IE............
#
#

# defineProperty = (if definePropertyWorks() then Object.defineProperty else (obj, prop, descriptor) ->
# 	obj[prop] = descriptor.value
# 	return
# )
# definePropertyWorks = ->
# try
# 	return "xx" of Object.defineProperty({}, "xx", {})
# return

get = (p_scope, p_props) ->
  # console.log(Debug)
  # console.log(Debug.checkBrowser('IE 9'))
  if Debug.checkBrowser('IE 9') >= 0
    for name, getter of p_props
      Object.defineProperty p_scope::, name, get: getter, configurable: true, enumerable: true
  null
set = (p_scope, p_props) ->
  if Debug.checkBrowser('IE 9') >= 0
    for name, setter of p_props
      Object.defineProperty p_scope::, name, set: setter, configurable: true, enumerable: true
  null

unless Object.defineProperty
  Object.defineProperties = (obj, properties) ->
    convertToDescriptor = (desc) ->
      hasProperty = (obj, prop) ->
        Object::hasOwnProperty.call obj, prop
      isCallable = (v) ->
        
        # NB: modify as necessary if other values than functions are callable.
        typeof v is "function"
      throw new TypeError("bad desc")  if typeof desc isnt "object" or desc is null
      d = {}
      d.enumerable = !!obj.enumerable  if hasProperty(desc, "enumerable")
      d.configurable = !!obj.configurable  if hasProperty(desc, "configurable")
      d.value = obj.value  if hasProperty(desc, "value")
      d.writable = !!desc.writable  if hasProperty(desc, "writable")
      if hasProperty(desc, "get")
        g = desc.get
        throw new TypeError("bad get")  if not isCallable(g) and g isnt "undefined"
        d.get = g
      if hasProperty(desc, "set")
        s = desc.set
        throw new TypeError("bad set")  if not isCallable(s) and s isnt "undefined"
        d.set = s
      throw new TypeError("identity-confused descriptor")  if ("get" of d or "set" of d) and ("value" of d or "writable" of d)
      d
    throw new TypeError("bad obj")  if typeof obj isnt "object" or obj is null
    properties = Object(properties)
    keys = Object.keys(properties)
    descs = []
    i = 0

    while i < keys.length
      descs.push [
        keys[i]
        convertToDescriptor(properties[keys[i]])
      ]
      i++
    i = 0

    while i < descs.length
      Object.defineProperty obj, descs[i][0], descs[i][1]
      i++
    obj

Object.keys = Object.keys || (p_obj)->
	result = []
	for name of p_obj
		if p_obj.hasOwnProperty(name)
			result.push name
	return result

# Add ECMA262-5 method binding if not supported natively
#
unless "bind" of Function::
	Function::bind = (owner) ->
		that = this
		if arguments.length <= 1
			->
				that.apply owner, arguments
		else
			args = Array::slice.call(arguments, 1)
			->
				that.apply owner, (if arguments.length is 0 then args else args.concat(Array::slice.call(arguments)))

# Add ECMA262-5 string trim if not supported natively
#
unless "trim" of String::
	String::trim = ->
		@replace(/^\s+/, "").replace /\s+$/, ""

# Add ECMA262-5 Array methods if not supported natively
#
unless "indexOf" of Array::
	Array::indexOf = (find, i) -> #opt
		i = 0  if i is `undefined`
		i += @length  if i < 0
		i = 0  if i < 0
		n = @length

		while i < n
			return i  if i of this and this[i] is find
			i++
		-1
unless "lastIndexOf" of Array::
	Array::lastIndexOf = (find, i) -> #opt
		i = @length - 1  if i is `undefined`
		i += @length  if i < 0
		i = @length - 1  if i > @length - 1
		i++ # i++ because from-argument is sadly inclusive
		while i-- > 0
			return i  if i of this and this[i] is find
		-1
unless "forEach" of Array::
	Array::forEach = (action, that) -> #opt
		i = 0
		n = @length

		while i < n
			action.call that, this[i], i, this  if i of this
			i++
unless "map" of Array::
	Array::map = (mapper, that) -> #opt
		other = new Array(@length)
		i = 0
		n = @length

		while i < n
			other[i] = mapper.call(that, this[i], i, this)  if i of this
			i++
		other
unless "filter" of Array::
	Array::filter = (filter, that) -> #opt
		other = []
		v = undefined
		i = 0
		n = @length

		while i < n
			other.push v  if i of this and filter.call(that, v = this[i], i, this)
			i++
		other
unless "every" of Array::
	Array::every = (tester, that) -> #opt
		i = 0
		n = @length

		while i < n
			return false  if i of this and not tester.call(that, this[i], i, this)
			i++
		true
unless "some" of Array::
	Array::some = (tester, that) -> #opt
		i = 0
		n = @length

		while i < n
			return true  if i of this and tester.call(that, this[i], i, this)
			i++
		false

has3d = ->
	el = document.createElement("p")
	has3d = undefined
	transforms =
		webkitTransform: "-webkit-transform"
		OTransform: "-o-transform"
		msTransform: "-ms-transform"
		MozTransform: "-moz-transform"
		transform: "transform"
	document.body.appendChild el
	for t of transforms
		if el.style[t] isnt `undefined`
			el.style[t] = "translate3d(1px,1px,1px)"
			has3d = window.getComputedStyle(el).getPropertyValue(transforms[t])
	document.body.removeChild el
	has3d isnt `undefined` and has3d.length > 0 and has3d isnt "none"

