package com.wsd.display
{
	import com.wsd.View;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Overlay extends View
	{
		private var txtMsg:TextField 	= new TextField;
		private var txtColor			= 0x000000;
		private var labelBackground		= 0xFFFFFF;
		private var fontFamily;
		
		public function Overlay(fontFamily = null, txtColor = null, labelBackground = null):void
		{
			if (fontFamily != null) this.fontFamily = fontFamily;
			if (txtColor != null) this.txtColor = txtColor;
			if (labelBackground != null) this.labelBackground = labelBackground;
			
			addEventListener(Event.ADDED_TO_STAGE, drawUI);
		}
		
		private function drawUI( e:Event ):void
		{
			// Draw the overlay background
			var overlayRectangle:Shape = new Shape();
			overlayRectangle.graphics.beginFill(0x000000, 1);
			overlayRectangle.graphics.drawRect(0, 0, stage.width, stage.height);
			overlayRectangle.graphics.endFill();
			overlayRectangle.alpha = .76;
			addChild(overlayRectangle);
			
			// Draw the overlay box background;
			var textBoxRectangleWidth:int = 500;
			var textBoxRectangleHeight:int = 200;
			var textBoxRectangleX:int = (stage.width - textBoxRectangleWidth) / 2;
			var textBoxRectangleY:int = (stage.height - textBoxRectangleHeight) / 2;
			var textBoxRectangle:Shape = new Shape();
			textBoxRectangle.graphics.beginFill(labelBackground, 1);
			textBoxRectangle.graphics.drawRoundRect(textBoxRectangleX, textBoxRectangleY, textBoxRectangleWidth, textBoxRectangleHeight, 25, 25);
			textBoxRectangle.graphics.endFill();
			
			addChild(textBoxRectangle);
			
			// Set textarea format
			var txtMsgFormat:TextFormat = new TextFormat();
			txtMsgFormat.size = 20;
			txtMsgFormat.align = TextFormatAlign.CENTER;
			
			if (fontFamily) txtMsgFormat.font = fontFamily.fontName;
			
			// Draw textarea
			txtMsg.defaultTextFormat = txtMsgFormat;
			txtMsg.width = textBoxRectangleWidth - 20;
			txtMsg.height = textBoxRectangleHeight / 4;
			txtMsg.x = (stage.width / 2) - (txtMsg.width / 2);
			txtMsg.y = (stage.height / 2) - (txtMsg.height / 2);
			txtMsg.selectable = false;
			txtMsg.wordWrap = true;
			txtMsg.textColor = txtColor;
			
			addChild(txtMsg);
		}
		
		public function show(msg:String, hideOnClick:Boolean = false):void
		{
			visible = true;
			txtMsg.text = msg;
			
			if (hideOnClick == false) return;
			
			var _this = this;
			var callback = function( e:MouseEvent ):void
			{
				_this.hide();
				_this.removeEventListener(MouseEvent.CLICK, callback);
			}
			
			addEventListener(MouseEvent.CLICK, callback);
		}
		
		public function hide():void
		{
			visible = false;
		}
	}
}