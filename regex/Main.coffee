#@codekit-prepend EventDispatcher.coffee

class Main extends EventDispatcher
	constructor:()->

		$.ajax({
			url : "oldDuke.txt",
			success : @onLoadText
		})

		$.ajax({
			url : "html.txt",
			success : @onLoadHtml
		})

		$.ajax({
			url : "USPresident.csv",
			success : @onLoadCSV
		})

		$.ajax({
			url : "nameslist.txt",
			success : @onLoadNames
		})

		@output = $('.output')

		@layout = $('.layout')

		for item,i in indice
			if (item != "")
				inputButton = $("<input type='button' value='"+item+"' name='"+i+"'></input>")
				inputButton.click(@clickItemButton)
				@layout.append(inputButton)
		
		return false
			
	clickItemButton:(e)=>
		switch parseInt(e.target.name)
			when 1
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
				# /zz/ matches the first set of z's in pizzazz
				# Global matching
				# /zz/g All matches the both sets od z's in pizzazz
				txt = ''
				oldDukePhrases = @oldDuke.split("\n")
				for phrase in oldDukePhrases
					searchUP = phrase.search(/up/)
					if (searchUP>-1)
						txt += 'UP: ' + phrase + '<br/>'
					searchDown = phrase.search(/down/i)
					if (searchDown>-1)
						txt += 'DOWN: ' + phrase + '<br/>'
				@addText(txt)
			when 2
				# 2 Wildcard Metacharacter ########################
				#  . » Matches any one character except newline
				# Original Unix regex tools were line-based
				# /h.t/ matches "hat", "hot", and "hit", but not "heat"
				# /9.00/ matches "9.00", "9500", "9-00", ...
				# Card game: The 2 card matches with anything
				txt = '/.a./gi' + '<br/>'
				re = /(.a.)/g
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)
			when 3
				# 3 Escaping Metacharacters #######################
				#  \ » Escape the next character
				# Match a period with \.
				# /9\.00/ matches "9.00", but not "9500" or "9-00"
				# Only for metacharacters 
				#   Literal characters should never be escaped, gives them meaning
				# Quotation marks are not metacharacters, do not need to be escaped
				# /txt\/test\/file.txt/g 
				txt = '/.\\./gi' + '<br/>'
				re = /(\.)/gi
				txt = @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)
				# Other special characters ##########################
				# Spaces
				# Tabs (\t) » /a\tb/ matches "a 	b"
				# Line returns (\r, \n, \r\n) depends where the file is: win, mac or unix
				# bell(\a), escape(\e), form feed (\f), vertical tab (\v)
				# ASCII or ANSI codes
				#    Codes that control appearance of a text terminal
				#    0xA9 = \xA9
			when 4
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
				txt = '/w[aeiou]/gi' + '<br/>'
				re = /(w[aeiou])/gi
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)
			when 5
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
				txt = '/[0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9]-[0-9][0-9]/g' + '<br/>'
				re = /([0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9]-[0-9][0-9])/g
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)
			when 6
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
				txt = '/[^a-zA-Z]/g' + '<br/>'
				re = /([^a-zA-Z])/g
				txt += @oldDuke.replace(re, "<b>$1</b>")
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
				#   Correct: [[:alpha:]] or [^[:alpha:]]
				#   Good ideia not to mix POSIX sets and shorthand sets
				#   Support: Perl, PHP, Ruby, Unix
				#   Not Supported: Java, Javascript, .NET, Python
			when 7
				# 7 REPETITION METACHARACTERS ########################
				#  *  » Preceding item zero or more times
				# Examples:
				#    /apples*/ matches "apple", "apples", and "applesssssssss"
				#    /\d\d\d\d*/ matches numbers with 3 digits or more
				txt = '/\\d*/g' + '<br/>'
				re = /(\d*)/g
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)
				
			when 8
				# 8 REPETITION METACHARACTERS ########################
				#  +  » Preceding item one or more times
				# Examples:
				#	 /apples+/ matches "apples", and "applesssssssss", but not "apple"
				#    /\d\d\d+/ matches numbers with 3 digits or more
				txt = '/\\d\\d\\d\\d+/g' + '<br/>'
				re = /(\d\d\d\d+)/g
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)	
			when 9
				# 9 REPETITION METACHARACTERS ########################
				#  ?  » Preceding item zero or one time
				# Examples:
				#	 /apples?/ matches "apple", "apples", but not "applesssssssss"
				#    /colou?r/ matches "color" and "colour"
				txt = '/they?/g' + '<br/>'
				re = /(they?)/g
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)

				# Examples 
				# [a-z]+\d[a-z]*   »  [one or more letter][one number][zero or more letter]
				#     matches abc9, a4dadgsdf, etc 
				#     not matches 9asd, asdf88vcvc, abc, etc
			when 10
				# 10 QUANTIFIED REPETITION ########################
				#  {  » Start quantified repetition on preceding item
				#  }  » End quantified repetition or preceding item
				# Syntax:
				#	 {min,max}
				#	    min and max are positive numbers
				#	 	min must always be included, can be zero
				#	    max is optional(and comma is also optional as well)
				# Examples:
				#	 /\d{4,8}/ matches numbers with 4 to 8 digits
				#	 /\d{4}/ matches numbers with exactly four digits (min is max)
				#	 /\d{4,}/ matches numbers with four or more digits(max is infinite)
				#	 /\d{0,}/ is the same as \d*
				#	 /\d {1,}/ is the same as \d+
				#	 /\d{5}-\d{4}/ matches 99797-9797
				#	 /A{1,2} bounds/ matches "A bounds" and "AA bounds", not "AAA bounds"
				txt = '/the\\w{0,3}/g' + '<br/>'
				re = /(the\w{0,3})/g
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)
			when 11
				# 11  LAZY EXPRESSIONS ########################
				#  ?  » Make preceding quantifier lazy
				# Syntax:
				#     *?
				#     +?
				#     {min,max}?
				#     ??
				# Intructs quantifier to use a "lazy strategy" for making choices
				# Greedy strategy
				#     Match as much as possible before giving control to the next expression part
				# Lazy strategy
				#     Match as little as possible before giving control to the next expression part
				#     Still defers to overall match, as greedy strategy
				#     Not necessarily faster or slower
				# Examples
				#     /\w*?\d{3}/
				#     /[A-Za-z-]+?\./
				#     /.{4,8}?_.{4,8}
				#     /apples??/ <- greedy: apples apples, lazy: ok just apple
				# Careful
				#     If all expressions were lazy. It will match nothing
				txt = '/\\sthe\\w+?/g' + '<br/>'
				re = /(\bthe\w+?)/g
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)
				# Efficiency when using repetition
				# Efficient matching + less backtracking = speed results
				#   /.+/ is faster than /.*/
				#   /.{5}/ and /.{3,7}/ are even faster 
				# Narrow the scope of the repeated expression
				#   /.+/ can become /[]+/ acentuacao À-ú
				# Provide clearer start and ending points
				#   /<.+>/ can become /<[^>]+>/ looking for html tags - procure por tudo que tenha <> mas que nao tenha >
				#   Use anchors and word boundaries \b
				# Examples:
				#   /\w*s/ would be improved as /\w+s/
				#   /\w+s/ would be improved as /[A-Za-zÀ-ú]+s/
				#   If I know that start with uppercase and then lowercase : /[A-Z][a-z]+s/
				# Search for whole words only
				#   Spaces, anchors, or word boundaries 
			when 12
				# 12  Grouping Metacharecters ########################
				#  (  » Start grouped expression 
				#  )  » End grouped expression
				# Group portions of the expression
				#     Apply repetition operators to a group
				#     Makes expressions easier to read
				#     Captures group for use on matching and replacing
				#     Cannot be used inside character set 
				# Examples
				#     /(abc)+/ matches "abc" and "abcabcabc"
				#     /(in)?dependent/ matches "independent" and "dependent"
				#     /runs(s)?/ is the same as /runs?/
				# Caution
				#     /(A?)B/ matches "B" and captures ""
				#        Element is optional, group/capture is not optional
				#     /(A)?B/ matches "B" and does not capture anything
				#        Element is not optional, group/capture is optional
				txt = '/\\b(the)\\w/gi' + '<br/>'
				re = /(\b(the)\w)/ig
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)
			when 13
				# 13 Alteration Metacharacter
				#  |  » Match previous or next expression 
				# | is an OR operator
				#    Either match expression on the left or match expression on the right
				#    Ordered, leftmost expression gets precedence
				#    Multiple choices can be daisy-chained
				#    Group alternation expressions to keep them distinct
				# Examples
				#    /apple|orange/ matches "apple" and "orange"
				#    /abc|def|ghi|jkl/ matches "abc" "def" "ghi" and "jkl"
 				#    /apple(juice|sause)/ is not the same as /applejuice|sause/
				#    /w(ei|ie)rd/ matches "weird" and "wierd" > correct spelling
				# Caution
				#    Put the simplest (most efficiendt expression first)
				#       /\w+_\d{2,4}|\d{4}_\d{2}_\w+|export\d{2}/ takes a lot more backtracking then it inverted: /export\d{2}|\d{4}_\d{2}_\w+|\w+_\d{2,4}/
				#    Repeating
				#		Fist matched alteration does not effect the next matches
				#       /(AA|BB|CC){6}/ matches "AABBAACCBB"
				txt = '/\\b(the|whe)\\w/gi' + '<br/>'
				re = /(\b(the|whe)\w)/ig
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)
			when 14
				# 14 Start and end anchors
				#  ^   » Start of string/line 
				#  $   » End of string/line
				#         ^ and $ are supported in all regex engines
				#  OR
				#  \A  » Start of string, never endo of line
				#  \Z  » End of string, never end of line
				#         \A and \Z are supported in Java, .NET, Perl, PHP, Python, Ruby
				# They are similar, the only difference is about how it handles the difference between a string and a line
				# Reference a position, not an actual character
				#    Zero-width	
				# Examples:
				#    /^apple/ or /\Aapple/
				#    /apple$/ or ./\Aapple\Z/
				#    /^apple$/ or /\Aapple\Z/
				# m mode consider the multiline, not the default single line 
				txt = '^[A-Z].+\\.$/gm'  + '<br/>'
				re = /(^[A-Z].+\.$)/gm
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)
			when 15
				# 15 Word Boundaries
				#  \b   » Word boundary (start/end of word)
				#  \B   » Not a word boundary
				#  Reference a position, not an actual character
				#  Conditions for matching
				#     Before the first word character in the string
				#     After the last word character in the string
				#     Between a word character and a non-word character
				# Caution
				#    A space is not word boundary
				#    Word boundaries reference a position
				#       Not an actual character
				#       Zero-lenght
				#    Examples
				#       String: "apples and oranges"
				#       No-match: /apples\b\and\boranges
				#       Match:/apples\b \band\b \oranges/2 
				txt = '\\b\\w+e\\b/g'  + '<br/>'
				re = /(\b\w+e\b)/g
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)
			when 16
				# 16 Word Boundaries
				#  \1 through \9   » Backreference for position 1 to 9
				# Grouped expression are captured
				#    Stores the matches position in parentheses
				#       /a(p{2}l)e/ matches "apple" and stores "ppl"
				#       Stores the data matched, not the expression
				#    Automatically by default
				# Backreferences allow access to captured data
				#    Refer to first backreference with \1
				# Usage
				#    Can be used in the same expression as the group
				#    Can be accessed after the match is complete
				#    Cannot be used inside character classes
				# Example
				# 
				txt = '(were)[ \\w]+\\1/g'  + '<br/>'
				re = /((were)[ \w]+\2)/g
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)

			when 17
				# 17 html challenge //<(p|b)>.+?<\/\1>|<img.+\/>
				# <(polygon|circle)[\w\d\s="#\-., ]+?/>
				# <(circle|polygon)[^>]+>
				txt = '<(p|b)>.+?<\\/\\1>'  + '<br/>'
				re = /<(p|b)>.+?<\/\1>/g
				arr = @html.match(re)
				for node in arr
					txt += node
				@addText(txt)

			when 18
				# organize text
				re = /\s*,\s*/g
				txt = @usPresident.replace(re, ',')
				# change title
				re = /^.+$/m
				txt = txt.replace(re, 'Number,Last Name,First Name,Took office,Left office,Party,Home State')
				# remove links
				re = /http:\/\/[^,]+,?/g
				txt = txt.replace(re, '')
				# remove images
				re = /\w+\.(gif|jpg|png),?/g
				txt = txt.replace(re, '')
				# remove comments
				re = /\(.+\)/g
				txt = txt.replace(re, '')
				# change name order
				re = /^(\d{1,}),([\w .]+) ([\w]+),/gm
				txt = txt.replace(re, "$1,$3,$2,")
				# removedays months
				re = /\d{1,2}\//g
				txt = txt.replace(re, '')
				@addText(txt)
				#change title
				re = /^.+/

			when 19
				# 19 NON-CAPTURING GROUP EXPRESSIONS
				#  ?:   » Specify a non-caturing group
				# Syntax
				#    /(\w+)/ becomes /(?:\w+)/
				# Turns off captures ($1 to $9) and backreferences (\1 to \9)
				#    Optimize for speed
				#    Preserve space for more captures
				# /(?:regex)/
				#   ? = "Give this group a different meaning"
				#   : = "The meaning is non-capturing"
				txt = '(?:up)([\\w ])+\\1'  + '<br/>'
				re = /((?:up)([\w ])+\2)/g
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)

			when 20
				# 20 POSITIVE LOOKAHEAD ASSERTIONS
				#  ?=   » Positive lookahead assertions
				#  Zero-width - Does not include group in the match
				# Examples
				#   /(?=seashore)sea/ or /sea(?=shore)/ matches "sea" in  "seashore" but not "seaside"
				# 	^(?=.*\d)(?=.*[A-Z]).{8,15}$ 
				#      Verifica um password, precisa ter numero, letra maiuscula e tambem ter entre 8 a 15 caracteres 
				txt = '\\b[A-Za-z\'\\-]+\\b(?=\\.)\\g'  + '<br/>'
				re = /(\b[A-Za-z'\-]+\b(?=\.))/g
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)
			
			when 21
				# 21 NEGATIVE LOOKAHEAD ASSERTIONS
				#  ?!   » Negative lookahead assertions
				#  Zero-width - Does not include group in the match
				# Examples
				#   /(?!seashore)sea/ or sea(?!shore) matches "sea" in  "seaside" but not "seashore"
				# 	/online(?! training)/ does not match "online training" but would match "online courses" 
				# 	/online(?!.*training)/ does not match "online video training" 
				#   /(\bblack\b)(?!.*\1)/ returns the last occurrence of "black" in the text
				txt = '\\bdown\\b(?!\\.)'  + '<br/>'
				re = /(\bdown\b(?!\.))/gi
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)

			when 22
				# 22 UNICODE
				#  \u   » Unicode indicator followed by a four-digit hexadecimal number (0000-FFFFF that’s over 1.1 million possible symbols. )
				# Examples
				#    /caf\u00E9/ matches "café" but not "cafe"
				#    or /caf\u0065\u0301/ matches "café" but not "cafe"
				#    But its can result many issues because there are differentes types of encoding (UTF-8	or UTF-16)
				#    Basic Latin : Block from U+0000 to U+007F
				#    http://en.wikipedia.org/wiki/Plane_(Unicode)
				#    [\u0020\u0027\u002C\u002D\u0030-\u0039\u0041-\u005A\u005F\u0061-\u007A\u00A0-\u00FF./]
				#     \u0020 : SPACE
				#     \u0027 : APOSTROPHE
				#     \u002C : COMMA
				#     \u002D : HYPHEN / MINUS
				#     \u0030-\u0039\ : 0-9
				#     \u0041-\u005A : A - Z
				#     \u005F : UNDERSCORE
				#     \u0061-\u007A\ : a - z
				#     \u00C0-\u00FF : "À to ÿ"
				#     \u00A0-\u00FF : like above plus ©, ª, etc
				txt = '[\\u00C0-\\u00FF]\\g'  + '<br/>'
				re = /([\u00C0-\u00FF])/g
				txt += @oldDuke.replace(re, "<b>$1</b>")
				@addText(txt)

			when 23
				# check names : ^([A-Za-z\u00C0-\u00FF]+)( [A-Za-z\u00C0-\u00FF.']+)+$
				# Fist letter uppercase
				txt = ''
				re = /(^(?:[A-Za-z\u00C0-\u00FF-']+)(?: [A-Za-z\u00C0-\u00FF'-.]+)+$)/gm
				txt += @names.replace(re, @firtsUpperLetterCase)
				@addText(txt)

			when 24
				#zip code
				txt = ''
				re = /(^\d{5}-?\d{3}$)/gm
				txt += @oldDuke.replace(re, @firtsUpperLetterCase)
				@addText(txt)
			when 25
				#email
				txt = ''
				re = /(^[\w.%+\-]+@[\w.\-]+\.[A-Za-z]{2,6}$)/gm
				txt += @oldDuke.replace(re, @firtsUpperLetterCase)
				@addText(txt)
			when 26
				#url
				# http://www.example.com
				# http://example.com
				# http://blog.example.com
				# https://www.example.com
				# http://www.example.com/page.html
				# http://www.example.com/img/image.gif
				# http://www.example.com/page/
				# http://www.example.com/page/123
				# http://www.example.com/page.php?product=28
				# http://www.example.com?product=25&color=blue
				# http://www.example.com#details
				# ^https?:\/\/(?:[a-z\d]+\.?)+([A-Za-z\d\/\-,@+.!?=:#&%]+?)?$
				txt = ''
				re = /(^https?:\/\/(?:[a-z\d]+\.?)+([A-Za-z\d\/\-,@+.!?=:#&%]+?)?$)/gm
				txt += @oldDuke.replace(re, @firtsUpperLetterCase)
				@addText(txt)

	indice = [
		""
		"literal" 	#1
		"."			#2
		"\\"		#3
		"[]"		#4
		"-"			#5
		"^"			#6
		"*"			#7
		"+"			#8
		"?"			#9
		"{}"		#10
		"lazy"		#11
		"()"		#12
		"|"			#13
		"^ and $" 	#14
		"\\b\\B" 	#15
		"\\1" 		#16
		"html"	    #17
		"csv"	    #18
		"?:"	    #19
		"?="	    #20
		"?!"	    #21
		"unicode"   #22
		"names"     #23
		"cep"       #24
		"email"     #25
		"url"       #26
	]

	#code#######################
	firtsUpperLetterCase:(text)->
		text = text.toLowerCase()
		re = /(^[a-z\u00E0-\u00FC]| [a-z\u00E0-\u00FC])/gm
		text = text.replace(re, (firstLetter)->
			return firstLetter.toUpperCase()
		)
		# text = text.replace(/(\bDe\b)/g, 'de')
		# text = text.replace(/(\bDa\b)/g, 'da')
		# text = text.replace(/(\bDo\b)/g, 'do')
		text = text.replace(/('[a-z\u00C0-\u00FF]|-[a-z\u00C0-\u00FF])/g, (especial)->
			return especial.toUpperCase()
		)

		return text

	onLoadHtml:(data)=>
		@html = data

	onLoadText:(data)=>
		@oldDuke = data

	onLoadNames:(data)=>
		@names = data

	onLoadCSV:(data)=>
		@usPresident = data

	addText:(newText)->
		re = /(\n)/g
		txt = newText.replace(re, "$1<br/>")
		@output.empty()
		@output.append(txt)



init = ()->
	main = new Main()


$(window).ready(init)