﻿package view {	import com.wsd.Base;	import com.wsd.View;		import flash.events.MouseEvent;		public class Window2 extends View	{		public function Window2()		{			super();						txtName.text = name;						var callback = function () {				Base.add(new view.Vindow1, 'main');				btnNext.removeEventListener(MouseEvent.CLICK, callback);			};						btnNext.addEventListener(MouseEvent.CLICK, callback);		}	}}