﻿package com.wsd.engine{	import com.AMF.Proxy;		import com.wsd.Base;		import flash.display.MovieClip;	import flash.system.Security;	public class AMF extends MovieClip	{		static public const ERROR:Number 			= 0;		static public const OK:Number				= 100;		static public const EXPIRED:Number			= 101;				public function AMF()		{			Base.log('AMF::AMF(domain ' + Base.constants.AMF.domain + ')');			Security.allowDomain(Base.constants.AMF.domain);		}				public static function service() {			Base.log('AMF::service(gateway ' + Base.constants.AMF.gateway + ')');			return(new Proxy(Base.constants.AMF.gateway));		}	}}