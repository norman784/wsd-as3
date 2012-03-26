package com.wsd.display
{
	import com.wsd.View
	
	import flash.text.TextField
	import flash.text.TextFormat
	import flash.text.TextFormatAlign
	
	public class Button extends View
	{
		private var caption:TextField 	= new TextField
		
		public function Button(caption:String, action:Function, options:Object = {})
		{
			this.caption = caption
			
			setFormat(options)
		}
		
		private function setFormat(options):void
		{
			var txtFormat:TextFormat = new TextFormat()
			
			
			
			if (options.size == null) options.size = 15
			if (options.fontFamily == null) options.fontFamily = ''
			if (options.color == null) options.color = 0x000000
			
			switch(options.align) {
				case 'right':
					options.align = TextFormatAlign.RIGHT
				break;
				case 'left':
					options.align = TextFormatAlign.LEFT
				break;
				default:
					options.align = TextFormatAlign.CENTER
				break;
			}
			
			
			txtFormat.size = options.size
			txtFormat.align = options.align
			txtFormat.font = options.fontFamily
			
			caption.defaultTextFormat = txtMsgFormat
			caption.textColor = options.color
			caption.selectable = false
			caption.wordWrap = false
		}
		
		/*
		var button = new View()
		
		var textBoxRectangleWidth:int = 100
		var textBoxRectangleHeight:int = 50
		var textBoxRectangleX:int = box.x + (box.width / 2) / buttons.length + textBoxRectangleWidth / 2
		var textBoxRectangleY:int = box.y + box.height - 50
		var textBoxRectangle:Shape = new Shape()
		textBoxRectangle.graphics.beginFill(0xCCCCCC, 1)
		textBoxRectangle.graphics.drawRoundRect(textBoxRectangleX, textBoxRectangleY, textBoxRectangleWidth, textBoxRectangleHeight, 10, 10)
		textBoxRectangle.graphics.endFill()

		button.addChild(textBoxRectangle)
		
		// Set textarea format
		var txtMsgFormat:TextFormat = new TextFormat()
		txtMsgFormat.size = 20
		txtMsgFormat.align = TextFormatAlign.CENTER

		if (fontFamily) txtMsgFormat.font = fontFamily.fontName

		// Draw textarea
		var txtMsg2:TextField = new TextField
		txtMsg2.defaultTextFormat = txtMsgFormat
		txtMsg2.width = textBoxRectangleWidth - 20
		txtMsg2.height = textBoxRectangleHeight / 4
		txtMsg2.x = (textBoxRectangleWidth / 2) - (txtMsg2.width / 2)
		txtMsg2.y = (textBoxRectangleHeight / 2) - (txtMsg2.height / 2)
		txtMsg2.selectable = false
		txtMsg2.wordWrap = true
		txtMsg2.textColor = txtColor

		button.addChild(txtMsg2)
		
		txtMsg2.text = element.name
		
		var _this = this
		var callback = function( e:MouseEvent ):void
		{
			button.removeEventListener(MouseEvent.CLICK, callback)
			_this.removeChild(button)
		}
		
		button.addEventListener(MouseEvent.CLICK, callback)
		*/
	}
}