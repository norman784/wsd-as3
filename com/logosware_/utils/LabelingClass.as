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
package com.logosware.utils
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ãƒ©ãƒ™ãƒªãƒ³ã‚°ã‚’è¡Œã†ã‚¯ãƒ©ã‚¹ã§ã™
	 */
	public class LabelingClass
	{
		private var _bmp:BitmapData;
		private var _minSize:uint;
		private var _startColor:uint;
		private var _pickedRects:Array = [];
		private var _pickedColor:Array = [];
		/**
		 * ã‚³ãƒ³ã‚¹ãƒˆãƒ©ã‚¯ã‚¿
		 * @param bmp å…¥åŠ›ç”»åƒ(0x0, 0xFFFFFFFFã§ãƒ‹å€¤åŒ–ã•ã‚ŒãŸã‚‚ã®)
		 * @param minSize ç”»ç´ ã¨ã—ã¦èªã‚ã‚‹æœ€ä½Žã‚µã‚¤ã‚º(ãƒŽã‚¤ã‚ºå¯¾ç­–)
		 * @param startColor å¡—ã‚Šé–‹å§‹è‰²
		 * @param isChangeOriginal å…¥åŠ›ç”»åƒã‚’å®Ÿéš›ã«å¡—ã‚‹ã‹ã©ã†ã‹ 
		 **/
		public function Labeling(bmp:BitmapData, minSize:uint = 10, startColor:uint = 0xFFFFFFFE, isChangeOriginal:Boolean = true):void{
			_minSize = minSize;
			_startColor = startColor;
			if( isChangeOriginal ){
				_bmp = bmp;
			} else {
				_bmp = bmp.clone();
			}
			_process();
		}
		/**
		 * ãƒ©ãƒ™ãƒªãƒ³ã‚°ã—ãŸçµæžœå¾—ã‚‰ã‚ŒãŸç¯„å›²ã®çŸ©å½¢æƒ…å ±ã‚’è¿”ã—ã¾ã™
		 * @return çŸ©å½¢ã®é…åˆ—
		 **/
		public function getRects():Array{
			return _pickedRects;
		} 
		/**
		 * ãƒ©ãƒ™ãƒªãƒ³ã‚°ã—ãŸçµæžœå¾—ã‚‰ã‚ŒãŸç¯„å›²ã‚’å¡—ã£ãŸè‰²æƒ…å ±ã‚’è¿”ã—ã¾ã™
		 * @return è‰²ã®é…åˆ—
		 **/
		public function getColors():Array{
			return _pickedColor;
		}
		/**
		 * ã‚³ã‚¢é–¢æ•°
		 **/
		private function _process():void {
			var _fillColor:uint = _startColor;
			var _rect:Rectangle;
			while (_paintNextLabel( _bmp, 0xFF000000, _fillColor ) ){
				_rect = _bmp.getColorBoundsRect( 0xFFFFFFFF, _fillColor );
				if ( ( _rect.width > _minSize) && ( _rect.height > _minSize ) ) {
					var _tempRect:Rectangle = _rect.clone();
					_pickedRects.push( _tempRect );
					_pickedColor.push( _fillColor );
				}
				_fillColor --;
			}
		}
		/**
		 * æ¬¡ã®pickcolorè‰²ã®é ˜åŸŸã‚’fillcolorè‰²ã«å¡—ã‚‹ã€‚pickcolorãŒè¦‹ã¤ã‹ã‚‰ãªã‘ã‚Œã°falseã‚’è¿”ã™
		 * @param bmp ç”»åƒ
		 * @param pickcolor æ¬¡ã®è‰²
		 * @param fillcolor å¡—ã‚‹è‰²
		 * @return ç›®çš„ã®è‰²ãŒã‚ã£ãŸã‹ã©ã†ã‹
		 **/
		private function _paintNextLabel( bmp:BitmapData, pickcolor:uint, fillcolor:uint ):Boolean {
			var rect:Rectangle = bmp.getColorBoundsRect( 0xFFFFFFFF, pickcolor );
			if( (rect.width > 0) && (rect.height> 0) ){
				var tempBmp:BitmapData = new BitmapData( rect.width, 1 );
				tempBmp.copyPixels( bmp, new Rectangle(rect.topLeft.x, rect.topLeft.y, rect.width, 1 ), new Point(0, 0) );
				var rect2:Rectangle = tempBmp.getColorBoundsRect( 0xFFFFFFFF, pickcolor );
				bmp.floodFill( rect2.topLeft.x + rect.topLeft.x, rect2.topLeft.y + rect.topLeft.y, fillcolor );
				return true;
			}
			return false;
		}
	}
}