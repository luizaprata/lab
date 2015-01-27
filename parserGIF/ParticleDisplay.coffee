class ParticleDisplay extends CanvasBaseObject
	constructor: (image, @numLayers = 20, blink = false) ->
		super
		@_minSpread = 0
		@_blink = blink
		@_spreadFactor = 6
		@_spread = 0
		@_offsetX = 0
		@_offsetY = 0
		@_drawCanvas = document.createElement('canvas')
		@_drawCanvas.width = 100
		@_drawCanvas.height = 100
		@_drawContext = @_drawCanvas.getContext('2d')
		@_interacting = false
		@_dirty = true
		if false
			@_drawCanvas.style.position = 'absolute'
			@_drawCanvas.style.zIndex = 100000
			document.body.appendChild(@_drawCanvas)
		if image
			@drawImage(image)
		@_doRender = true
		if app.hideGlobe
			@spread(0)
			@render()
			@_doRender = false

	minSpread:(value)->
		if !isNaN(value)
			if @_minSpread != value
				@_dirty = true
				@_minSpread = value
		if @_spread < @_minSpread
			@spread(@_minSpread)
		return @_minSpread
	spread:(value)->
		if !isNaN(value)
			if value < @_minSpread
				value = @_minSpread
			else if value > 2
				value = 2
			if @_spread != value
				@_dirty = true
				@_spread = value
		return @_spread
	spreadFactor:(value)->
		if !isNaN(value)
			@_spreadFactor = value
		return @_spreadFactor
	offset:(x, y)->
		@offsetX(x)
		@offsetY(y)
	offsetX:(value)->
		if !isNaN(value)
			if @_offsetX != value
				@_offsetX = value
				@_dirty = true
		return @_offsetX
	offsetY:(value)->
		if !isNaN(value)
			if @_offsetY != value
				@_offsetY = value
				@_dirty = true
		return @_offsetY
	start:()->
		if !@_doRender
			return
		@resume()
		# @canvas().on(StageCanvas.RENDER, @render)
	stop:()->
		if !@_doRender
			return
		@pause()
		# @canvas().off(StageCanvas.RENDER, @render)
		
	drawImage:(image)->
		@_drawCanvas.width = @contentWidth = image.width
		@_drawCanvas.height = @contentHeight = image.height
		@_drawContext.drawImage(image, 0, 0)

		pixels = @_drawContext.getImageData(0, 0, @contentWidth, @contentHeight).data
		opaquePixels = []
		i = pixels.length
		c = 0
		while i-- > 0
			if pixels[i] > 0
				p = (i / 4) >> 0
				opaquePixels[c++] = [
					p % @contentWidth, 
					p / @contentWidth >> 0, 
					pixels[i - 3], 
					pixels[i - 2], 
					pixels[i - 1], 
					pixels[i],
					Math.random()
				]
			i -= 3
		opaquePixels.sort(@shuffle)
		@buildLayers(opaquePixels)
	shuffle:(a, b)->
		if a[6] > b[6]
			return 1
		if a[6] < b[6]
			return -1
		return 0

	buildLayers:(pixels)->
		i = pixels.length
		c = 0
		l = 0
		@_layers = []

		numParticles = Math.ceil(i / @numLayers)
		@container = new PIXI.SpriteBatch()
		@container.x = -@contentWidth * 0.5
		@container.y = -@contentHeight * 0.5
		@addChild(@container)

		while i-- > 0
			if c == 0
				@_drawContext.clearRect(0, 0, @contentWidth, @contentHeight)
				imageData = @_drawContext.getImageData(0, 0, @contentWidth, @contentHeight)
			
			p = pixels[i]
			@_setPixel(imageData, p[0], p[1], p[2], p[3], p[4], p[5])
			if c++ >= numParticles || i == 0
				c = 0
				@_drawContext.putImageData(imageData, 0, 0)
				texture = PIXI.Texture.fromImage(@_drawCanvas.toDataURL())
				sprite = new PIXI.Sprite(texture)
				@_layers[l++] = {
					sprite: sprite
					alpha: Math.random()
					alphaTo: Math.random()
					speed: Math.random() * 0.03 + 0.03
					initOffset: -Math.random() * 0.1
					e: Math.random()
				}
				@container.addChild(sprite)
		@_numLayers = @_layers.length

	_setPixel:(imageData, x, y, r, g, b, a)->
		index = (x + y * @contentWidth) * 4
		imageData.data[index] = r
		imageData.data[index + 1] = g
		imageData.data[index + 2] = b
		a += imageData.data[index + 3]
		if a > 255
			a = 255
		imageData.data[index + 3] = a

	destroy:()=>
		@_numLayers.length = 0
		@_numLayers = null
		@stop()
		super

	render:(evt=null)=>

		# if !@_dirty
		# 	return
		@_dirty = false
		i = @_numLayers
		spreadOffset = 0
		if @_spread > 1
			spreadOffset = @_spread - 1
		else if @_spread < 0
			spreadOffset = - @_spread
		while i-- > 0
			layer = @_layers[i]
			sprite = layer.sprite
			px = 0
			py = 0
			e = layer.e + spreadOffset
			s = (e * @_spread * @_spreadFactor + layer.initOffset + 1)
			if s < @_minSpread + 1
				s = @_minSpread + 1
			sprite.scale.x = sprite.scale.y = s
			px = (1 - s) * @contentWidth * (@_offsetX * 0.5 + 0.5)
			py = (1 - s) * @contentHeight * (@_offsetY * 0.5 + 0.5)
			sprite.x = px
			sprite.y = py

			a = e * @_spread + layer.initOffset
			if a < 0
				a = 0
			else if a > 1
				a = 1
			a = 1 - a
			if @_blink
				da = layer.alphaTo - layer.alpha
				if da * da < 0.005
					layer.alphaTo = Math.random() * 0.7 + 0.3
					layer.speed = Math.random() * 0.05 + 0.05
				layer.alpha += da * layer.speed
				a *= layer.alpha
			sprite.alpha = a
