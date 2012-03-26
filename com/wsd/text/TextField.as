﻿package com.wsd.text{	import com.wsd.Base	import com.wsd.View		import flash.text.TextField	import flash.text.TextFormat	import flash.text.TextFormatAlign		public class TextField extends View	{		private var textField:flash.text.TextField = new flash.text.TextField				public function TextField(options:Object = null)		{			var txtFormat:TextFormat = new TextFormat()						if (options == null)			options = new Object						switch(options.align) {				case 'right':					options.align = TextFormatAlign.RIGHT				break;				case 'left':					options.align = TextFormatAlign.LEFT				break;				default:					options.align = TextFormatAlign.CENTER				break;			}						txtFormat.size = (options.size == null ? 20 : options.size)			txtFormat.align = options.align						if (options.fontFamily == null)	txtFormat.font = options.fontFamily						textField.defaultTextFormat = txtFormat			textField.textColor = (options.color == null ? 0x000000 : options.color)			textField.selectable = (options.selectable == null ? false : options.selectable)			textField.wordWrap = (options.wordWrap == null ? false : options.wordWrap)			textField.border = (options.border == null ? false : options.border)			textField.width = (options.width == null ? 200 : options.width)			textField.height = (options.height == null ? 50 : options.height)			x = (options.x == null ? x : options.x)			y = (options.y == null ? y : options.y)						addChild(textField)		}				public function set(text:String):void		{			textField.text = text						Base.log('TextField::set(' + textField.text + ')')		}				public function get():String		{			return textField.text		}	}}