﻿package com.wsd.display{	import com.wsd.anim.Loading	import com.wsd.Base	import com.wsd.display.Rectangle	import com.wsd.text.TextField	import com.wsd.View		import com.greensock.TweenLite		import flash.display.MovieClip	import flash.events.Event	import flash.events.MouseEvent	import flash.utils.getDefinitionByName;		public class Overlay extends View	{		private var containers:Object			= new Object		private var options:Object				= new Object				public function Overlay(txtOpt = null, overlayOpt = null):void		{			super(function(){				if (txtOpt == null)					txtOpt = new Object				if (overlayOpt == null)				overlayOpt = new Object				if (overlayOpt.width == null) 		overlayOpt.width = 500				if (overlayOpt.height == null) 		overlayOpt.height = 200				if (overlayOpt.overlay == null)		overlayOpt.overlay = 0x000000				if (overlayOpt.background == null)	overlayOpt.background = 0xFFFFFF								var classRef				var overlayTmp								// Add the overlay background				if (typeof(overlayOpt.overlay) == 'number')					overlayTmp = new Rectangle(0, 0, stage.width, stage.height, overlayOpt.overlay, 0, .56)				else {					classRef = getDefinitionByName(overlayOpt.background)					overlayTmp = new classRef					overlayTmp.width = stage.width					overlayTmp.height = stage.height				}								addChild(overlayTmp)								// Add the overlay box				if (typeof(overlayOpt.background) == 'number')					containers.box = new Rectangle((stage.width - overlayOpt.width) / 2, (stage.height - overlayOpt.height) / 2, overlayOpt.width, overlayOpt.height, overlayOpt.background, 25)				else {					classRef = getDefinitionByName(overlayOpt.background)					containers.box = new classRef					containers.box.width = overlayOpt.width					containers.box.height = overlayOpt.height					containers.box.x = (stage.width - overlayOpt.width) / 2					containers.box.y = (stage.height - overlayOpt.height) / 2				}								addChild(containers.box)								// Add the overlay text				txtOpt.x = containers.box.x + 25				txtOpt.y = containers.box.y + 25				txtOpt.width = containers.box.width - 50				txtOpt.height = containers.box.height - 50								containers.text = new TextField(txtOpt)								addChild(containers.text)								// Add the overlay loading				containers.loader = new MovieClip								for (var i:Number = 0; i < 3; ++i)					containers.loader.addChild(new Rectangle((i * 5), 0, 3, 8, 0x000000, 1, .5, true))								containers.loader.x = (stage.width - containers.loader.width) / 2				containers.loader.y = (stage.height - containers.loader.height) / 2								addChild(containers.loader)								// Add the button container				containers.buttons = new MovieClip				addChild(containers.buttons)								// Save some options so later we can change it and/or revert to the initial values				options.text = new Object				options.text.x = txtOpt.x				options.text.y = txtOpt.y				options.text.width = txtOpt.width				options.text.height = txtOpt.height								hide()			})		}				public function show(text:String, hideOnClick:* = false, loader:Boolean = false):void		{			Base.log('Base.overlay.show(' + text + ')')			//var _this = this			//var callback						visible = true			containers.text.x = options.text.x			containers.text.y = options.text.y						containers.text.set(text)						if (loader) showLoading()						trace(typeof(hideOnClick))						if (hideOnClick == false) return			else if (typeof(hideOnClick) == 'array' || typeof(hideOnClick) == 'object') {				doButtons(hideOnClick)			}			/*			else if (typeof(hideOnClick) == 'function') {				callback = function( e:MouseEvent ):void				{					if (typeof(hideOnClick) == 'function') hideOnClick()					_this.hide()					_this.removeEventListener(MouseEvent.CLICK, callback)				}				addEventListener(MouseEvent.CLICK, callback)			}			*/		}				private function showLoading():void		{			containers.loader.visible = true						if (containers.text.get() == '') return						var from = containers.loader						for (var i:Number = 0; i < from.numChildren; ++i) {				var el = from.getChildAt(i).shape				el.scaleX = el.scaleY = 1				el.alpha = .5			}						animateLoading(from)						containers.text.y = containers.loader.y + containers.loader.height + 25		}				private function animateLoading(from, index:Number = 0):void		{			if (index >= from.numChildren) index = 0						var el = from.getChildAt(index).shape						el.alpha = 1						TweenLite.to(el, .5, {scaleX: 1.5, scaleY:1.5, onComplete:function(){				el.scaleX = el.scaleY = 1				el.alpha = .5								animateLoading(from, index+1)			}})		}				public function hide():void		{			visible = false			if (containers.loader != null) containers.loader.visible = false			if (containers.buttons != null) {				var from = containers.buttons							while(from.numChildren>0)				{					from.removeChildAt(from.numChildren-1)				}			}		}				private function doButtons(buttons):void		{			buttons.map(function(element:*, index:int, arr:*){				var button = new View								var xSpacing = (((containers.box.width) / (arr.length)) / 2)				var rectangle = new Rectangle(0, 0, 100, 50, 0x2E2E2E, 10)				rectangle.x = (containers.box.x + xSpacing * index + xSpacing + rectangle.width * index) - (rectangle.width/2)				rectangle.y = (containers.box.y + containers.box.height) - (rectangle.height + 20)								var tmpOptions = new Object				tmpOptions.color = 0xFFFFFF				tmpOptions.width = (rectangle.width-20)				tmpOptions.height = (rectangle.height-10)				tmpOptions.x = rectangle.x + 10				tmpOptions.y = rectangle.y + 10				var txt = new TextField(tmpOptions)				txt.set(element.name)				button.addChild(rectangle)				button.addChild(txt)				containers.buttons.addChild(button)								var _this = this				var callback = function( e:MouseEvent ):void				{					element.action()					button.removeEventListener(MouseEvent.CLICK, callback)				}								button.addEventListener(MouseEvent.CLICK, callback)			})					}	}}