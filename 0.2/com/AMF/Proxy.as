/**
 * Class Proxy
 *
 *
 *
 * private function successHandler(e:Event):void {
 * 	trace(e.target.response);
 * }
 * 
 * private function errorHandler(e:Event):void {
 * 	trace("Error...");
 * }
 * 
 * 
 * var service = new AMFProxy('http://www.example.com/amfphp/gateway.php');
 * service.addEventListener(AMFProxy.SUCCESS, successHandler);
 * service.addEventListener(AMFProxy.ERROR, errorHandler);
 * 
 * service.call("sections.blog", {arg: 1, arv: 2});
 */

package com.AMF {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	
	import flash.net.NetConnection;
	import flash.net.Responder;
	

	public class Proxy extends EventDispatcher {

		static public const SUCCESS:String = "success";
		static public const ERROR:String = "error";
		
		private var gw_url:String;
		
		public function Proxy(gw_url) {
			this.gw_url = gw_url;
		}

		public function call(gw_method:String, args:Object=null):void {
			var responder:Responder = new Responder(onResult, onFault);
			var gateway:NetConnection = new NetConnection();
			
			gateway.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
			
			try {
				gateway.connect(gw_url);
				
				gateway.call(gw_method, responder, args);
			} catch (e:Error) {
				ErrorHandler("Can't connect.");
			}
		}
		
		public var response:Object;
		private function onResult(res:Object=null):void {
			this.response = res;
			this.dispatchEvent(new Event(SUCCESS));
		}
		
		private function onFault(fault:Object):void { 
			ErrorHandler(String(fault.description)); 
		}
		
		private function onFlushStatus(e:NetStatusEvent):void {
			switch(e.info.code) {
				case "NetConnection.Call.Failed" :
					ErrorHandler("NetConnection.Call.Failed");
				break;
			}
		}
		
		private function ErrorHandler(message:String):void {
			trace("AMFProxy :: Error:", message);
			this.dispatchEvent(new Event(ERROR));
		}

	}
}