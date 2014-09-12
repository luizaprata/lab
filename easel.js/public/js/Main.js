// Generated by CoffeeScript 1.6.3
(function() {
  (function(){var Browser,Debug,__slice=[].slice;String.prototype.ltrim=function(e){var t;e==null&&(e=null);e||(e="s");t=new RegExp("^"+e+"*");t.global=!0;t.multiline=!0;return this.replace(t,"")};String.prototype.rtrim=function(e){var t;e==null&&(e=null);e||(e="s");t=new RegExp(e+"*$");t.global=!0;t.multiline=!0;return this.replace(t,"")};String.prototype.trim=function(e){e==null&&(e=null);return this.ltrim(e).rtrim(e)};String.prototype.toCamelCase=function(){var e;e=this.replace(/([\+\-_ ][a-z])/g,function(e){return e.toUpperCase().replace(/[\+\-_ ]/,"")});return e.charAt(0).toUpperCase()+e.slice(1)};Debug=function(){function Debug(){}Debug.debug=!1;Debug.light=4764196;Debug.dark=2884445;Debug.init=function(){var re,_ref;Debug._console=window.console;try{Debug._log=Function.prototype.bind.call((_ref=Debug._console)!=null?_ref.log:void 0,Debug._console)}catch(_error){}window.Debug==null&&(window.Debug=Debug);Debug.check()||eval("window[Math.random()]()");re=new RegExp(/debug=(1|true)/i);Debug.debug=re.test(window.location.search);re=new RegExp(/debug=(0|false)/i);if(!Debug.debug&&!re.test(window.location.search)){re=new RegExp(/([\.|\/]local\.|localhost|127\.0\.0\.1|192\.\d+\.\d+\.\d+|dev\.slikland\.)/i);Debug.debug=re.test(window.location.href)}if(!Debug.debug||!window.console)window.console={assert:function(){},clear:function(){},count:function(){},debug:function(){},dir:function(){},dirxml:function(){},error:function(){},exception:function(){},group:function(){},groupCollapsed:function(){},groupEnd:function(){},info:function(){},log:function(){},profile:function(){},profileEnd:function(){},table:function(){},time:function(){},timeEnd:function(){},timeStamp:function(){},trace:function(){},warn:function(){}};return Debug.browser=new Browser};Debug.check=function(e){var t,n,r,i;e==null&&(e=null);r="";t="";n=this.light;while(n>0){t=String.fromCharCode(n&255)+t;n>>=8}r+=btoa(t);t="";n=this.dark;while(n>0){t=String.fromCharCode(n&255)+t;n>>=8}r+=btoa(t);i=r.toLowerCase();return e?i===e.toLowerCase():i.charAt(0)==="s"&&i.charAt(1)==="l"};Debug.checkBrowser=function(e){return this.browser.checkBrowser(e)};Debug.log=function(){if(Debug._log!=null)return typeof Debug._log=="function"?Debug._log.apply(Debug,arguments):void 0;try{return console.log.apply(console,arguments)}catch(e){}};Debug.logTime=function(){var e,t,n,r,i,s;e=1<=arguments.length?__slice.call(arguments,0):[];i=(new Date).getTime();this.initTime||(this.initTime=this.currentTime=i);n=i-this.currentTime;s=n.toString();while(s.length<6)s=" "+s;t=s+"|";s=(this.currentTime-this.initTime).toString();while(s.length<6)s=" "+s;t+=s;t=["%c"+t+":"];r="font-weight: bold;";n>100?r+="color: red;":n>50&&(r+="color: orange;");t.push(r);Debug.log.apply(this,[].concat(t,e));return this.currentTime=i};return Debug}.call(this);Browser=function(){function t(){var t,n,r;this.matched=null;this.ua=(typeof navigator!="undefined"&&navigator!==null?navigator.userAgent:void 0)||"";this.os=navigator.platform||"";this.ios=e(/(ipod|iphone|ipad)/i,this.ua);this.tablet=/(ipad.*|tablet.*|(android.*?chrome((?!mobi).)*))$/i.test(this.ua);this.mobile=!this.tablet&&(this.ios||/[^-]mobi/i.test(this.ua));this.version=e(/version\/(\d+(\.\d+)*)/i,this.ua);this.getBrowser();this.versionArr=this.version.split(".");r=this.versionArr;for(t in r){n=r[t];this.versionArr[t]=Number(n)}}var e;t.prototype.matches=[{name:"Opera",nick:/opera/i,test:/opera|opr/i,version:/(?:opera|opr)[\s\/](\d+(\.\d+)*)/i},{name:"Windows Phone",nick:/WindowsPhone/i,test:/windows phone/i,version:/iemobile\/(\d+(\.\d+)*)/i},{name:"Internet Explorer",nick:/explorer|internetexplorer|ie/i,test:/msie|trident/i,version:/(?:msie |rv:)(\d+(\.\d+)*)/i},{name:"Chrome",nick:/Chrome/i,test:/chrome|crios|crmo/i,version:/(?:chrome|crios|crmo)\/(\d+(\.\d+)*)/i},{name:"iPod",nick:/iPod/i,test:/ipod/i},{name:"iPhone",nick:/iPhone/i,test:/iphone/i},{name:"iPad",nick:/iPad/i,test:/ipad/i},{name:"FirefoxOS",nick:/FirefoxOS|ffos/i,test:/\((mobile|tablet);[^\)]*rv:[\d\.]+\)firefox|iceweasel/i,version:/(?:firefox|iceweasel)[ \/](\d+(\.\d+)?)/i},{name:"Firefox",nick:/Firefox|ff/i,test:/firefox|iceweasel/i,version:/(?:firefox|iceweasel)[ \/](\d+(\.\d+)?)/i},{name:"Android",nick:/Android/i,test:/android/i},{name:"BlackBerry",nick:/BlackBerry/i,test:/(blackberry)|(\bbb)|(rim\stablet)\d+/i,version:/blackberry[\d]+\/(\d+(\.\d+)?)/i},{name:"WebOS",nick:/WebOS/i,test:/(web|hpw)os/i,version:/w(?:eb)?osbrowser\/(\d+(\.\d+)?)/i},{name:"Safari",nick:/safari/i,test:/safari/i}];t.prototype.checkBrowser=function(e){var t,n,r,i,s,o,u;if(!this.matched)return 0;if(!(r=e.match(/(?:(?:(\D.*?)(?:\s|$))?(\D.*?)(?:\s|$))?(?:([\d\.]+))?/)))return 0;i=0;if(r[1]){if(!(new RegExp(r[1],"i")).test(this.os))return 0;i=1}if(r[2]){if((u=this.matched.nick)!=null?!u.test(r[2]):!void 0)return 0;i=1}if(r[3]){s=r[3].split(".");n=s.length;n>this.versionArr.length&&(n=this.versionArr.length);for(t=o=0;0<=n?o<=n:o>=n;t=0<=n?++o:--o){if(this.versionArr[t]>s[t])return 2;if(this.versionArr[t]<s[t])return-1}}return i};t.prototype.getBrowser=function(){var t,n,r,i,s;i=this.matches;s=[];for(n=0,r=i.length;n<r;n++){t=i[n];if(t.test.test(this.ua)){this.name=t.name;this.version=this.version||e(t.version,this.ua);this.matched=t;break}s.push(void 0)}return s};e=function(e,t){var n;n=t.match(e);return n&&n.length>1&&n[1]||null};return t}();if(!window.atob){window.atob=function(e){var t,n,r,i,s,o,u,a,f,l,c;a="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";l=e.length;f=0;c="";while(f<l){i=e.charAt(f);s=e.charAt(f+1);o=e.charAt(f+2);u=e.charAt(f+3);i=a.indexOf(i);s=a.indexOf(s);o=a.indexOf(o);u=a.indexOf(u);o<0&&(o=0);u<0&&(u=0);t=i<<2&255|s>>4;n=s<<4&255|o>>2;r=o<<6&255|u&63;c+=String.fromCharCode(t);c+=String.fromCharCode(n);c+=String.fromCharCode(r);f+=4}return c};window.btoa=function(e){var t,n,r,i,s,o,u,a,f,l,c;a="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";l=e.length;f=0;c="";while(f<l){t=e.charCodeAt(f+0)&255;n=e.charCodeAt(f+1)&255;r=e.charCodeAt(f+2)&255;i=t>>2&63;s=(t<<4|n>>4)&63;o=(n<<2|r>>6)&63;u=r&63;c+=a.charAt(i)+a.charAt(s)+a.charAt(o)+a.charAt(u);f+=3}f=l%3;l=c.length;f===1?c=c.substr(0,l-2)+"==":f===2&&(c=c.substr(0,l-1)+"=");return c}}window.Debug=Debug;Debug.init()}).call(this);;
  /* --------------------------------------------
       Begin EventDispatcher.coffee
  --------------------------------------------
  */

  var EventDispatcher, EventUtils, Main, init,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  EventDispatcher = (function() {
    function EventDispatcher() {
      this.trigger = __bind(this.trigger, this);
    }

    EventDispatcher.prototype.on = function(evt, handler) {
      if (!this._events) {
        this._events = {};
      }
      if (!this._events[evt]) {
        this._events[evt] = [];
      }
      if (!(__indexOf.call(this._events[evt], handler) >= 0)) {
        return this._events[evt].unshift(handler);
      }
    };

    EventDispatcher.prototype.off = function(evt, handler) {
      var events, i;
      if (evt == null) {
        evt = null;
      }
      if (handler == null) {
        handler = null;
      }
      if (!this._events) {
        this._events = {};
      }
      if (!evt) {
        this._events = {};
        return;
      }
      if (events = this._events[evt]) {
        if (!handler) {
          return this._events[evt].length = 0;
        } else {
          while ((i = events.indexOf(handler)) >= 0) {
            events.splice(i, 1);
          }
          return this._events[evt] = events;
        }
      }
    };

    EventDispatcher.prototype.trigger = function(evt, data) {
      var e, events, i, k, v, _results;
      if (data == null) {
        data = null;
      }
      if (!this._events) {
        this._events = {};
      }
      events = this._events[evt];
      if (!events || events.length === 0) {
        return;
      }
      e = {
        type: evt,
        target: this,
        currentTarget: this
      };
      if (typeof data === 'object') {
        for (k in data) {
          v = data[k];
          if (!e[k]) {
            e[k] = v;
          }
        }
      }
      i = events.length;
      _results = [];
      while (i-- > 0) {
        _results.push(typeof events[i] === "function" ? events[i](e, data) : void 0);
      }
      return _results;
    };

    return EventDispatcher;

  })();

  EventUtils = (function() {
    function EventUtils() {}

    EventUtils.init = function() {
      if (document.addEventListener) {
        this._eventAdder = this._addEventListener;
        return this._eventRemover = this._removeEventListener;
      } else if (document.attachEvent) {
        this._eventAdder = this._attachEvent;
        return this._eventRemover = this._detachEvent;
      } else {
        this._eventAdder = this._callbackFunction;
        return this._eventRemover = this._removeCallbackFunction;
      }
    };

    EventUtils.on = function(target, eventName, callback) {
      return this._eventAdder(target, eventName, callback);
    };

    EventUtils._addEventListener = function(target, eventName, callback) {
      return target.addEventListener(eventName, callback, false);
    };

    EventUtils._attachEvent = function(target, eventName, callback) {
      return target.attachEvent('on' + eventName, callback);
    };

    EventUtils._callbackFunction = function(target, eventName, callback) {
      return target['on' + eventName] = callback;
    };

    EventUtils.off = function(target, eventName, callback) {
      return this._eventRemover(target, eventName, callback);
    };

    EventUtils._removeEventListener = function(target, eventName, callback) {
      return target.removeEventListener(eventName, callback, false);
    };

    EventUtils._detachEvent = function(target, eventName, callback) {
      return target.detachEvent('on' + eventName, callback);
    };

    EventUtils._removeCallbackFunction = function(target, eventName, callback) {
      if (target['on' + eventName] === callback) {
        return target['on' + eventName] = null;
      }
    };

    return EventUtils;

  })();

  EventUtils.init();

  /* --------------------------------------------
       Begin Main.coffee
  --------------------------------------------
  */


  Main = (function(_super) {
    __extends(Main, _super);

    Main.prototype.canvas = null;

    Main.prototype.stage = null;

    Main.prototype.canvasContext = null;

    Main.prototype.update = false;

    Main.prototype.items = null;

    Main.prototype.frameCount = 0;

    Main.prototype.container = null;

    Main.prototype.image = null;

    Main.prototype.linha = 0;

    function Main() {
      this.tick = __bind(this.tick, this);
      this.addNewItems = __bind(this.addNewItems, this);
      this.handleImageLoad = __bind(this.handleImageLoad, this);
      this.clickBtnADD = __bind(this.clickBtnADD, this);
      this.canvas = $('.sketch')[0];
      this.canvas.width = window.innerWidth;
      this.canvas.height = window.innerHeight;
      this.stage = new createjs.Stage(this.canvas);
      this.canvasContext = this.canvas.getContext('2d');
      this.image = new Image();
      this.image.src = 'assets/items.png';
      this.image.onload = this.handleImageLoad;
      createjs.Ticker.setFPS(60);
      createjs.Ticker.addEventListener('tick', this.tick);
      $("input[name='btn1']").on('click', this.clickBtnADD);
      return false;
    }

    Main.prototype.clickBtnADD = function(e) {
      this.addNewItems();
      return false;
    };

    Main.prototype.handleImageLoad = function(e) {
      this.spriteList = [];
      this.container = new createjs.Container();
      this.stage.addChild(this.container);
      this.ss = new createjs.SpriteSheet({
        images: [this.image],
        frames: {
          width: 16,
          height: 16,
          regX: 8,
          regY: 8
        },
        animations: {
          walk: [0, 1, true]
        }
      });
      this.sprite = new createjs.Sprite(this.ss, "walk");
      this.addNewItems(1000);
      return false;
    };

    Main.prototype.addNewItems = function(p) {
      var h, i, phi, sphereRad, theta, w, x0, y0, _i;
      if (p == null) {
        p = 1000;
      }
      w = this.canvas.width / 2;
      h = this.canvas.height / 2;
      sphereRad = 280;
      for (i = _i = 0; 0 <= p ? _i < p : _i > p; i = 0 <= p ? ++_i : --_i) {
        this.sprite.name = "item" + i;
        this.sprite.speed = 2;
        this.sprite.vX = this.sprite.speed;
        this.sprite.vY = 0;
        theta = Math.random() * 2 * Math.PI;
        phi = Math.acos(Math.random() * 2 - 1);
        x0 = sphereRad * Math.sin(phi) * Math.cos(theta);
        y0 = sphereRad * Math.sin(phi) * Math.sin(theta);
        this.sprite.x = w + x0;
        this.sprite.y = h + y0;
        this.sprite.currentAnimationFrame = (Math.random() * 3) >> 0;
        this.container.addChild(this.sprite);
        this.sprite.gotoAndPlay("walkRt");
        console.log(this.ss.getNumFrames("walkRt"), this.sprite.currentAnimationFrame);
        this.spriteList.push(this.sprite);
        if (i < p - 1) {
          this.sprite = this.sprite.clone();
        }
      }
      return false;
    };

    Main.prototype.tick = function(e) {
      this.stage.update(e);
      return false;
    };

    return Main;

  })(EventDispatcher);

  init = function() {
    var main;
    return main = new Main();
  };

  $(window).ready(init);

}).call(this);
