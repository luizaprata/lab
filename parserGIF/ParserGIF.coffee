class ParserGIF
	constructor:()->
		# info = @getInfo(sourceArrayBuffer, false);
		
	getNewImage:() ->
		return {
			identifier: '0'
			localPalette: false
			localPaletteSize: 0
			interlace: false
			comments: []
			text: ''
			left: 0
			top: 0
			width: 0
			height: 0
			delay: 0
			disposal: 0
		}

	getBitArray = (num) ->
		bits = []
		i = 7
		while i >= 0
			bits.push (if !!(num & (1 << i)) then 1 else 0)
			i--
		return bits

	getDuration:(duration) ->
		return ((duration / 100) * 1000)

	getPaletteSize:(palette) ->
		return (3 * Math.pow(2, 1 + bitToInt(palette.slice(5, 8))));

	bitToInt = (bitArray) ->
		return bitArray.reduce ((s, n) ->
			return s * 2 + n
		), 0

	readSubBlock:(view, pos, read) ->
		subBlock = {
			data: ''
			size: 0
		}

		while (true)
			size = view.getUint8(pos + subBlock.size, true)
			if (size == 0)
				subBlock.size++
				break
			if (read) 
				subBlock.data += view.getString(size, pos + subBlock.size + 1)
			subBlock.size += size + 1

		return subBlock

	getInfo:(sourceArrayBuffer, quickPass) ->
		pos = 0
		index = 0
		unpackedField = null
		subBlock = null

		info = {
			valid: false
			globalPalette: false
			globalPaletteSize: 0
			loopCount: 0
			height: 0
			width: 0
			animated: false
			images: []
			isBrowserDuration: false
			duration: 0
			durationIE: 0
			durationSafari: 0
			durationFirefox: 0
			durationChrome: 0
			durationOpera: 0
		}
		

		view = new jDataView(sourceArrayBuffer)

		# needs to be at least 10 bytes long
		if (sourceArrayBuffer.byteLength < 10) 
			return info
		

		# GIF8
		if ((view.getUint16(0) != 0x4749) || (view.getUint16(2) != 0x4638))
			return info
		

		# get height/width
		info.height = view.getUint16(6, true)
		info.width = view.getUint16(8, true)

		# not that safe to assume, but good enough by this point
		info.valid = true

		# parse global palette
		unpackedField = @getBitArray(view.getUint8(10, true))
		if (unpackedField[0])
			globalPaletteSize = @getPaletteSize(unpackedField)
			info.globalPalette = true
			info.globalPaletteSize = (globalPaletteSize / 3)
			pos += globalPaletteSize
		pos += 13

		image = @getNewImage()
		while (true) 
			try 
				block = view.getUint8(pos, true)

				switch (block) 
					when 0x21 #EXTENSION BLOCK
						type = view.getUint8(pos + 1, true)

						if (type == 0xF9) #GRAPHICS CONTROL EXTENSION
							length = view.getUint8(pos + 2)
							if (length == 4) 
								delay = @getDuration(view.getUint16(pos + 4, true))

								if (delay < 60 && !info.isBrowserDuration) 
									info.isBrowserDuration = true
								

								# http://nullsleep.tumblr.com/post/16524517190/animated-gif-minimum-frame-delay-browser-compatibility (out of date)
								image.delay = delay
								info.duration += delay
								info.durationIE += if (delay < 60) then defaultDelay else delay
								info.durationSafari += if (delay < 20) then defaultDelay else delay
								info.durationChrome += if (delay < 20) then defaultDelay else delay
								info.durationFirefox += if (delay < 20) then defaultDelay else delay
								info.durationOpera += if (delay < 20) then defaultDelay else delay

								# set disposal method
								unpackedField = @getBitArray(view.getUint8(pos + 3))
								disposal = unpackedField.slice(3, 6).join('')
								image.disposal = parseInt(disposal, 2)

								pos += 8
							else 
								pos++
							
						else 
							pos += 2
							subBlock = @readSubBlock(view, pos, true)
							switch (type) 
								when 0xFF #APPLICATION EXTENSION
									info.loopCount = view.getUint8(pos + 16, true)
									break
								when 0xCE #NAME
									# /* the only reference to this extension I could find was in
									# gifsicle. I'm not sure if this is something gifsicle just
									# made up or if this actually exists outside of this app */
									image.identifier = subBlock.data
									break
								when 0xFE #COMMENT EXTENSION
									image.comments.push(subBlock.data)
									break
								when 0x01 #PLAIN TEXT EXTENSION
									image.text = subBlock.data
									break
							

							pos += subBlock.size
						
						break
					when 0x2C # IMAGE DESCRIPTOR
						image.left = view.getUint16(pos + 1, true)
						image.top = view.getUint16(pos + 3, true)
						image.width = view.getUint16(pos + 5, true)
						image.height = view.getUint16(pos + 7, true)

						unpackedField = @getBitArray(view.getUint8(pos + 9, true))
						if (unpackedField[0]) 
							# local palette?
							localPaletteSize = @getPaletteSize(unpackedField)
							image.localPalette = true
							image.localPaletteSize = (localPaletteSize / 3)

							pos += localPaletteSize
						
						if (unpackedField[1]) 
							# interlaced?
							image.interlace = true
						

						# add image & reset object
						info.images.push(image)
						index++

						#create new image
						image = @getNewImage()
						image.identifier = index.toString()

						# set animated flag
						if (info.images.length > 1 && !info.animated) 
							info.animated = true
							# quickly bail if the gif has more than one image
							if (quickPass) 
								return info
						pos += 11
						subBlock = @readSubBlock(view, pos, false)
						pos += subBlock.size
						break
					when 0x3B # TRAILER BLOCK (THE END)
						return info
			catch
				info.valid = false
				return info
			
			# # this shouldn't happen, but if the trailer block is missing, we should bail at EOF
			if ((pos) >= sourceArrayBuffer.byteLength)
				return info


