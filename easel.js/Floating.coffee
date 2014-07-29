class Floating extends createjs.Container

	@shape:null

	constructor:()->
		#super()
		this.initialize();

		# size = 8
		# angle = Math.PI * 0.5
		# cos = Math.cos(angle)
		# sin = Math.sin(angle)
		# g = new createjs.Graphics()
		# g.beginFill("#FF0000")
		# # g.setStrokeStyle(size,"round", "mitter")
		# # g.beginLinearGradientFill(["#FF0000","#00FF00"], [0, 1], 0, 0, 100, 100)
		# radius = size * 0.5
		# g.moveTo(0, 0)
		# g.lineTo(0, 10)
		# # g.arc(0, 0, 10, 0, Math.PI * 0.5, true)
		# g.lineTo(100, 0)
		# g.lineTo(100, 100)
		# g.lineTo(0, 10)
		# # # g.beginStroke("#CCC")
		# # g.moveTo(0,0)
		# # g.lineTo(100,100)
		# # g.rect(0, 0, 100, 100)		
		# # g.drawRoundRect(0, 0, 200, 4, 2)



		# x1 = 10
		# x2 = 20
		# y1 = 10
		# y2 = 70
		# g = new createjs.Graphics()
		# g.setStrokeStyle(12,"round", "round").s("#CCC")
		# g.moveTo(x1, y1)
		# g.lineTo(x2, y2)
		# this.addChild(new createjs.Shape().set({graphics:g}));
		
		# g = new createjs.Graphics()
		# g.setStrokeStyle(12,"round", "round")
		
		# DE
		# deltaX = (x2-x1)
		# deltaY = (y2-y1)
		# rad = Math.atan2(deltaY, deltaX)
		# dist = Math.sqrt(deltaX*deltaX+deltaY*deltaY)
		# xPos = x1 + Math.cos(rad) * (dist-10)
		# yPos = y1 + Math.sin(rad) * (dist-10)
		# g.moveTo(x1, y1)
		# g.lineTo(xPos,yPos)

		# PARA
		# deltaX = (x2-x1)
		# deltaY = (y2-y1)
		# rad = Math.atan2(deltaY, deltaX)
		# dist = Math.sqrt(deltaX*deltaX+deltaY*deltaY)
		# xPos = x2 - Math.cos(rad) * (dist-10)
		# yPos = y2 - Math.sin(rad) * (dist-10)
		# g.moveTo(x2, y2)
		# g.lineTo(xPos,yPos)

		
		# g.beginLinearGradientStroke(["#FF0000","#00FF00"], [0, 1], 0, 0, xPos, yPos)

		@shape = new createjs.Shape()
		@shape.graphics.beginFill("#" + Math.random().toString(16).slice(2, 8)).drawCircle(0, 0, 10)
		this.addChild(@shape)
		

		# this.addChild(new createjs.Shape().set({graphics:g}));


		
		

		# s = new createjs.Shape(g);

		# s.rotation += 100

		# this.addChild(s)

		# if (!@shape?) 
		# 	@shape = new createjs.Shape()
		# 	this.addChild(@shape)

		# @shape.graphics.clear()
		# @shape.graphics.beginFill("#FF0000").drawCircle(0,0, 100)
		this.x = Math.random()*800
		this.y = Math.random()*800

		# if (!@text?)
		# 	@text = new createjs.Text("Hi", "50px Arial", "#000")
		# 	@text.textBaseline = "alphabetic"
		# 	this.addChild(@text)




