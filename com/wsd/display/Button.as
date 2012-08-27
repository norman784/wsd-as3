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
	}
}