package com.wsd
{
	import flash.display.MovieClip;
	import flash.net.SharedObject;
	
	public class Recordset extends MovieClip
	{
		public static var userData:SharedObject = SharedObject.getLocal('UserData');
		
		public function Recordset():void
		{
			
		}
		
		public static function set(table:String, data:Object):void
		{
			userData.data[table] = data;
			userData.flush();
		}
		
		public static function get(table:String):void
		{
			if (userData.data[table] == null) userData.data[table] = new Object;
			return userData.data[table];
		}
	}
}