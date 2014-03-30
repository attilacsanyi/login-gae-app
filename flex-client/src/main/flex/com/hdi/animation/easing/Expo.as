package com.hdi.animation.easing{
	
	////////////////////////////////////////////////////////////////////////////////
	//	Easing 1.0 12/24/10
	//  Copyright © 2003 Robert Penner
	//	All rights reserved.
	//	Terms of Use: http://www.robertpenner.com/easing_terms_of_use.html
	//	
	////////////////////////////////////////////////////////////////////////////////


	public class Expo{
		
		public function Expo(){
			
		}
			
		//Expo
		public static function easeIn(t:Number, b:Number, c:Number, d:Number):Number {
			return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b;
		}
		public static function easeOut(t:Number, b:Number, c:Number, d:Number):Number {
			return (t==d) ? b+c : c * (-Math.pow(2, -10 * t/d) + 1) + b;
		}
		public static function easeInOut(t:Number, b:Number, c:Number, d:Number):Number {
			if (t==0)
				return b;
				
			if (t==d)
				return b+c;
				
			if ((t/=d/2) < 1)
				return c/2 * Math.pow(2, 10 * (t - 1)) + b;
				
			return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
		}
		
	}
}