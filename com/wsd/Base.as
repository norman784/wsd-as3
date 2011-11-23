package com.wsd
{
	import com.wsd.display.Overlay;
	import com.wsd.engine.AMF;
	
	import com.hurlant.crypto.CryptoCode;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ContextMenuEvent;
	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLLoader;
	import flash.system.Capabilities;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	public class Base extends MovieClip
	{
		public static var 	DEBUG:Boolean				= true;
		public static var 	LOG:Boolean					= true;
		
		public static var	app:Base;
		public static var	config:Object;
		public static var 	lua:Object;
		public static var	overlay:Overlay;
		
		public static var	constants:Object 			= new Object;
		public static var	platform					= null;
		public static var	status:Object				= new Object;
		
		public var 			container:MovieClip 		= new MovieClip;
		
		private var			callback					= null;
		private var			xmlLoader:URLLoader 		= new URLLoader();
		
		public function Base(config, callback = null):void
		{
			Base.log('Base::Base()');
			
			Base.app = this;
			Base.config = config;
			
			Base.status.OK 		= AMF.OK;
			Base.status.ERROR 	= AMF.ERROR;
			Base.status.EXPIRED = AMF.EXPIRED;
			
			Base.platform = Capabilities.playerType;
			
			this.callback = callback;
			
			addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
				if (typeof(config) != 'string') {
					init();
				} else {
					xmlLoader.addEventListener(Event.COMPLETE, initXML);
					xmlLoader.load(new URLRequest(config));
				}
			});
		}
		
		private function initXML(e:Event):void
		{
			Base.log('Base::initXML()');
			
			Base.config = new XML(e.target.data);
			
			init();
		}
		
		private function init():void
		{
			Base.log('Base::init()');
			
			if (Base.config.app != null) {
				Base.DEBUG 	= Base.config.app.debug == 'true' ? true : false;
				Base.LOG 	= Base.config.app.log == 'true' ? true : false;
			} else {
				Base.DEBUG 	= false;
				Base.LOG 	= false;
			}
			
			Base.overlay = new Overlay();
			Base.overlay.hide();
			
			if (Base.config.copyright != null && Base.config.url != null)
				set_contextual_menu(Base.config.copyright, Base.config.url);
			
			if (callback != null) callback();

			addChild(container);
			addChild(Base.overlay);
		}
		
		private function set_contextual_menu(author_copyright = null, author_url = null):void
		{
			if (author_copyright == null || author_url == null) return;
			
			var contextual_menu:ContextMenu = new ContextMenu();
			contextual_menu.hideBuiltInItems();
			
			var copyright:ContextMenuItem = new ContextMenuItem(author_copyright);
			copyright.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, function(e:Event){
				navigateToURL(new URLRequest(author_url), '_blank');
			});
			contextual_menu.customItems.push(copyright);
			this.contextMenu = contextual_menu;
		}
		
		public static function AMFconnect(params, callbackSuccess = null, callbackError = null, method:String = "modules.Main.initialize"):void
		{
			Base.log('Base::AMFconnect(domain = ' + Base.config.proxy.domain + ', gateway = ' + Base.config.proxy.gateway + ')');
			
			Base.constants.AMF = new Object;
			Base.constants.AMF.domain = Base.config.proxy.domain;
			Base.constants.AMF.gateway = Base.config.proxy.gateway;
			
			if (callbackSuccess == null) callbackSuccess = function( e:Event ) {
				Base.log('Base::AMFconnect(response = ' + e.target.response.status + ')');
				if(e.target.response && e.target.response.status == this.AMF.OK) {
					Base.overlay.show('Inicializado con exito');
				} else {
					Base.overlay.show('No se ha podido inicializar la aplicación, por favor inténtelo más tarde');
				}
				
				service.removeEventListener('success', callbackSuccess);
			}
			
			if (callbackError == null) callbackError = function( e:Event ) {
				Base.overlay.show('No se ha podido inicializar la aplicación, por favor inténtelo más tarde');
				service.removeEventListener('error', callbackError);
			}
			
			var service = AMF.service();
			service.addEventListener('success', callbackSuccess);
			service.addEventListener('error', callbackError);
			service.call(method, params);
		}
		
		public static function AMFcall(method, params, callbackSuccess = null, callbackError = null):void
		{
			Base.log('Base::AMFcall(method = ' + method + ')');
			
			if (callbackSuccess == null) callbackSuccess = function( e:Event ) {
				if(e.target.response && e.target.response.status == com.wsd.engine.AMF.OK) {
					Base.log('AMF::callbackSuccess');
					Base.overlay.show('Se ha realizado correctamente la conexión con el servidor');
				} else {
					Base.log('AMF::callbackSuccess ' + e.target.response.exception, 'ERROR');
					Base.overlay.show('Se ha perdido la conexión con el servidor, por favor inténtelo más tarde');
				}
				
				service.removeEventListener('success', callbackSuccess);
			}
			
			if (callbackError == null) callbackError = function( e:Event ) {
				Base.log('AMF::callbackError undefined');
				Base.overlay.show('Se ha perdido la conexión con el servidor, por favor inténtelo más tarde');
				service.removeEventListener('error', callbackError);
			}
			
			var service = AMF.service();
			service.addEventListener('success', callbackSuccess);
			service.addEventListener('error', callbackError);
			service.call(method, params);
		}
		
		public static function add(child, name = 'main', clearAll:Boolean = true):void
		{
			if (clearAll == true) Base.removeAll();
			
			Base.log('Base::add(child = ' + child + ', name = ' + name + ', clearAll = ' + clearAll + ')');
			
			Base.app.container.addChild(child);
			child.name = name;
		}
		
		public static function remove(name):void
		{
			Base.log('Base::remove(name = ' + name + ')');
			
			Base.app.container.removeChild( Base.app.container.getChildByName(name) );
		}
		
		public static function removeAll():void
		{
			Base.overlay.hide();
			
			var count:int = 0;
			var total:int = Base.app.container.numChildren;
			
			while(Base.app.container.numChildren>0)
			{
				Base.log('Base::removeAll(removed ' + Base.app.container.getChildAt(Base.app.container.numChildren-1) + ')');
				Base.app.container.removeChildAt(Base.app.container.numChildren-1);
				++count;
			}
			
			//Base.log('Base::removeAll(removed ' + count + ' / ' + total + ' | ' + Base.app.container.numChildren + ' apps left)');
		}
		
		public static function hide(name):void
		{
			Base.log('Base::hide(name = ' + name + ')');
			
			Base.app.container.getChildByName(name).visible = false;
		}
		
		public static function show(name):void
		{
			Base.log('Base::show(name = ' + name + ')');
			
			Base.app.container.getChildByName(name).visible = true;
		}
		
		public static function navigateToURL(url, target:String = '_self'):void
		{
			Base.log('Base::navigateToURL(url = ' + url + ', target = ' + target + ')');
			
			flash.net.navigateToURL(new URLRequest(url), target);
		}
		
		public static function post(url, data, encode:Boolean = false):void
		{
			Base.log('Base::post(url = ' + url + ', data = ' + data + ', encode = ' + encode + ')');
			
			var request:URLRequest = new URLRequest (url); 
			request.method = URLRequestMethod.POST; 
			
			var variables:URLVariables = new URLVariables();
			var i;
			
			if (encode == true) {
				var crypto = new CryptoCode('olm');
				for (i in data)
				{
					variables[i] = crypto.encrypt(data[i]);
					Base.log('Base::post(data[' + i + '] = ' + variables[i] + ')');
				}
			} else {
				for (i in data)
				{
					variables[i] = data[i];
					Base.log('Base::post(data[' + i + '] = ' + data[i] + ')');
				}
			}
			     
			request.data = variables;

			var loader:URLLoader = new URLLoader (request);
			loader.dataFormat = URLLoaderDataFormat.TEXT; 
			loader.load(request);
		}
		
		public static function externalCall(method, params = null):void
		{
			if (Base.platform != 'Plugin') return;
			
			Base.log('Base::externalCall(method = ' + method + ', params = ' + params + ')');
			ExternalInterface.call(method, params);
		}
		
		public static function addExternalCall(method, callback):void
		{
			if (Base.platform != 'Plugin') return;
			
			Base.log('Base::addExternalCall(method = ' + method + ', callback = ' + callback + ')');
			ExternalInterface.addCallback(method, callback);
		}
		
		public static function log(string, type = 'INFO'):void
		{
			if (Base.LOG) {
				trace(type + "::" + string);
				externalCall('console.log', type + "::" + string);
			}
		}
		
		public static function rand(low:Number=0, high:Number=1) :int
		{
			return Math.floor(Math.random() * (1+high-low)) + low;
		}
	}
}