/*
http://www.lecrabe.net/wordpress/?p=61
*/

package com.hurlant.crypto
{
	import com.hurlant.crypto.Crypto;

	import flash.utils.ByteArray;

	import com.hurlant.crypto.symmetric.*;
	import com.hurlant.util.Base64;
	import com.hurlant.util.Hex;

	public class CryptoCode {
		private var type : String = 'simple-des-ecb';
		private var key : ByteArray;

		public function CryptoCode(key : String) {
			init(key);
		}

		private function init(s : String) : void {
			key = Hex.toArray(Hex.fromString(s)); // can only be 8 characters long
		}

		public function encrypt(txt : String = '') : String {
			var data : ByteArray = Hex.toArray(Hex.fromString(txt));
 
			var pad : IPad = new PKCS5;
			var mode : ICipher = Crypto.getCipher(type, key, pad);
			pad.setBlockSize(mode.getBlockSize());
			mode.encrypt(data);
			return Base64.encodeByteArray(data);
		}

		public function decrypt(txt : String = '') : String {
			var data : ByteArray = Base64.decodeToByteArray(txt);
			var pad : IPad = new PKCS5;
			var mode : ICipher = Crypto.getCipher(type, key, pad);
			pad.setBlockSize(mode.getBlockSize());
			mode.decrypt(data);
			return Hex.toString(Hex.fromArray(data));
		}
	}
}