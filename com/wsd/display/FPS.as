﻿package com.wsd.display{	import com.wsd.View	import com.wsd.text.TextField		import flash.events.Event	import flash.system.System	import flash.utils.getTimer		public class FPS extends View	{		private var txtFPS:TextField		private var txtMEM:TextField		private var frames:int			= 0		private var prevTimer:Number	= 0		private var curTimer:Number		= 0				public function FPS()		{			var container = new Rectangle(0, 0, 100, 50)			addChild(container)						var options:Object = new Object			options.size = 10			options.x = container.x + 10			options.y = container.y + 10			options.width = container.width - 20			options.height = container.height/2 - 10 						txtFPS = new TextField(options)			addChild(txtFPS)						options.y = (container.height/2 + 20) - options.height			txtMEM = new TextField(options)						addChild(txtMEM)						addEventListener(Event.ENTER_FRAME, update)		}				private function update( e:Event ):void		{			++frames						curTimer = getTimer()						if (curTimer-prevTimer>=1000) {				txtFPS.set("FPS: " + ( Math.round( frames * 1000 / ( curTimer - prevTimer ) ) ))				prevTimer = curTimer				frames = 0			}						txtMEM.set("MEM: " + ( Math.round( 1000 * System.totalMemory / 1048576 ) / 1000 ) + "mb")		}	}}