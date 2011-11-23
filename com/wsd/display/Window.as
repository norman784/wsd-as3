package com.wsd.display
{
	import com.wsd.display.Image;
	
	public class Window extends MovieClip
	{
		private var texture;
		
		private var btnClose:MovieClip;
		
		private var title:TextField 			= new TextField();
		
		private var winTopBorder:MovieClip;
		private var winLeftBorder:MovieClip;
		private var winBottomBorder:MovieClip;
		private var winRightBorder:MovieClip;
		private var winBackground:MovieClip;
		
		public function Window(title:String, content:Object, width:int, height:int, texture = null):void
		{
			if (texture == null) texture = Base.config.app.window;
			
			this.texture = texture;
			
			setTexture(texture);
			setSize(width, height);
			setTitle(title);
			
			addChild(content);
			
			content.width = width - 40;
			content.height = height - 60;
			content.x = 20;
			content.y = 40;
		}
		
		private function setTitle(title:String):void
		{
			this.title.type = TextFieldType.INPUT;
			this.title.border = false;
			this.title.x = 10;
			this.title.y = 10;
			this.title.multiline = false;
			this.title.wordWrap = false;
			this.title.text = title;
			addChild(this.title);
		}
		
		private function setSize(width, height):void
		{
			winBackground.width = width;
			winBackground.height = height;
		}
		
		private function setTexture():void
		{
			var imageHelper:Image;
			var winBorder:MovieClip = new MovieClip;
			
			winBackground = new MovieClip;
			
			imageHelper = new Image(this.texture.border, winBorder);
			imageHelper = new Image(this.texture.background, winBackground);
			
			addChild(winBackground);
			addChild(winTopBorder);
			addChild(winLeftBorder);
			addChild(winBottomBorder);
			addChild(winBackground);
		}
	}
}