#@codekit-prepend Debug.coffee
#@codekit-prepend EventDispatcher.coffee
#@codekit-prepend Workarounds.coffee

class Main extends EventDispatcher
	canvas:null
	stage:null
	canvasContext:null
	update:false
	items:null
	frameCount:0
	container:null
	image:null

	constructor:()->
		@canvas = $('.sketch')[0]
		@canvas.width = window.innerWidth
		@canvas.height = window.innerHeight

		@stage = new createjs.Stage(@canvas)

		# enable touch interactions if supported on the current device:
		createjs.Touch.enable(@stage)

		$("input[name='btn1']").on('click', @clickBtnADD)

		# enabled mouse over / out events
		@stage.enableMouseOver(10)
		@stage.mouseMoveOutside = true # keep tracking the mouse even when it leaves the canvas

		@canvasContext = @canvas.getContext('2d')
		@image = new Image()
		@image.src = 'svg/char.png'
		#@image.src = 'svg/butterfly_bottom.svg'
		# Render our SVG image to the canvas once it loads.
		@image.onload = @handleImageLoad

		createjs.Ticker.addEventListener('tick', @tick)

		return false
			

	clickBtnADD:(e)=>
		@addNewItems()
		return false


	handleImageLoad:(e)=>
		@items = [];
		#target = e.target
		@container = new createjs.Container()
		@stage.addChild(@container)

		#shape.cache(-circleRadius, -circleRadius, circleRadius * 2, circleRadius * 2);
		
		@addNewItems(1000)

			#@canvasContext.drawImage(bitmap,0,0)

		@update = true;

		return false

	addNewItems:(p=1000)=>
		

		for i in [0...p]
			bitmap = new createjs.Bitmap(@image)
			bitmap.x = Math.max(bitmap.image.width/2,(@canvas.width-bitmap.image.width/2) * Math.random()|0)
			bitmap.y = Math.max(bitmap.image.height/2,(@canvas.height-bitmap.image.height/2) * Math.random()|0)
			bitmap.scale = .5;


			bitmap.offset = {x:bitmap.x, y:bitmap.y}

			bitmap.on("rollover", @onBtmRollOver);
			bitmap.on("rollout", @onBtmRollOut);
			bitmap.on("pressmove", @onBtmPressMove);

			#bitmap.on("mousedown", @onBtmMousedown);

			@container.addChild(bitmap)
			@items.unshift(bitmap)

		$("input[name='btn1']")[0].value = @items.length

		return false

	#onBtmMousedown:(e)->
	#	this.offset = {x:this.x-e.stageX, y:this.y-e.stageY};


	onBtmRollOut:(e)->
		this.scale = .5;

	onBtmRollOver:(e)->
		this.scale = 1;

	onBtmPressMove:(e)->
		this.x = e.stageX
		this.y = e.stageY
		return false

	tick:(e)=>
		i = @items.length
		# for item in @items
		while i-- > 0
			bitmap = @items[i]
			bitmap.scaleX = bitmap.scaleY = bitmap.scale + (Math.sin(@frameCount/10)/20)
			bitmap.x = bitmap.offset.x - (bitmap.image.width/2)*bitmap.scaleX
			bitmap.y = bitmap.offset.y - (bitmap.image.height/2)*bitmap.scaleY

		@frameCount++

		# this set makes it so the stage only re-renders when an event handler indicates a change has happened.
		#if (@update)
		#	@update = false; # only update once
		@stage.update(e)
		return false
		

init = ()->
	main = new Main()


$(window).ready(init)