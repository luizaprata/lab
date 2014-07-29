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
		$("input[name='btn3']").click(@btn3Click)
		return false
			
	onLoadText:(data)=>
		@oldDukePhrases = data.split("\n")

	# 1 - Literal Characters ############################
	# BASIC SEARCH - /abc/
	# case-sensitive - /abc/
	# case-insensitive - /abc/i
	# Standard (non-global) matching ################
	# Earliest (leftmost) match is always prefered
	# /zz/ mactches the first set of z's in pizzazz
	# Global matching
	# /zz/g All matches the both sets od z's in pizzazz

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


	# 2 Wildcard Metacharacter ########################
	#  . » Matches any one character except newline
	# Original Unix regex tools were line-based
	# /h.t/ matches "hat", "hot", and "hit", but not "heat"
	# /9.00/ matches "9.00", "9500", "9-00", ...
	# Card game: The 2 card matches with anything
	btn2Click:(e)=>
		txt = '/.a./gi' + '<br/>'
		for phrase,i in @oldDukePhrases
			txt += phrase.replace(new RegExp('(.a.)', 'gi'),'<b>$1</b>') + '<br/>'
		@addText(txt)

	# 3 Escaping Metacharacters #######################
	#  \ » Escape the next character
	# Match a period with \.
	# /9\.00/ matches "9.00", but not "9500" or "9-00"
	# Only for metacharacters 
	#   Literal characters should never be escaped, gives them meaning
	# Quotation marks are not metacharacters, do not need to be escaped
	# /txt\/test\/file.txt/g 
	btn3Click:(e)=>
		txt = '/.\\./gi' + '<br/>'
		for phrase,i in @oldDukePhrases
			txt += phrase.replace(new RegExp('(.\\.)', 'gi'),'<b>$1</b>') + '<br/>'
		@addText(txt)

	# Other special characters ##########################
	# Spaces
	# Tabs (\t) » /a\tb/ matches "a 	b"
	# Line returns (\r, \n, \r\n) depends where the file is: win, mac or unix
	# bell(\a), escape(\e), form feed (\f), vertical tab (\v)
	# ASCII or ANSI codes
	#    Codes that control appearance of a text terminal
	#    0xA9 = \xA9
	###################################################

	# Defining a character set ##########################
	# 
	# 
	# 
	# 
	# 
	# 
	# 

	
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

	# METACHARACTERS ###########################################
	# Characters with special meaning
	# -  Like mathematical operators
	# -  Transform literal characteres into powerful expressions
	# Metacharacters:
	# -  \ . * + - {} [] ^ $ | ? () : ! =
	# Can have more than one meaning
	# -  Depends on how it is used in context
	# Variations between regex engines
	############################################################



init = ()->
	main = new Main()


$(window).ready(init)