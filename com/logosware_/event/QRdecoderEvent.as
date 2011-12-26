/**************************************************************************
* LOGOSWARE Class Library.
*
* Copyright 2009 (c) LOGOSWARE (http://www.logosware.com) All rights reserved.
*
*
* This program is free software; you can redistribute it and/or modify it under
* the terms of the GNU General Public License as published by the Free Software
* Foundation; either version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along with
* this program; if not, write to the Free Software Foundation, Inc., 59 Temple
* Place, Suite 330, Boston, MA 02111-1307 USA
*
**************************************************************************/ 
package com.logosware.event
{
	import flash.events.Event;
	
	/**
	 * QRã‚³ãƒ¼ãƒ‰ã®ãƒ‡ã‚³ãƒ¼ãƒ‰å®Œäº†ã‚¤ãƒ™ãƒ³ãƒˆã‚’é€å‡ºã—ã¾ã™
	 */
	public class QRdecoderEvent extends Event
	{
		// å®šæ•°( Class constants )
		
		/**
		 * ãƒ‡ã‚³ãƒ¼ãƒ‰å®Œäº†ã‚’é€šçŸ¥ã—ã¾ã™ã€‚
		 * @eventType QR_DECODE_COMPLETE
		 **/
		public static const QR_DECODE_COMPLETE:String = "QR_DECODE_COMPLETE";
		
		// ãƒ—ãƒ­ãƒ‘ãƒ†ã‚£( Proerties )
		
		/**
		 * è§£æžã—ãŸçµæžœã®æ–‡å­—åˆ—ãŒæ ¼ç´ã•ã‚Œã¾ã™
		 **/
		public var data:String;
		/**
		 * è§£æžã«ç”¨ã„ãŸã‚³ãƒ¼ãƒ‰é…åˆ—ãŒæ ¼ç´ã•ã‚Œã¾ã™
		 **/
		public var checkArray:Array;
		
		// ã‚³ãƒ³ã‚¹ãƒˆãƒ©ã‚¯ã‚¿( Constructor )
		
		/**
		 * ã‚³ãƒ³ã‚¹ãƒˆãƒ©ã‚¯ã‚¿
		 * @param type ã‚¤ãƒ™ãƒ³ãƒˆã‚¿ã‚¤ãƒ—
		 * @param data æŠ½å‡ºæ–‡å­—åˆ—
		 * @param check å…¥åŠ›ã—ãŸã‚³ãƒ¼ãƒ‰
		 **/
        public function QRdecoderEvent(type:String, data:String, check:Array){
            super(type);
            // æ–°ã—ã„ãƒ—ãƒ­ãƒ‘ãƒ†ã‚£ã‚’è¨­å®šã™ã‚‹
           this.data = data;
           this.checkArray = check;
        }
        // Eventã‹ã‚‰ã‚ªãƒ¼ãƒãƒ¼ãƒ©ã‚¤ãƒ‰ã—ãŸãƒ¡ã‚½ãƒƒãƒ‰( Overridden Method: Event )
        /**
        * @private
        **/
        override public function clone():Event {
            return new QRdecoderEvent(type, data, checkArray);
        }
	}
}