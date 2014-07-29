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

	linha:0

	constructor:()->
		@canvas = $('.sketch')[0]
		@canvas.width = window.innerWidth
		@canvas.height = window.innerHeight

		@stage = new createjs.Stage(@canvas)

		#createjs.Ticker.addEventListener('tick', @tick)

		return false
			

	clickBtnADD:(e)=>
		@addNewItems()
		return false


	addNewItems:()=>

		linha++



		#Linha 4:   114=1(104)+4(103)+6(102)+4(101)+1(100)=14641
		# Math.pow(4, 3); 4*4*4

		for i in [0...linha]
			i = Math.pow(11,i)
		console.log i
				
		
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
		#while i-- > 0
		#	bitmap = @items[i]
		#	bitmap.scaleX = bitmap.scaleY = bitmap.scale + (Math.sin(@frameCount/10)/20)
		#	bitmap.x = bitmap.offset.x - (bitmap.image.width/2)*bitmap.scaleX
		#	bitmap.y = bitmap.offset.y - (bitmap.image.height/2)*bitmap.scaleY

		#@frameCount++

		# this set makes it so the stage only re-renders when an event handler indicates a change has happened.
		#if (@update)
		#	@update = false; # only update once

		@container.updateCache("source-over");
		@stage.update(e)
		return false
		

init = ()->
	main = new Main()


$(window).ready(init)