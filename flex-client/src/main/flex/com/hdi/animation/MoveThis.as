package  com.hdi.animation{
	
	/**
	 * MoveThis : 3/23/11 : version 1.20
	 * 
	 * Animation controller for MoveThisEngine
	 * 
	 * Static Class to limit EnterFrame Event listeners
	 * 
	 * Author:Todd Williams
	 * http://www.taterboy.com/
	 * http://hdinteractive.com/
	 **/
	
	
	import com.hdi.animation.MoveThisObject;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.ColorTransform;
	import com.hdi.animation.easing.Easing;
	import com.hdi.animation.plugins.*;
	
	public class MoveThis extends EventDispatcher{
		
		public static var engine:MoveThisEngine;						//easing engine
		
		//--------------------------------------
		// CORE
		//--------------------------------------
		
		/**
		 * set engine to ignore duplicate tweens
		 * 
		 * @default false
		 */
		public static function set ignoreDupes(val:Boolean):void{ init(); engine.ignoreDupes = val;}
		public static function get ignoreDupes():Boolean{ init(); return engine.ignoreDupes;}
		
		/**
		 * set engine to dispatch ticker
		 * 
		 * @default false
		 */
		public static function set dispatchTicker(val:Boolean):void{ init(); engine.dispatchTicker = val;}
		public static function get dispatchTicker():Boolean{ init(); return engine.dispatchTicker;}
		
		/**
		 * number of currently tweening objects
		 * 
		 * @default 0
		 */
		public static function get tweenCount():int{ init(); return engine.tweenCount;}
		
		//------------------------------------------
		// PLUGINS
		//------------------------------------------
		
		/**
		 * @default Array
		 */
		public static function get installedPlugins():Array{
			init();
			return engine.installedPlugins;
		}
		
		/**
		 * @params obj, plugin object to add to plugin array.
		 */
		public static function install(obj:Object):void{
			init();
			engine.install(obj);
		}
		
		//------------------------------------------
		// CONSTRUCTOR
		//------------------------------------------
		
		/**
		 * start Animation class and enterFrame listener
		 **/
		public function MoveThis():void
		{
			if(engine == null){
				init();
			}
			else{
				throw(new Error("There should only be one instance of MoveThis"));
			}
		}
		
		private static function init():void{
			if(engine == null){
				engine = new MoveThisEngine();
			}
		}
		
		///-------------------------------------------------
		// Start Tween, Queue Tween
		//-------------------------------------------------
		/**
		 * add object and params to Animation class
		 * @param targObject: is the object to be animated.
		 * @param propValues: the property to tween and value of the property when the animation is finished.
		 * @param frames: how many frames the animation should take, lower number = faster.
		 * @param extras: object containing extra functionality for each tween such as onComplete or visible = false.
		 **/
		public static function startTween(targObject:Object,propValues:Object,frames:int = 24,extras:Object = null):void{
			init();
			engine.startTween(targObject,propValues,frames,extras);
		}
		
		
		/**
		 * Add a tween to the queue to avoid overwriting a current tween with one set to start later.
		 * @param queueTime: how many frames the tween should remain in the queue.
		 * @param targObject: is the object to be animated.
		 * @param propValues: the property to tween and value of the property when the animation is finished.
		 * @param frames: how many frames the animation should take, lower number = faster.
		 * @param extras: object containing extra functionality for each tween such as onComplete or visible = false.
		 */ 
		public static function queueTween(queueTime:int,targObject:Object,propValues:Object,frames:int = 24,extras:Object = null):void{
			init();
			engine.queueTween(queueTime,targObject,propValues,frames,extras);
		}
		
		
		//-------------------------------------------------
		// CONTROLS
		//-------------------------------------------------
		/**
		 * retrieve current tween by object and property
		 * 
		 * @default null
		 * 
		 * @param targObj, the object of the property being tweened
		 * @param propStr, the name of the property being tweened
		 * 
		 */
		public static function moveObject(targObj:Object, propStr:String):MoveThisObject{
			init();
			return engine.moveObject(targObj,propStr);
		}
		
		/**
		 * Stop a current tween
		 * 
		 * @param targObj, the object of the property being tweened
		 * @param propStr, the name of the property being tweened
		 * 
		 */
		public static function stopTween(targObj:Object, propStr:String):void{
			init();
			engine.stopTween(targObj,propStr);
		}
		
		/**
		 * Stop all current tweens
		 * 
		 * @param targObj, the object of the property being tweened
		 * 
		 */
		public static function stopAllTweens(targObj:Object):void{
			init();
			engine.stopAllTweens(targObj);
		}
		
		/**
		 * pause an existing tween
		 * 
		 * @param targObj, the object of the property being tweened
		 * @param propStr, the name of the property being tweened
		 * @param val, to pause or not to pause
		 * 
		 */
		public static function pauseTween(targObj:Object, propStr:String, val:Boolean = true):void{
			init();
			engine.pauseTween(targObj,propStr,val);
		}
		
		/**
		 * pause the MoveThisEngine
		 */
		public static function pause(val:Boolean):void{
			init();
			engine.pause(val);
		}
		
		/**
		 * is the MoveThisEngine currently paused?
		 */
		public static function get isPaused():Boolean{init(); return engine.isPaused;}
		
		/**
		 * remove all tweens in the MoveThisEngine
		 */
		public static function clearAllTweens():void{
			init();
			engine.clearAllTweens();
		}
		
		/**
		 * remove all queued tweens
		 */
		public static function clearQueue():void{
			init();
			engine.clearQueue();
		}
		
		/**
		 * stop queued tweens
		 */
		public static function stopQueued(targObj:Object, propStr:String):void{
			init();
			engine.stopQueued(targObj, propStr);
		}
		
		public static function stopAllQueued(targObj:Object):void{
			init();
			engine.stopAllQueued(targObj);
		}
		
	}
	
}