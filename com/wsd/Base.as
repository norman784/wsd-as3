﻿package com.wsd
{
	import com.wsd.display.Overlay;
	import com.wsd.engine.AMF;
	
	import luaAlchemy.LuaAlchemy;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ContextMenuEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	public class Base extends MovieClip
	{
		public static var 	DEBUG:Boolean				= false;
		public static var 	LOG:Boolean					= false;
		
		public static var	app:Base;
		public static var	overlay:Overlay;
		
		public static var	constants:Object 			= new Object;
		public static var 	lua:LuaAlchemy				= new LuaAlchemy();
		public static var	status:Object				= new Object;
		
		public var 			container:MovieClip 		= new MovieClip;
		
		public function Base(author_copyright = null, author_link = null, callBack = null):void
		{
			Base.log('Base::Base(author_copyright = ' + author_copyright + ', author_link = ' + author_link + ')');
			
			Base.app = this;
			
			Base.status.OK 		= AMF.OK;
			Base.status.ERROR 	= AMF.ERROR;
			Base.status.EXPIRED = AMF.EXPIRED;
			
			addEventListener(Event.ADDED_TO_STAGE, function(e:Event){
				Base.overlay = new Overlay();
				Base.overlay.hide();

				set_contextual_menu(author_copyright, author_link);
				
				callBack();
				
				addChild(container);
				addChild(Base.overlay);
			});
		}
		
		private function set_contextual_menu(author_copyright = null, author_link = null):void
		{
			if (author_copyright == null || author_link == null) return;
			
			var contextual_menu:ContextMenu = new ContextMenu();
			contextual_menu.hideBuiltInItems();
			
			var copyright:ContextMenuItem = new ContextMenuItem(author_copyright);
			copyright.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, function(e:Event){
				navigateToURL(new URLRequest(author_link), '_blank');
			});
			contextual_menu.customItems.push(copyright);
			this.contextMenu = contextual_menu;
		}
		
		public static function AMFconnect(domain, gateway, params, callbackSuccess = null, callbackError = null, method:String = "modules.Main.initialize"):void
		{
			Base.log('Base::AMFconnect(domain = ' + domain + ', gateway = ' + gateway + ')');
			
			Base.constants.AMF = new Object;
			Base.constants.AMF.domain = domain;
			Base.constants.AMF.gateway = gateway;
			
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
			
			navigateToURL(new URLRequest(url), target);
		}
		
		public static function externalCall(method, params = null):void
		{
			Base.log('Base::externalCall(method = ' + method + ', params = ' + params + ')');
			
			ExternalInterface.call(method, params);
		}
		
		public static function addExternalCall(method, callback):void
		{
			Base.log('Base::addExternalCall(method = ' + method + ', callback = ' + callback + ')');
			
			ExternalInterface.addCallback(method, callback);
		}
		
		public static function log(string, type = 'INFO'):void
		{
			if (Base.LOG) {
				trace(type + "::" + string);
				ExternalInterface.call('console.log', type + "::" + string);
			}
		}
	}
}