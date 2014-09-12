#@codekit-prepend Debug.coffee
#@codekit-prepend EventDispatcher.coffee

class Main extends EventDispatcher

	constructor:()->
		var PI2 = Math.PI * 2;

			var programFill = function ( context ) {

				context.beginPath();
				context.arc( 0, 0, 0.5, 0, PI2, true );
				context.fill();

			}

			var programStroke = function ( context ) {

				context.lineWidth = 0.025;
				context.beginPath();
				context.arc( 0, 0, 0.5, 0, PI2, true );
				context.stroke();

			}

			var mouse = { x: 0, y: 0 }, INTERSECTED;

	onAssetsLoaded:()=>

		frames = [];

		@stage = new PIXI.Stage(0xFFFFFF);

		@texture = new PIXI.Texture.fromImage('assets/bg.jpg')
		@bg = new PIXI.Sprite(@texture)
		@stage.addChild(@bg)


		@renderer = new PIXI.CanvasRenderer(@w, @h, null, true, true)

# 		switch p_renderer
# 			when "canvas"
# @_renderer = 
# when "webgl"
# @_renderer = new PIXI.WebGLRenderer(@_stage.width, @_stage.height, null, true, true)
# when "auto"
# @_renderer = new PIXI.autoDetectRenderer(@_stage.width, @_stage.height, null, true, true)

		document.body.appendChild(@renderer.view);

		# alienContainer = new PIXI.DisplayObjectContainer();
		# alienContainer.position.x = 400;
		# alienContainer.position.y = 300;

		# @stage.addChild(alienContainer);

		frames = []

		for i in [0...10]
			val = if i < 10 then "0" + i else i;
			frames.push(PIXI.Texture.fromFrame("potassoteste00" + val));

		
		@starCount = 1000

		@items = []

		for i in [0...@starCount]

			movie = new PIXI.MovieClip(frames);

			theta = Math.random()*2*Math.PI
			phi = Math.acos(Math.random()*2-1)
			x0 = @sphereRad*Math.sin(phi)*Math.cos(theta)
			y0 = @sphereRad*Math.sin(phi)*Math.sin(theta)
			z0 = @sphereRad*Math.cos(phi)
			
			movie.position.x = x0 + @cx
			movie.position.y = y0 + @cy
			movie.position.z = @sphereCenterZ + z0

			movie.ix = x0
			movie.iy = y0
			movie.iz = @sphereCenterZ + z0
			movie.anchor.x = 0.5
			movie.anchor.y = 0.5


			movie.animationSpeed = Math.random()*0.5
			movie.play();

			@items.push(movie)

			@stage.addChild(movie)

		@totalItems = @items.length

		requestAnimFrame(@update)

		return false

	update:()=>

		# random = Math.random()*2
		# p = @nextItem()
		# p.vx += 0.1*(Math.random()*2-1)
		# p.vy += 0.1*(Math.random()*2-1)
		# p.vz += 0.1*(Math.random()*2-1)

		i = 0
		# p = @nextItem()

		@turnAngle = (@turnAngle + @turnSpeed) % (2*Math.PI);
		sinAngle = Math.sin(@turnAngle)
		cosAngle = Math.cos(@turnAngle)

		while i<@totalItems
			p = @items[i]
			# p.x += p.vx
			# p.position.y += p.vy
			# p.position.z += p.vz+
			# update viewing angle
			# console.log @turnAngle, p.position.x,p.position.z,@sphereCenterZ
			# console.log sinAngle, cosAngle

			rotX = cosAngle*p.ix + sinAngle*(p.iz - @sphereCenterZ)
			rotZ = -sinAngle*p.ix + cosAngle*(p.iz - @sphereCenterZ) + @sphereCenterZ
			m = @fLen/(@fLen - rotZ)
			p.projX = (rotX*m)
			p.projY = (p.iy*m)

			# outsideTest = false#( p.projX>@w || p.projX<0 || rotZ>@zMax )
			
			# if (!outsideTest)
				# p.ix = p.projX 
				# p.iy = p.projY
			p.position.x = p.projX + @cx
			p.position.y = p.projY + @cy

			i++
				

			# console.log rotX,m, @cx, p.position.y,m, @cy


		@renderer.render(@stage);
		requestAnimFrame(@update);

	
	nextItem:()=>

		item = @items[@countItem]

		if (++@countItem >= @totalItems)
			@countItem = 0

		return item


	clickBtnADD:(e)=>
		@addNewItems()
		return false

	
		

init = ()->
	main = new Main()


$(window).ready(init)