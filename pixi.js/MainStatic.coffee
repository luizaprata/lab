#@codekit-prepend Debug.coffee
#@codekit-prepend EventDispatcher.coffee

class Main extends EventDispatcher

	constructor:()->
		w = window.innerWidth
		h = window.innerHeight

		@stars = []

		@starCount = 1000

		ballTexture = new PIXI.Texture.fromImage('assets/items.png')
		@renderer = PIXI.autoDetectRenderer(w, h)
		@stage = new PIXI.Stage()

		document.body.appendChild(@renderer.view)

		sphereRad = 280


		for i in [0...@starCount]
			tempBall = new PIXI.Sprite(ballTexture)
			theta = Math.random()*2*Math.PI
			phi = Math.acos(Math.random()*2-1)
			x0 = sphereRad*Math.sin(phi)*Math.cos(theta)
			y0 = sphereRad*Math.sin(phi)*Math.sin(theta)
			tempBall.position.x = x0 + h*0.5
			tempBall.position.y = y0 + h*0.5
			tempBall.anchor.x = 0.5
			tempBall.anchor.y = 0.5

			@stars.push(tempBall)

			@stage.addChild(tempBall)

		requestAnimFrame(@update)


		$("input[name='btn1']").on('click', @clickBtnADD)

		return false


	update:()=>
		@renderer.render(@stage);
		requestAnimFrame(@update);
			

	clickBtnADD:(e)=>
		@addNewItems()
		return false

	
		

init = ()->
	main = new Main()


$(window).ready(init)