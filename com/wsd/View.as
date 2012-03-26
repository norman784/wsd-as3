﻿package com.wsd{	import flash.display.MovieClip	import flash.events.Event	import flash.events.MouseEvent		public class View extends MovieClip	{		private var buttons:Array = []		private var actions:Array = []				public function View(callback = null):void		{			super()						if (callback == null) callback = function(e:Event = null) { removeEventListener(Event.ADDED_TO_STAGE, callback) }						if (stage)		callback()			else			addEventListener(Event.ADDED_TO_STAGE, callback)						addEventListener(Event.REMOVED_FROM_STAGE, removeListeners)			addEventListener(Event.REMOVED_FROM_STAGE, removeMouseListeners)		}				private function removeListeners( e:Event = null ):void		{					}				public function addMouseEvent(button, action, removeEventOnClick:Boolean = false):void		{			buttons.push(button)			actions.push(action)						button.addEventListener(MouseEvent.CLICK, action)						if (removeEventOnClick == true) {				var callback = function(e:MouseEvent) {					button.removeEventListener(MouseEvent.CLICK, action)					button.removeEventListener(MouseEvent.CLICK, callback)										Base.log('View::removeMouseListeners(removedListener ' + button + ')')				}								button.addEventListener(MouseEvent.CLICK, callback)			}		}				public function mouseEvents(buttons:Array, actions:Array, removeEventOnClick:Boolean = false)		{			for (var i:Number = 0; i < buttons.length; ++i)			{				addMouseEvent(buttons[i], actions[i], removeEventOnClick)				buttons[i].addEventListener(MouseEvent.CLICK, actions[i])			}		}				private function removeMouseListeners( e:Event = null ):void		{			for (var i:Number = 0; i < buttons.length; ++i)			{				if (!buttons[i].hasEventListener(MouseEvent.CLICK)) continue								Base.log('View::removeMouseListeners(removedListener ' + buttons[i] + ')')								buttons[i].removeEventListener(MouseEvent.CLICK, actions[i])			}		}	}}