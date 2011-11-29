package com.wsd
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class View extends MovieClip
	{
		public function View(callback = null):void
		{
			super();
			
			if (callback == null) callback = function(e:Event){
				removeEventListener(Event.ADDED_TO_STAGE, callback);
			};
			
			addEventListener(Event.ADDED_TO_STAGE, callback);
			addEventListener(Event.REMOVED_FROM_STAGE, removeListeners);
		}
		
		private function removeListeners( e:Event = null ):void
		{
			
		}
	}
}