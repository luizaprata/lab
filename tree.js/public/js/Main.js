`(function(){var Browser,Debug,__slice=[].slice;String.prototype.ltrim=function(e){var t;e==null&&(e=null);e||(e="s");t=new RegExp("^"+e+"*");t.global=!0;t.multiline=!0;return this.replace(t,"")};String.prototype.rtrim=function(e){var t;e==null&&(e=null);e||(e="s");t=new RegExp(e+"*$");t.global=!0;t.multiline=!0;return this.replace(t,"")};String.prototype.trim=function(e){e==null&&(e=null);return this.ltrim(e).rtrim(e)};String.prototype.toCamelCase=function(){var e;e=this.replace(/([\+\-_ ][a-z])/g,function(e){return e.toUpperCase().replace(/[\+\-_ ]/,"")});return e.charAt(0).toUpperCase()+e.slice(1)};Debug=function(){function Debug(){}Debug.debug=!1;Debug.light=4764196;Debug.dark=2884445;Debug.init=function(){var re,_ref;Debug._console=window.console;try{Debug._log=Function.prototype.bind.call((_ref=Debug._console)!=null?_ref.log:void 0,Debug._console)}catch(_error){}window.Debug==null&&(window.Debug=Debug);Debug.check()||eval("window[Math.random()]()");re=new RegExp(/debug=(1|true)/i);Debug.debug=re.test(window.location.search);re=new RegExp(/debug=(0|false)/i);if(!Debug.debug&&!re.test(window.location.search)){re=new RegExp(/([\.|\/]local\.|localhost|127\.0\.0\.1|192\.\d+\.\d+\.\d+|dev\.slikland\.)/i);Debug.debug=re.test(window.location.href)}if(!Debug.debug||!window.console)window.console={assert:function(){},clear:function(){},count:function(){},debug:function(){},dir:function(){},dirxml:function(){},error:function(){},exception:function(){},group:function(){},groupCollapsed:function(){},groupEnd:function(){},info:function(){},log:function(){},profile:function(){},profileEnd:function(){},table:function(){},time:function(){},timeEnd:function(){},timeStamp:function(){},trace:function(){},warn:function(){}};return Debug.browser=new Browser};Debug.check=function(e){var t,n,r,i;e==null&&(e=null);r="";t="";n=this.light;while(n>0){t=String.fromCharCode(n&255)+t;n>>=8}r+=btoa(t);t="";n=this.dark;while(n>0){t=String.fromCharCode(n&255)+t;n>>=8}r+=btoa(t);i=r.toLowerCase();return e?i===e.toLowerCase():i.charAt(0)==="s"&&i.charAt(1)==="l"};Debug.checkBrowser=function(e){return this.browser.checkBrowser(e)};Debug.log=function(){if(Debug._log!=null)return typeof Debug._log=="function"?Debug._log.apply(Debug,arguments):void 0;try{return console.log.apply(console,arguments)}catch(e){}};Debug.logTime=function(){var e,t,n,r,i,s;e=1<=arguments.length?__slice.call(arguments,0):[];i=(new Date).getTime();this.initTime||(this.initTime=this.currentTime=i);n=i-this.currentTime;s=n.toString();while(s.length<6)s=" "+s;t=s+"|";s=(this.currentTime-this.initTime).toString();while(s.length<6)s=" "+s;t+=s;t=["%c"+t+":"];r="font-weight: bold;";n>100?r+="color: red;":n>50&&(r+="color: orange;");t.push(r);Debug.log.apply(this,[].concat(t,e));return this.currentTime=i};return Debug}.call(this);Browser=function(){function t(){var t,n,r;this.matched=null;this.ua=(typeof navigator!="undefined"&&navigator!==null?navigator.userAgent:void 0)||"";this.os=navigator.platform||"";this.ios=e(/(ipod|iphone|ipad)/i,this.ua);this.tablet=/(ipad.*|tablet.*|(android.*?chrome((?!mobi).)*))$/i.test(this.ua);this.mobile=!this.tablet&&(this.ios||/[^-]mobi/i.test(this.ua));this.version=e(/version\/(\d+(\.\d+)*)/i,this.ua);this.getBrowser();this.versionArr=this.version.split(".");r=this.versionArr;for(t in r){n=r[t];this.versionArr[t]=Number(n)}}var e;t.prototype.matches=[{name:"Opera",nick:/opera/i,test:/opera|opr/i,version:/(?:opera|opr)[\s\/](\d+(\.\d+)*)/i},{name:"Windows Phone",nick:/WindowsPhone/i,test:/windows phone/i,version:/iemobile\/(\d+(\.\d+)*)/i},{name:"Internet Explorer",nick:/explorer|internetexplorer|ie/i,test:/msie|trident/i,version:/(?:msie |rv:)(\d+(\.\d+)*)/i},{name:"Chrome",nick:/Chrome/i,test:/chrome|crios|crmo/i,version:/(?:chrome|crios|crmo)\/(\d+(\.\d+)*)/i},{name:"iPod",nick:/iPod/i,test:/ipod/i},{name:"iPhone",nick:/iPhone/i,test:/iphone/i},{name:"iPad",nick:/iPad/i,test:/ipad/i},{name:"FirefoxOS",nick:/FirefoxOS|ffos/i,test:/\((mobile|tablet);[^\)]*rv:[\d\.]+\)firefox|iceweasel/i,version:/(?:firefox|iceweasel)[ \/](\d+(\.\d+)?)/i},{name:"Firefox",nick:/Firefox|ff/i,test:/firefox|iceweasel/i,version:/(?:firefox|iceweasel)[ \/](\d+(\.\d+)?)/i},{name:"Android",nick:/Android/i,test:/android/i},{name:"BlackBerry",nick:/BlackBerry/i,test:/(blackberry)|(\bbb)|(rim\stablet)\d+/i,version:/blackberry[\d]+\/(\d+(\.\d+)?)/i},{name:"WebOS",nick:/WebOS/i,test:/(web|hpw)os/i,version:/w(?:eb)?osbrowser\/(\d+(\.\d+)?)/i},{name:"Safari",nick:/safari/i,test:/safari/i}];t.prototype.checkBrowser=function(e){var t,n,r,i,s,o,u;if(!this.matched)return 0;if(!(r=e.match(/(?:(?:(\D.*?)(?:\s|$))?(\D.*?)(?:\s|$))?(?:([\d\.]+))?/)))return 0;i=0;if(r[1]){if(!(new RegExp(r[1],"i")).test(this.os))return 0;i=1}if(r[2]){if((u=this.matched.nick)!=null?!u.test(r[2]):!void 0)return 0;i=1}if(r[3]){s=r[3].split(".");n=s.length;n>this.versionArr.length&&(n=this.versionArr.length);for(t=o=0;0<=n?o<=n:o>=n;t=0<=n?++o:--o){if(this.versionArr[t]>s[t])return 2;if(this.versionArr[t]<s[t])return-1}}return i};t.prototype.getBrowser=function(){var t,n,r,i,s;i=this.matches;s=[];for(n=0,r=i.length;n<r;n++){t=i[n];if(t.test.test(this.ua)){this.name=t.name;this.version=this.version||e(t.version,this.ua);this.matched=t;break}s.push(void 0)}return s};e=function(e,t){var n;n=t.match(e);return n&&n.length>1&&n[1]||null};return t}();if(!window.atob){window.atob=function(e){var t,n,r,i,s,o,u,a,f,l,c;a="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";l=e.length;f=0;c="";while(f<l){i=e.charAt(f);s=e.charAt(f+1);o=e.charAt(f+2);u=e.charAt(f+3);i=a.indexOf(i);s=a.indexOf(s);o=a.indexOf(o);u=a.indexOf(u);o<0&&(o=0);u<0&&(u=0);t=i<<2&255|s>>4;n=s<<4&255|o>>2;r=o<<6&255|u&63;c+=String.fromCharCode(t);c+=String.fromCharCode(n);c+=String.fromCharCode(r);f+=4}return c};window.btoa=function(e){var t,n,r,i,s,o,u,a,f,l,c;a="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";l=e.length;f=0;c="";while(f<l){t=e.charCodeAt(f+0)&255;n=e.charCodeAt(f+1)&255;r=e.charCodeAt(f+2)&255;i=t>>2&63;s=(t<<4|n>>4)&63;o=(n<<2|r>>6)&63;u=r&63;c+=a.charAt(i)+a.charAt(s)+a.charAt(o)+a.charAt(u);f+=3}f=l%3;l=c.length;f===1?c=c.substr(0,l-2)+"==":f===2&&(c=c.substr(0,l-1)+"=");return c}}window.Debug=Debug;Debug.init()}).call(this);`


### --------------------------------------------
     Begin EventDispatcher.coffee
-------------------------------------------- ###

class EventDispatcher
	on:(evt, handler)->
		if !@_events
			@_events = {}
		if !@_events[evt]
			@_events[evt] = []
		if !(handler in @_events[evt])
			@_events[evt].unshift(handler)
	off:(evt = null, handler = null)->
		if !@_events
			@_events = {}
		if !evt
			@_events = {}
			return
		if events = @_events[evt]
			if !handler
				@_events[evt].length = 0
			else
				while (i = events.indexOf(handler)) >= 0
					events.splice(i, 1)
				@_events[evt] = events
	trigger:(evt, data = null)=>
		if !@_events
			@_events = {}
		events = @_events[evt]
		if !events || events.length == 0
			return
		e = {type: evt, target: @, currentTarget: @}
		if typeof(data) == 'object'
			for k, v of data
				if !e[k]
					e[k] = v
		i = events.length
		while i-- > 0
			events[i]?(e, data)
class EventUtils
	@init:()->
		if document.addEventListener
			@_eventAdder = @_addEventListener
			@_eventRemover = @_removeEventListener
		else if document.attachEvent
			@_eventAdder = @_attachEvent
			@_eventRemover = @_detachEvent
		else
			@_eventAdder = @_callbackFunction
			@_eventRemover = @_removeCallbackFunction
	@on:(target, eventName, callback)->
		@_eventAdder(target, eventName, callback)
	@_addEventListener:(target, eventName, callback)->
		target.addEventListener(eventName, callback, false)
	@_attachEvent:(target, eventName, callback)->
		target.attachEvent('on' + eventName, callback)
	@_callbackFunction:(target, eventName, callback)->
		target['on' + eventName] = callback

	@off:(target, eventName, callback)->
		@_eventRemover(target, eventName, callback)
	@_removeEventListener:(target, eventName, callback)->
		target.removeEventListener(eventName, callback, false)
	@_detachEvent:(target, eventName, callback)->
		target.detachEvent('on' + eventName, callback)
	@_removeCallbackFunction:(target, eventName, callback)->
		if target['on' + eventName] == callback
			target['on' + eventName] = null

EventUtils.init()

### --------------------------------------------
     Begin MainAnim.coffee
-------------------------------------------- ###

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