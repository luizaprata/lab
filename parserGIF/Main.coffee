#@codekit-prepend ParserGIF.coffee
#@codekit-prepend EventDispatcher.coffee

class Main extends EventDispatcher

	constructor:()->
		$('<img src="'+ 's3Shantae_Goddess_caught.gif' +'">').load((e) =>
			image = e.target

			@_drawImage(image)
			# $(this).width(some).height(some).appendTo('#some_target');
		)
		
		
	_drawImage:(image)->
		console.log image
		@_drawCanvas = document.createElement('canvas')
		@_drawCanvas.width = 100
		@_drawCanvas.height = 100
		@_drawContext = @_drawCanvas.getContext('2d')

		@_drawCanvas.style.position = 'absolute'
		document.body.appendChild(@_drawCanvas)

		@_drawCanvas.width = @contentWidth = image.width
		@_drawCanvas.height = @contentHeight = image.height
		# @_drawContext.drawImage(image, 0, 0)

	

init = ()->
	main = new Main()

$(window).ready(init)