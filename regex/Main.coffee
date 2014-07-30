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
		$("input[name='btn4']").click(@btn4Click)
		$("input[name='btn5']").click(@btn5Click)
		$("input[name='btn6']").click(@btn6Click)
		return false
			
	onLoadText:(data)=>
		@oldDukePhrases = data.split("\n")
	
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

	# 4 Defining a character set ##########################
	#  [  » Begin a character set
	#  ]  » End a character set
	# Any one of several characters
	#   But only one character
	#   Order of characters does not matter
	# Examples
	# /[aeiou]/ matches any one vowel
	# /gr[ea]y/ matches "grey" and "gray"
	# /gr[ea]t/ does not match "great" = has to either be an e or an a = just one character of what is inside []
	btn4Click:(e)=>
		txt = '/w[aeiou]/gi' + '<br/>'
		for phrase,i in @oldDukePhrases
			txt += phrase.replace(new RegExp('(w[aeiou])', 'gi'),'<b>$1</b>') + '<br/>'
		@addText(txt)

	# 5 Character Ranges ##########################
	#  -  » range of characters
	# Represents all characters between two charactes
	# Only a metacharacter inside a character set, a literal dash otherwise
	# Examples
	#   [0-9]
	#   [a-zA-Z]
	#   [a-ek-ou-y]
	#   Caution 
	#      [52-99] is NOT all numbers from 52 to 99, it is the same as [2-9]
	btn5Click:(e)=>
		txt = '/[0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9]-[0-9][0-9]/g' + '<br/>'
		for phrase,i in @oldDukePhrases
			txt += phrase.replace(new RegExp('([0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9]-[0-9][0-9])', 'g'),'<b>$1</b>') + '<br/>'
		@addText(txt)
	
	# 6 Negative Character Sets ##################
	#  ^  » negate a character set
	# Not any one of several character set
	#   Add ^ as the first character inside a character set
	#   Still represents one character
	# Examples
	#   /[^aeiou]/ matches any one consonant (non-vowel)
	#   /see[^mn]/ matches "seek" and "sees" but not "seem" or "seen"
	# Caution
	#	/see[^mn]/ maatches "see " but not "see"
	btn6Click:(e)=>
		txt = '/([^a-zA-Z]/g' + '<br/>'
		for phrase,i in @oldDukePhrases
			txt += phrase.replace(new RegExp('([^a-zA-Z])', 'g'),'<b>$1</b>') + '<br/>'
		@addText(txt)


	# Metacharacters inside character sets
	# Metacharacters inside character sets are already escaped
	#   Do not need to escape them again
	#   /h[abc.xyz]t/ matches "hat" and "h.t", but not "hot"(dot is inside the character sets, so it is a literal dot but not a wildcard)
	# Exceptions:
	#   ] - ^ \  » DO need to escape them
	# Examples:
	#   /file[0\-\\_]1/g matches "file01", "file-1", "file\1", "file_1" 
	#   /var[[(][0-9][)\]]/g matches "var(3)", "var[4]"
	

	# Shorthand characters sets
	# \d  » digits  			» [0-9]
	# \w  » word character  	» [a-zA-Z0-9_]
	# \s  » whitespace  		» [ \t\r\n]
	# \D  » Not digit  			» [^0-9]
	# \W  » Not word character 	» [^a-zA-Z0-9_]
	# \S  » Not whitespace 		» [^ \t\r\n]
	# Caution
	#   \w
	#     Underscore is a word character
	#     Hyphen is not a word character, it is considered a ponctuation
	# Examples
	# /\d\d\d\d/ matches "1984" but not "text"
	# /\w\w\w/ matches "ABC", "123", and "1_A"
	# /\w\s\w\w/ matches "I am", but not "Am I"
	# /[\w\-]/ matches as word character or hyphen (useful)
	# /[\d\s]/ matches any digit or whitespace character
	# /[^\d]/ is the same as /\D/ and /[^0-9]/
	# Caution
	#    /[^\d\s]/ is not the same as [\D\S] 
	#		/[^\d\s]/ » its is saying NOT digit OR space character
	#		/[\D\S]/ » EITHER NOT digit OR NOT space charactera
	#           1234 456 789 all match with [\D\S] because "1" its not a space and " " its not a number » if (number OR space)
	# Shorthand its originated with perl, all moder regex engines supports it but not in many unix tools
	
	# POSIX Bracket Expressions
	# [:alpha:]		» Alphabetic Characters 			» A-Za-z
	# [:digit:]		» Numeric Characters 				» 0-9
	# [:alnum:]		» Alphanumeric character 			» A-Za-z0-9
	# [:lower:]		» Lowercase alphabetic character 	» a-z
	# [:upper:]		» Uppercase alphabetic character 	» A-Z
	# [:pundt:]		» Punctuation characters 			»
	# [:space:]		» Space characters 					» \s
	# [:blank:]		» Blank characters (space, tab)		»
	# [:print:]		» Printable characters, no spaces
	# [:cntrl:]		» control characters(non-printable)	»
	# [:xdigit:]	» Hexadecimal characteres 			» A-Fa-f0-9  
	# Use inside a character class, not standalone
	#   Corre
	# 
	# 
	# 
	# 
	# 



	#code#######################
	addText:(newText)->
			@output.empty()
			@output.append(newText)

init = ()->
	main = new Main()


$(window).ready(init)