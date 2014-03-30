package com.hdi.animation.easing{
	
	////////////////////////////////////////////////////////////////////////////////
	//	Easing 1.0 12/24/10
	//  Copyright © 2003 Robert Penner
	//	All rights reserved.
	//	Terms of Use: http://www.robertpenner.com/easing_terms_of_use.html
	//	
	////////////////////////////////////////////////////////////////////////////////


	public class Quart{
		
		public function Quart(){
			
		}
		
		//Quart
		public static function easeIn(t:Number, b:Number, c:Number, d:Number):Number {
			return c*(t/=d)*t*t*t + b;
		}
		public static function easeOut(t:Number, b:Number, c:Number, d:Number):Number {
			return -c * ((t=t/d-1)*t*t*t - 1) + b;
		}
		public static function easeInOut(t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d/2) < 1)
				return c/2*t*t*t*t + b;
				
			return -c/2 * ((t-=2)*t*t*t - 2) + b;
		}
		
	}
}