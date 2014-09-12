#@codekit-prepend Debug.coffee
#@codekit-prepend EventDispatcher.coffee

class Main extends EventDispatcher

	constructor:()->
		w = window.innerWidth
		h = window.innerHeight

		assetsToLoader = [ "fighter.json"];

		loader = new PIXI.AssetLoader(assetsToLoader);

		loader.onComplete = @onAssetsLoaded
		loader.load()

	onAssetsLoaded:()=>

		frames = [];

		@stage = new PIXI.Stage(0xFFFFFF);

		@renderer = new PIXI.CanvasRenderer(800, 600, null, true, true)
		console.log @renderer

# 		switch p_renderer
# 			when "canvas"
# @_renderer = 
# when "webgl"
# @_renderer = new PIXI.WebGLRenderer(@_stage.width, @_stage.height, null, true, true)
# when "auto"
# @_renderer = new PIXI.autoDetectRenderer(@_stage.width, @_stage.height, null, true, true)

		document.body.appendChild(@renderer.view);

		alienContainer = new PIXI.DisplayObjectContainer();
		alienContainer.position.x = 400;
		alienContainer.position.y = 300;

		@stage.addChild(alienContainer);

		frames = []

		for i in [0...30]
			val = if i < 10 then "0" + i else i;
			frames.push(PIXI.Texture.fromFrame("rollSequence00" + val + ".png"));

		sphereRad = 280
		@starCount = 1000

		for i in [0...@starCount]

			movie = new PIXI.MovieClip(frames);

			theta = Math.random()*2*Math.PI
			phi = Math.acos(Math.random()*2-1)
			x0 = sphereRad*Math.sin(phi)*Math.cos(theta)
			y0 = sphereRad*Math.sin(phi)*Math.sin(theta)
			movie.position.x = 300 + x0
			movie.position.y = 300 + y0
			movie.anchor.x = 0.5
			movie.anchor.y = 0.5
			movie.animationSpeed = Math.random()*0.5
			movie.play();

			@stage.addChild(movie)

		requestAnimFrame(@update)

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