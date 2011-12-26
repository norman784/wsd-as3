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
package com.logosware.utils.QRcode
{
	import com.logosware.utils.QRcode.GFstatic;
	/**
	 * GF(2^4)ã‚’æ‰±ã†ãŸã‚ã®ã‚¯ãƒ©ã‚¹
	 **/
	public class G4Num {
		private var _vector:uint;
		private var _power:int;
		/**
		 * ã‚³ãƒ³ã‚¹ãƒˆãƒ©ã‚¯ã‚¿
		 * @param power æŒ‡æ•°
		 **/
		public function G4Num(power:int) {
			setPower( power );
		}
		/**
		 * æŒ‡æ•°ã‚’æŒ‡å®šã™ã‚‹
		 * @param power æŒ‡æ•°
		 **/
		public function setPower( power:int ):void {
			_power = power;
			if ( _power < 0 ) {
				_vector = 0;
			} else {
				_power %= 15;
				_vector = GFstatic._power2vector_4[_power];
			}
		}
		/**
		 * æ•´æ•°å€¤ã‚’æŒ‡å®šã™ã‚‹
		 * @param vector æ•´æ•°å€¤
		 **/
		public function setVector( vector:uint ):void {
			_vector = vector;
			_power = GFstatic._vector2power_4[_vector];
		}
		/**
		 * æ•´æ•°å€¤ã‚’å–å¾—ã™ã‚‹
		 * @param æ•´æ•°å€¤
		 **/
		public function getVector():uint {
			return _vector;
		}
		/**
		 * æŒ‡æ•°ã‚’å–å¾—ã™ã‚‹
		 * @param æŒ‡æ•°
		 **/
		public function getPower():int {
			return _power;
		}
		/**
		 * è¶³ã—ç®—ã‚’è¡Œã†ã€‚æ•´æ•°å€¤åŒå£«ã®xorã‚’å–ã‚‹ã€‚
		 * @param other è¶³ã™å¯¾è±¡ã¨ãªã‚‹G4Numã‚¤ãƒ³ã‚¹ã‚¿ãƒ³ã‚¹
		 * @param è¨ˆç®—çµæžœ
		 **/
		public function plus( other:G4Num ):G4Num {
			var newVector:uint = _vector ^ other.getVector();
			return new G4Num( GFstatic._vector2power_4[ newVector ] );
		}
		/**
		 * ä¹—ç®—ã‚’è¡Œã†ã€‚æŒ‡æ•°åŒå£«ã®è¶³ã—ç®—ã‚’è¡Œã†ã€‚
		 * @param other ã‹ã‘ã‚‹å¯¾è±¡ã¨ãªã‚‹G4Numã‚¤ãƒ³ã‚¹ã‚¿ãƒ³ã‚¹
		 * @param è¨ˆç®—çµæžœ
		 **/
		public function multiply( other:G4Num ):G4Num {
			if ( (_power == -1) || (other.getPower() == -1 ) ) {
				return new G4Num( -1 );
			} else {
				return new G4Num( _power + other.getPower() );
			}
		}
	}
}