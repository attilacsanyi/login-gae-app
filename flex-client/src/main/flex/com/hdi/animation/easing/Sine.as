package com.hdi.animation.easing{
	
	////////////////////////////////////////////////////////////////////////////////
	//	Easing 1.0 12/24/10
	//  Copyright © 2003 Robert Penner
	//	All rights reserved.
	//	Terms of Use: http://www.robertpenner.com/easing_terms_of_use.html
	//	
	////////////////////////////////////////////////////////////////////////////////


	public class Sine{
		
		public function Sine(){
			
		}
		
		//Sine
		public static function easeIn(t:Number, b:Number, c:Number, d:Number):Number {
			return -c * Math.cos(t/d * (Math.PI/2)) + c + b;
		}
		public static function easeOut(t:Number, b:Number, c:Number, d:Number):Number {
			return c * Math.sin(t/d * (Math.PI/2)) + b;
		}
		public static function easeInOut(t:Number, b:Number, c:Number, d:Number):Number {
			return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
		}
	}
}