package com.wsd
{
	public class PHP
	{
		static public function in_array(string, array):Boolean
		{
			for ( var i in array )
			{
				if ( array[i] == string ) 				return true;
			}
			
			return false;
		}
	}
}