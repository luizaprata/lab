#@codekit-prepend Debug.coffee
#@codekit-prepend EventDispatcher.coffee
#@codekit-prepend Workarounds.coffee
#@codekit-prepend Floating.coffee

class Main extends EventDispatcher
	canvas:null
	stage:null

	constructor:()->
		@canvas = $('.sketch')[0]
		@canvas.width = window.innerWidth
		@canvas.height = window.innerHeight

		@stage = new createjs.Stage(@canvas)

		@animContainer = new createjs.Container()
		@stage.addChild(@animContainer)
		# enable touch interactions if supported on the current device:
		@items=[]
		for x in [0...100]
			template = new Floating()
			@animContainer.addChild(template)
			@items.push (template)
			#@stage.addChild(template)

		createjs.Ticker.addEventListener('tick', @tick)

		@stage.addEventListener("stagemousemove",@onStageMouseMove)

		return false
			

	onStageMouseMove:(e)=>
		@rx = e.stageX
		@ry = e.stageY

		maxDist = 800

		for item in @items
			deltaX = (@rx-item.x)
			deltaY = (@ry-item.y)
			dist = deltaX*deltaX+deltaY*deltaY
			
			if (dist<(maxDist*maxDist))
				dist = Math.sqrt(dist)
				rad = Math.atan2(deltaY, deltaX)
				dist = 5*(maxDist/dist)
				console.log (maxDist/dist)
				item.x = item.x - Math.cos(rad) * dist
				item.y = item.y - Math.sin(rad) * dist



	tick:(e)=>
		@stage.update()
		return false
		

init = ()->
	main = new Main()


$(window).ready(init)