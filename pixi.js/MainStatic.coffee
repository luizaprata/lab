#@codekit-prepend Debug.coffee
#@codekit-prepend EventDispatcher.coffee

class Main extends EventDispatcher

	constructor:()->
		@w = window.innerWidth
		@h = window.innerHeight

		@turnSpeed = 2*Math.PI/1600
		@fLen = 320
		@turnAngle = 0
		@sphereRad = 280
		@sphereCenterZ = - @sphereRad*0.3
		@cx = @w*0.5
		@cy = @h*0.5
		@zMax = @fLen-2

		@items = []

		@starCount = 1000

		@ballTexture = new PIXI.Texture.fromImage('assets/item.png')
		@renderer = new PIXI.CanvasRenderer(@w, @h, null, true, true)
		@stage = new PIXI.Stage()

		document.body.appendChild(@renderer.view)

		

		$(window).on('click',@add)


		

		requestAnimFrame(@update)


		$("input[name='btn1']").on('click', @clickBtnADD)

		@add()

		return false


	add:()=>
		w = window.innerWidth
		h = window.innerHeight

		for i in [0...@starCount]
			tempBall = new PIXI.Sprite(@ballTexture)
			theta = Math.random()*2*Math.PI
			phi = Math.acos(Math.random()*2-1)
			x0 = @sphereRad*Math.sin(phi)*Math.cos(theta)
			y0 = @sphereRad*Math.sin(phi)*Math.sin(theta)
			z0 = @sphereRad*Math.cos(phi)

			tempBall.position.x = x0 + @cx
			tempBall.position.y = y0 + @cy
			tempBall.position.z = @sphereCenterZ + z0

			tempBall.ix = x0
			tempBall.iy = y0
			tempBall.iz = @sphereCenterZ + z0
			tempBall.anchor.x = 0.5
			tempBall.anchor.y = 0.5

			@items.push(tempBall)

			@stage.addChild(tempBall)

		@totalItems = @items.length


	update:()=>
		@turnAngle = (@turnAngle + @turnSpeed) % (2*Math.PI);
		sinAngle = Math.sin(@turnAngle)
		cosAngle = Math.cos(@turnAngle)
		i = 0
		while i<@totalItems
			p = @items[i]
			rotX = cosAngle*p.ix + sinAngle*(p.iz - @sphereCenterZ)
			rotZ = -sinAngle*p.ix + cosAngle*(p.iz - @sphereCenterZ) + @sphereCenterZ
			m = @fLen/(@fLen - rotZ)
			p.projX = (rotX*m)
			p.projY = (p.iy*m)
			p.position.x = p.projX + @cx
			p.position.y = p.projY + @cy

			i++

		@renderer.render(@stage);
		requestAnimFrame(@update);
			

	clickBtnADD:(e)=>
		@addNewItems()
		return false

	
		

init = ()->
	main = new Main()


$(window).ready(init)