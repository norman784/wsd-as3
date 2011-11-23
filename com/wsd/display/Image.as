package com.wsd.display
{
	public class Image
	{
		private var target:Object;
		private var loader:Loader = new Loader();
		
		public function Image(url:String, target:Object):void
		{
			this.target = target;
			
			loader.load(new URLRequest(url));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
		}
		
		private function loaded( e:Event ):void
		{
			target.addChild(loader);
		}
	}
}