#@codekit-prepend Debug.coffee
#@codekit-prepend EventDispatcher.coffee

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

		@canvasContext = @canvas.getContext('2d')
		@image = new Image()
		@image.src = 'assets/items.png'
		@image.onload = @handleImageLoad

		createjs.Ticker.setFPS(60);
			

		createjs.Ticker.addEventListener('tick', @tick)

		$("input[name='btn1']").on('click', @clickBtnADD)

		return false
			

	clickBtnADD:(e)=>
		@addNewItems()
		return false


	handleImageLoad:(e)=>
		@spriteList = [];
		@container = new createjs.Container()
		@stage.addChild(@container)

		@ss = new createjs.SpriteSheet({
				images: [@image]
				frames: {
					width: 16
					height: 16
					regX:8
					regY:8
				}
				animations: {
					walk: [0, 1,true]
					# walkDnRt: [2, 3, "walkUpRt"]
				}
			});

		@sprite = new createjs.Sprite(@ss, "walk");
		@addNewItems(1000)


		return false

	addNewItems:(p=1000)=>
		w = @canvas.width/2
		h = @canvas.height/2
		sphereRad = 280;

		for i in [0...p]
			@sprite.name = "item" + i;
			@sprite.speed = 2;
			@sprite.vX = @sprite.speed;
			@sprite.vY = 0;
			# @sprite.x = Math.random() * w;
			# @sprite.y = Math.random() * h;

			theta = Math.random()*2*Math.PI
			phi = Math.acos(Math.random()*2-1)
			x0 = sphereRad*Math.sin(phi)*Math.cos(theta)
			y0 = sphereRad*Math.sin(phi)*Math.sin(theta)
			# z0 = sphereRad*Math.cos(phi)

			@sprite.x = w+ x0
			@sprite.y = h + y0
			# @sprite.z = z0 - 10
			

			# have each rat start on a random frame in the "walkRt" animation:
			@sprite.currentAnimationFrame = (Math.random() * 3)>>0;
			@container.addChild(@sprite);
			@sprite.gotoAndPlay("walkRt")
			console.log @ss.getNumFrames("walkRt"),@sprite.currentAnimationFrame
			@spriteList.push(@sprite);
			# @sprite.cache(0,0,16,16)

			# the callback is called each time a sequence completes:
			# sprite.addEventListener("animationend", angleChange);

			# rather than creating a brand new instance each time, and setting every property, we
			# can just clone the current one and overwrite the properties we want to change:
			if (i < p - 1) 
				@sprite = @sprite.clone();
			


			# bitmap = new createjs.Bitmap(@image)
			# bitmap.x = Math.max(bitmap.image.width/2,(@canvas.width-bitmap.image.width/2) * Math.random()|0)
			# bitmap.y = Math.max(bitmap.image.height/2,(@canvas.height-bitmap.image.height/2) * Math.random()|0)
			# bitmap.scale = .5;
			# bitmap.offset = {x:bitmap.x, y:bitmap.y}
			# addChild(bitmap)
			# 

		# $("input[name='btn1']")[0].value = @items.length

		return false


	tick:(e)=>
		# i = @spriteList.length
		# # for item in @items
		# while i-- > 0
		# 	bitmap = @items[i]
		# 	bitmap.scaleX = bitmap.scaleY = bitmap.scale + (Math.sin(@frameCount/10)/20)
		# 	bitmap.x = bitmap.offset.x - (bitmap.image.width/2)*bitmap.scaleX
		# 	bitmap.y = bitmap.offset.y - (bitmap.image.height/2)*bitmap.scaleY

		# @frameCount++

		@stage.update(e)
		return false
		

init = ()->
	main = new Main()


$(window).ready(init)