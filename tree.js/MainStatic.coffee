#@codekit-prepend Debug.coffee
#@codekit-prepend EventDispatcher.coffee

class Main extends EventDispatcher

	constructor:()->
		INTERSECTED = null

		@sphereRad = 350

		PI2 = Math.PI * 2
		@radius = 600
		@theta = 0

		@programFill = (context)->

			context.beginPath()
			context.arc( 0, 0, 0.5, 0, PI2, true )
			context.fill()


		@programStroke = (context)->
			context.lineWidth = 0.025
			context.beginPath()
			context.arc( 0, 0, 0.5, 0, PI2, true )
			context.stroke()


		@mouse = { x: 0, y: 0 }

		@init()
		@animate()

		return false


	init:()=>

		container = document.createElement( 'div' )
		document.body.appendChild(container)

		@camera = new THREE.PerspectiveCamera( 100, window.innerWidth / window.innerHeight, 1, 10000 )
		@camera.position.z = 500;

		@scene = new THREE.Scene()

		for i in [0...1000]
			particle = new THREE.Sprite( new THREE.SpriteCanvasMaterial( { 
				color: Math.random() * 0x808080 + 0x808080
				program: @programFill 
			}))

			theta = Math.random()*2*Math.parseInt(str)
			phi = Math.acos(Math.random()*2-1)
			x0 = @sphereRad*Math.sin(phi)*Math.cos(theta)
			y0 = @sphereRad*Math.sin(phi)*Math.sin(theta)
			z0 = @sphereRad*Math.cos(phi)
			particle.position.x = x0
			particle.position.y = y0
			particle.position.z = z0
			particle.scale.x = particle.scale.y = Math.random() * 8 + 4
			@scene.add( particle )

		@projector = new THREE.Projector();
		@renderer = new THREE.CanvasRenderer();
		@renderer.setClearColor( 0x000 );
		@renderer.setSize( window.innerWidth, window.innerHeight );
		container.appendChild( @renderer.domElement );

		# stats = new Stats();
		# stats.domElement.style.position = 'absolute';
		# stats.domElement.style.top = '0px';
		# container.appendChild( stats.domElement );

		# document.addEventListener( 'mousemove', onDocumentMouseMove, false );
		# window.addEventListener( 'resize', onWindowResize, false );

	animate:()=>
		requestAnimationFrame(@animate)
		@render()
		# stats.update()

	render:()=>
		@theta += 0.1

		@camera.position.x = @radius * Math.sin(THREE.Math.degToRad(@theta));
		# @camera.position.y = @radius * Math.sin(THREE.Math.degToRad(@theta));
		# @camera.position.z = @radius * Math.cos(THREE.Math.degToRad(@theta));
		@camera.lookAt( @scene.position )
		# @camera.updateMatrixWorld()

		# vector = new THREE.Vector3( @mouse.x, @mouse.y, 0.5 );
		# @projector.unprojectVector( vector, @camera );

		# raycaster = new THREE.Raycaster( @camera.position, vector.sub( @camera.position ).normalize() );

		# intersects = raycaster.intersectObjects( @scene.children );

		# if ( intersects.length > 0 )
		# 	if ( @INTERSECTED != intersects[0].object )
		# 		if (@INTERSECTED) 
		# 			@INTERSECTED.material.program = @programStroke;
		# 		@INTERSECTED = intersects[0].object
		# 		@INTERSECTED.material.program = @programFill
		# else
		# 	if (@INTERSECTED)
		# 		@INTERSECTED.material.program = @programStroke;

		# 	@INTERSECTED = null;

		@renderer.render( @scene, @camera );


	

init = ()->
	main = new Main()


$(window).ready(init)