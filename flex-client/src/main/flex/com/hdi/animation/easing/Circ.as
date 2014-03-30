package com.hdi.animation.easing{
	
	////////////////////////////////////////////////////////////////////////////////
	//	Easing 1.0 12/24/10
	//  Copyright © 2003 Robert Penner
	//	All rights reserved.
	//	Terms of Use: http://www.robertpenner.com/easing_terms_of_use.html
	//	
	////////////////////////////////////////////////////////////////////////////////


	public class Circ{
		
		public function Circ(){
			
		}
		
		//Circ
		public static function easeIn(t:Number, b:Number, c:Number, d:Number):Number {
			return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
		}
		public static function easeOut(t:Number, b:Number, c:Number, d:Number):Number {
			return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
		}
		public static function easeInOut(t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d/2) < 1)
				return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
				
			return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
		}
			
	}
}