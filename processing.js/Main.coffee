#@codekit-prepend Debug.coffee
#@codekit-prepend EventDispatcher.coffee
#@codekit-prepend Workarounds.coffee

class Main extends EventDispatcher
	processingInstance:null;
	canvas:null;
	nX:0;
	nY:0;
	delay:.3;
	items:[{type:0, rad:100, x:300, y:300}]
	testVertices:null;
	showDEBUG:false;

	constructor:()->
		@sketch = new Processing.Sketch()
		@canvas = $('.sketch')[0]
		@sketch.attachFunction = @initProcessing
		@processingInstance = new Processing(@canvas, @sketch)

		$("input[name='btn1']").on('click', @clickBtnADD)
		$(document).keypress(@keyBoadEvent);
		$(document).keyup(@keyBoadEvent);

		#butterfly_bottom.svg
		#French_Florals.svg
		#Vintage_Shoe.svg


	keyBoadEvent:(e)=>
		@showDEBUG = (e.type == "keypress" and e.keyCode == 32)
		return false

	clickBtnADD:(e)=>
		item = @processingInstance.loadShape("svg/butterfly_bottom.svg")
		hit = item.children[item.children.length-1].vertices
		newTriangle = []
		xPos = Math.random()*window.innerWidth
		yPos = Math.random()*window.innerHeight

		for i in [1...hit.length] by 1
			console.log(hit[i-1][0], hit.length )
			newTriangle.push({
				x1:hit[i-1][0]+xPos
				y1:hit[i-1][1]+yPos
				x2:hit[i][0]+xPos
				y2:hit[i][1]+yPos
				x3:xPos
				y3:yPos
				})


		data = {
			type:1
			svg:item
			rad:80
			x:xPos
			y:yPos
			hit:newTriangle
		}
		@items.unshift (data)
		
		return false


	initProcessing:(processing)=>
		processing.size(window.innerWidth,window.innerHeight)
		processing.background(200)
		processing.stroke(processing.color(44,48,32))
		processing.fill( 100, 100, 200 )
		processing.stroke(255)

		processing.mouseMoved = () =>
			nX = @processingInstance.mouseX;
			nY = @processingInstance.mouseY;

			i = @items.length
			# for item in @items
			while i-- > 0
				item = @items[i]
				if item.hit
					for j in [0...item.hit.length]
						if (@baryCentricTestByArea(item.hit[j].x1,item.hit[j].y1, item.hit[j].x2,item.hit[j].y2, item.hit[j].x3,item.hit[j].y3, nX, nY))
							console.log('HIT EM:'+i);
							break;
			
			return false;

		processing.draw = ()=>
			processing.background(200)
			
			i = @items.length
			# for item in @items
			while i-- > 0
				item = @items[i]
				item.rad = item.rad + Math.sin( processing.frameCount / 4 );
				if (item.type == 0) 
					processing.ellipse( item.x, item.y, item.rad, item.rad )
				else if (item.type == 1) 
					processing.shape(item.svg, item.x, item.y, item.rad, item.rad)
					if (@showDEBUG)
						#processing.fill( Math.random()*255)
						for j in [0...item.hit.length]
							processing.triangle(item.hit[j].x1, item.hit[j].y1, item.hit[j].x2, item.hit[j].y2, item.hit[j].x3, item.hit[j].y3);

					
			return false;

	baryCentricTestByArea:(x1,y1, x2,y2, x3,y3, px,py) =>
		a = @area(x1,y1, x2,y2, x3,y3)
		if (a == 0) 
			return false
		a1 = @area(x2,y2, x3,y3, px,py)/a
		if (a1 < 0) 
			return false
		a2 = @area(x3,y3, x1,y1, px,py)/a
		if (a2 < 0) 
			return false
		a3 = @area(x1,y1, x2,y2, px,py)/a
		if (a3 < 0) 
			return false
		return true;

	area:(x1,y1,x2,y2,x3,y3)=>
		v1x = x1 - x3
		v1y = y1 - y3
		v2x = x2 - x3
		v2y = y2 - y3
		return (v1x * v2y - v1y * v2x)/2;

init = ()->
	main = new Main()

$(window).ready(init)