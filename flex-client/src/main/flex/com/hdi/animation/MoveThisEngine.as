package  com.hdi.animation{
	
	/**********************************************************
	 * MoveThisEngine : 3/28/11 : version 1.20
	 * 
	 * Animation controller or tween engine
	 * 
	 * Primary tween engine for MoveThis
	 * Broadcasts "ticker" event
	 * 
	 * Author:Todd Williams
	 * http://www.taterboy.com/
	 * http://hdinteractive.com/
	 * 
	 * 
	 * Test easing -1 to 1 without easing function selected
	 * 
	 *********************************************************/
	
	import com.hdi.animation.easing.Easing;
	import com.hdi.animation.plugins.*;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.ColorTransform;
	
	/***************************************************************
	 * FLEX 4 SDK: UNCOMMENT FOR Group and Element support (1 of 3)
	 ***************************************************************/
	//import mx.core.IVisualElement;
	//import spark.components.Group;
	/*** END FLEX 4 SDK ********************************************/
	
	public class MoveThisEngine extends EventDispatcher{
		
		public var TICKER:String = "ticker"; 			// frame tick event
		private var tweenArr:Array = [];				// array containing all currently running tweens
		private var queueArr:Array = [];				// array containing all queud items
		private var inited:Boolean;						// is inited or not
		private var inc:Sprite;							// sprite instance to attach EnterFrame Event listener
		private var _isPaused:Boolean;					// pause all tweens and queue
		public var ignoreDupes:Boolean;					// **increases performance, overlook duplicate tweens (less looping when adding new tweens)
		public var tweenCount:int;						// current tween amount
		public var dispatchTicker:Boolean;				// could dispatch a ticker, or enter frame event, no real value over enterFrame event.
		// for callback enterframe event handling, start a tween using onFrame function.
		
		///-------------------------------------------------
		// PLUGINS
		//-------------------------------------------------
		/**
		 * Additional tween options for non numeric tweening.
		 * See brightness and color samples in plugins folder
		 * 
		 */
		private var plugins:Array = [{brightness:MoveBrightness},{color:MoveColor},{mixVolume:MoveMixVolume}];
		
		/**
		 * Array of installed plugins.
		 * 
		 * @default Array
		 */
		public function get installedPlugins():Array{ return plugins; }
		
		/**
		 * Add plugin Object to the plugins array
		 * @param obj:Object (required) Ex. {brightness:MoveBrightness}, name : class reference
		 */
		public function install(obj:Object):void{
			plugins.push(obj);
			
		}
		
		/**
		 * Get plugin by name
		 */
		private function getPlugin(str:String):Class{
			var pluginClass:Class = null;
			var pluginItem:Object;
			for each(pluginItem in plugins){
				for(var p:String in pluginItem){
					if(p == str){
						pluginClass = pluginItem[p];
					}
					if(pluginClass != null){
						break;
					}
				}
			}
			
			return pluginClass;
			
		}
		
		///-------------------------------------------------
		// Constructor
		//-------------------------------------------------
		
		/**
		 * start MoveThisEngine and enterFrame listener
		 **/
		public function MoveThisEngine() {
			// constructor code
			inc = new Sprite();
			inc.addEventListener(Event.ENTER_FRAME,frameHandler);
			inited = true;
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
		public function startTween(targObject:Object,propValues:Object,frames:int = 24,extras:Object = null):void{
			
			//new object
			var moveObj:MoveThisObject;
			if(propValues == null){
				throw( new Error("There were no animation properties provided."));
				return;
			}
			
			//loop through properties and values, create 1 tween object per property
			for(var p:String in propValues){
				
				if(targObject == null && p != "pause"){
					throw( new Error("The target object must be a non-null object."));
					return;
				}
				
				// get the starting tween value
				var startNum:Number = getStartValue(targObject,p);
				var finNum:Number = propValues[p];
				if(extras != null){
					if(extras.smartRotation && p == "rotation"){
						finNum = getShortRotation(targObject,propValues[p]);
					}
				}
				
				
				
				moveObj = new MoveThisObject(targObject,p,{start:startNum,finish:finNum},frames,extras);
				
				//check for dupes by default, disable it globally and control per animation for better performance
				if(!ignoreDupes || moveObj.removeDupes){
					popDupes(moveObj, tweenArr);
				}
				
				// add tween
				tweenArr.push(moveObj);
			}
			
			if(!inited){
				inc = new Sprite();
				inc.addEventListener(Event.ENTER_FRAME,frameHandler);
				inited = true;
			}
		}
		
		/**
		 * Add a tween to the queue to avoid overwriting a current tween with one set to start later.
		 * @param queueTime: how many frames the tween should remain in the queue.
		 * @param targObject: is the object to be animated.
		 * @param propValues: the property to tween and value of the property when the animation is finished.
		 * @param frames: how many frames the animation should take, lower number = faster.
		 * @param extras: object containing extra functionality for each tween such as onComplete or visible = false.
		 */ 
		public function queueTween(queueTime:int,targObject:Object,propValues:Object,frames:int = 24,extras:Object = null):void{
			var moveObj:MoveThisObject;
			if(propValues == null){
				throw( new Error("There were no animation properties provided."));
				return;
			}
			
			for(var p:String in propValues){
				
				if(targObject == null && p != "pause"){
					throw( new Error("The target object must be a non-null object."));
					return;
				}
				var startNum:Number = getStartValue(targObject,p);
				moveObj = new MoveThisObject(targObject,p,{start:startNum,finish:propValues[p]},frames,extras);
				moveObj.queueCnt = queueTime;
				moveObj.isMoving = false;
				
				queueArr.push(moveObj);
			}
			
		}
		
		//------------------------------------------------
		// UTILITIES
		//-------------------------------------------------
		
		/**
		 * get properties current value at the start of tween
		 * 
		 * @private
		 * 
		 * @default 0
		 * 
		 * @param obj, the object of the property to be tweened
		 * @param propt, the property to be tweened as a string
		 */
		private function getStartValue(obj:Object,propt:String):Number{
			var num:Number = 0;
			//check for plugins first
			var pluginClass:Class = getPlugin(propt);
			if(pluginClass != null){
				num = pluginClass["startValue"](obj,propt);
			}
			else{
				// hopefully property is a number and available
				try{
					num = obj[propt];
				}
				catch(e:Error){}
			}
			return num;
		}
		
		/**
		 * Get closest angle to current rotation
		 * 
		 * @private
		 * 
		 * @default 0;
		 * 
		 * @param obj, the object of the property to be tweened
		 * @param rot, rotation value
		 */
		private function getShortRotation(obj:Object,rot:Number):Number{
			var newRot:Number = 0;
			var curRot:Number = obj["rotation"];
			
			newRot = rot%360;
			if(newRot > 180){
				newRot = 0-(180 - rot%180);
				newRot == -180? newRot = 0:null;
			}
			if(newRot < -180){
				newRot = 180 + rot%180;
				newRot == 180? newRot = 0:null;
			}
			
			var span:Number = Math.abs(curRot - newRot);
			
			if(span > 180){
				newRot = curRot + (180-(span%180));
			}
			
			return newRot;
		}
		
		
		/**
		 * remove any duplicate object/property animations
		 * 
		 * @private
		 * 
		 * @param moveObj, the tween object to check for duplicates
		 * @param arr, the array to check for duplicates in
		 * @param self, look for a duplicate or the the same move obj
		 * 
		 **/
		private function popDupes(moveObj:MoveThisObject, arr:Array, self:Boolean=false):void{
			
			var tempObj:MoveThisObject;
			var index:int = arr.length-1;
			if(index <= -1){ return;}
			while(index > -1){
				tempObj = arr[index];
				
				if(tempObj == null){
					index --;
					continue;
				}
				if(self){
					// looking for it self
					if(tempObj == moveObj){
						//arr.splice(index,1);
						tempObj.stopTween();
						arr[index] = null;
						tempObj = null;
						break;
					}
				}
				else{
					// looking for a duplicate
					if(tempObj.targetObj == moveObj.targetObj && tempObj.propStr == moveObj.propStr){
						if(moveObj.propStr != "pause"){
							tempObj.stopTween();
							arr[index] = null;
							tempObj = null;
							//arr.splice(index,1);
							break;
						}
						else{
							if(tempObj.currentFrame >= tempObj.frames){
								tempObj.stopTween();
								arr[index] = null;
								tempObj = null;
								//arr.splice(index,1);
								break;
							}
							else{
								if((tempObj.uid > 0 && tempObj.uid == moveObj.uid)){
									tempObj.stopTween();
									arr[index] = null;
									tempObj = null;
									//arr.splice(index,1);
									break;
								}
							}
						}
					}
				}
				index --;
			}
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
		public function moveObject(targObj:Object, propStr:String):MoveThisObject{
			var item:MoveThisObject;
			var retItem:MoveThisObject = null;
			for each(item in tweenArr){
				if(item != null){
					if(item.targetObj == targObj && item.propStr == propStr){
						retItem = item;
						break;
					}
				}
			}
			return retItem;
		}
		
		/**
		 * Stop a current tween
		 * 
		 * @param targObj, the object of the property being tweened
		 * @param propStr, the name of the property being tweened
		 * 
		 */
		public function stopTween(targObj:Object, propStr:String):void{
			var item:MoveThisObject = moveObject(targObj, propStr);
			if(item != null){
				item.stopTween();
			}
		}
		
		/**
		 * Stop all current tweens
		 * 
		 * @param targObj, the object of the property being tweened
		 * 
		 */
		public function stopAllTweens(targObj:Object):void{
			var item:MoveThisObject;
			if(targObj == null){
				return;
			}
			for each(item in tweenArr){
				if(item == null){
					continue;
				}
				if(item.targetObj == targObj){
					item.stopTween();
				}
			}
		}
		
		/**
		 * pause an existing tween
		 * 
		 * @param targObj, the object of the property being tweened
		 * @param propStr, the name of the property being tweened
		 * @param val, to pause or not to pause
		 * 
		 */
		public function pauseTween(targObj:Object, propStr:String, val:Boolean = true):void{
			var item:MoveThisObject = moveObject(targObj, propStr);
			if(item != null){
				item.isPaused = val;
			}
		}
		
		/**
		 * remove all tweens in the MoveThisEngine
		 */
		public function clearAllTweens():void{
			var item:MoveThisObject;
			var index:int = tweenArr.length-1;
			while(index > -1){
				if(item != null){
					item = tweenArr[index];
					item.stopTween();
					item = null;
					tweenArr[index] = null;
				}
				index --;
			}
			tweenArr = [];
		}
		
		/**
		 * remove all queued tweens
		 */
		public function clearQueue():void{
			var item:MoveThisObject;
			var index:int = queueArr.length-1;
			while(index > -1){
				if(item != null){
					item = queueArr[index];
					item.stopTween();
					item = null;
					queueArr[index] = null;
				}
				index --;
			}
			queueArr = [];
		}
		
		/**
		 * retrieve queued tween by object and property
		 * 
		 * @default null
		 * 
		 * @param targObj, the object of the property being tweened
		 * @param propStr, the name of the property being tweened
		 * 
		 */
		public function queuedObject(targObj:Object, propStr:String):MoveThisObject{
			var item:MoveThisObject;
			var retItem:MoveThisObject = null;
			for each(item in queueArr){
				if(item != null){
					if(item.targetObj == targObj && item.propStr == propStr){
						retItem = item;
						break;
					}
				}
			}
			return retItem;
		}
		
		
		/**
		 * stop queued tweens
		 */
		public function stopQueued(targObj:Object, propStr:String):void{
			var item:MoveThisObject = queuedObject(targObj, propStr);
			if(item != null){
				item.stopTween();
			}
		}
		
		public function stopAllQueued(targObj:Object):void{
			var item:MoveThisObject;
			for each(item in queueArr){
				if(item.targetObj == targObj){
					item.stopTween();
				}
			}
		}
		
		/**
		 * pause the MoveThisEngine
		 */
		public function pause(val:Boolean):void{
			_isPaused = val;
		}
		
		/**
		 * is the MoveThisEngine currently paused?
		 */
		public function get isPaused():Boolean{return _isPaused;}
		
		
		//-------------------------------------------
		// ENGINE
		//-------------------------------------------
		/**
		 * tween the object's property according to the specs set by startTween
		 * handles all functionality of MoveThis
		 * 
		 * @private
		 * 
		 * @default 0
		 * 
		 * @params moveObj, the MoveThisObject for each tween
		 * 
		 * 
		 **/
		private function transitionObj(moveObj:MoveThisObject):int{
			
			if(moveObj == null){
				return 1;
			}
			if(moveObj.stopped){
				moveObj = null;
				return 1;
			}
			if(moveObj.currentFrame >= moveObj.frames){
				moveObj.onComplete != null ? moveObj.onComplete(moveObj.targetObj): null;
				if(moveObj.loop){
					moveObj.loopCounter ++;
					if(moveObj.loopCount == 0 || (moveObj.loopCounter < moveObj.loopCount)){
						//infinity
						restartTween(moveObj);
						return 0;
					}
					else{
						if(!moveObj.visible){
							try{
								moveObj.targetObj.visible = moveObj.visible;
							}
							catch(e:Error){}
						}
						
						if(moveObj.remove){
							try{
								moveObj.targetObj.parent.removeChild(moveObj.targetObj);
							}
							catch(e:Error){}
							
							/***************************************************************
							 * FLEX 4 SDK: UNCOMMENT FOR Group and Element support (2 of 3)
							 ***************************************************************/
							
							/*try{
							moveObj.targetObj.parent.removeElement(moveObj.targetObj as IVisualElement);
							}
							catch(e:Error){}*/
							
							/*** END FLEX 4 SDK ********************************************/
						}
						moveObj = null;
						return 1;
					}
				}
				if(!moveObj.visible){
					try{
						moveObj.targetObj.visible = moveObj.visible;
					}
					catch(e:Error){}
				}
				
				if(moveObj.remove){
					try{
						moveObj.targetObj.parent.removeChild(moveObj.targetObj);
					}
					catch(e:Error){}
					
					/***************************************************************
					 * FLEX 4 SDK: UNCOMMENT FOR Group and Element support (3 of 3)
					 ***************************************************************/
					
					/*try{
					moveObj.targetObj.parent.removeElement(moveObj.targetObj as IVisualElement);
					}
					catch(e:Error){}*/
					
					/*** END FLEX 4 SDK ********************************************/
				}
				//popDupes(moveObj,tweenArr,true);
				moveObj = null;
				return 1;
			}
			
			if(moveObj.delay > 0){
				moveObj.delay --;
				return 0;
			}
			
			moveObj.isMoving = true;
			
			if(moveObj.isPaused){
				return 0;
			}
			
			moveObj.currentFrame ++;
			
			if(moveObj.onStart != null && moveObj.currentFrame == 1){
				moveObj.onStart(moveObj.targetObj);
			}
			
			if(moveObj.propStr == "pause"){
				return 0;
			}
			
			if(moveObj.currentFrame == 1 && moveObj.startVisible){
				try{
					moveObj.targetObj.visible = moveObj.startVisible;
				}catch(e:Error){}
			}
			
			//animate properties
			var moveValue:Number = 0;
			var linearValue:Number = moveObj.changeValue*(moveObj.currentFrame/moveObj.frames) + moveObj.startValue;
			
			//check plugins
			var pluginFunciton:Function = null;
			var pluginClass:Class = getPlugin(moveObj.propStr);
			if(pluginClass != null){
				// animation using plugin
				pluginFunciton = pluginClass[moveObj.propStr];
			}
			
			//check easing function
			if(moveObj.easingFunction != null){
				
				if(pluginFunciton != null){
					pluginFunciton(moveObj,moveObj.easingFunction);
				}
				else{
					moveValue = moveObj.easingFunction(moveObj.currentFrame, moveObj.startValue, moveObj.changeValue, moveObj.frames);
					
					//check easing
					if(moveObj.easingStrength != 1){
						linearValue = moveObj.changeValue*((moveObj.currentFrame/moveObj.frames)*(1-moveObj.easingStrength)) + moveObj.startValue;
						moveValue = (moveValue*moveObj.easingStrength) + linearValue;
					}
					moveObj.targetObj[moveObj.propStr] = moveValue;
				}
				checkFrameEvents(moveObj);
				return 0;
			}
			
			//check easing string
			if(moveObj.easing != null){
				//get function from easing class,
				if(pluginFunciton != null){
					if(moveObj.easingFunction == null){
						moveObj.easingFunction = Easing.getEasingFunction(moveObj.easing);
					}
					pluginFunciton(moveObj,  moveObj.easingFunction);
				}
				else{
					//check easing
					if(moveObj.easingFunction == null){
						moveObj.easingFunction = Easing.getEasingFunction(moveObj.easing);
					}
					moveValue = Easing.easefunction(moveObj, moveObj.easingFunction);
					
					if(moveObj.easingStrength != 1){
						linearValue = moveObj.changeValue*((moveObj.currentFrame/moveObj.frames)*(1-moveObj.easingStrength)) + moveObj.startValue;
						moveValue = (moveValue*moveObj.easingStrength) + linearValue;
					}
					moveObj.targetObj[moveObj.propStr] = moveValue;
				}
				
				checkFrameEvents(moveObj);
				return 0;
			}
			
			if(pluginFunciton != null){
				pluginFunciton(moveObj,Easing.linear);
			}
			else{
				moveObj.targetObj[moveObj.propStr] = linearValue;
			}
			checkFrameEvents(moveObj);
			
			return 0;
			
		}
		
		private function checkFrameEvents(obj:MoveThisObject):void{
			if(obj != null){
				if(obj.currentFrame < obj.frames && obj.currentFrame > 1){
					if(obj.onFrame != null){
						obj.onFrame(obj.targetObj);
					}
				}
				
			}
		}
		
		
		/**
		 * handle looping tweens
		 * 
		 * @private
		 * 
		 * @params moveObj,
		 */
		private function restartTween(moveObj:MoveThisObject):void{
			var pluginClass:Class = getPlugin(moveObj.propStr);
			if(pluginClass != null){
				pluginClass["resetValue"](moveObj);
			}
			else{
				try{
					moveObj.targetObj[moveObj.propStr] = moveObj.startValue;
				}
				catch(e:Error){throw(new Error("Property could not be reset."));}
			}
			moveObj.currentFrame = 0;
		}
		
		/**
		 * hand queued items, if queue time is complete, startTween
		 * 
		 * @private
		 * 
		 * @default false;
		 * 
		 * @params moveObj,
		 * 
		 */
		private function handleQueue(moveObj:MoveThisObject):Boolean{
			moveObj.queueCnt --;
			var chk:Boolean;
			if(moveObj.queueCnt <= 0){
				var startNum:Number = getStartValue(moveObj.targetObj,moveObj.propStr);
				moveObj.startValue = startNum;
				
				if(moveObj.smartRotation && moveObj.propStr == "rotation"){
					moveObj.finValue = getShortRotation(moveObj.targetObj,moveObj.finValue);
				}
				
				moveObj.changeValue = moveObj.finValue - startNum;
				
				if(!ignoreDupes || moveObj.removeDupes){
					popDupes(moveObj, tweenArr);
				}
				
				moveObj.isMoving = true;
				
				tweenArr.push(moveObj);
				chk = true;
				
			}
			return chk;
		}
		
		/**
		 * EnterFrame Event Handler
		 * dispatch "ticker" event
		 * 
		 * @private
		 **/
		private function frameHandler(ev:Event):void{
			if(_isPaused)
				return;
			
			//tween objects
			var moveObj:MoveThisObject;
			var index:int = tweenArr.length-1;
			if(index > -1){
				while(index > -1){
					moveObj = tweenArr[index];
					if(transitionObj(moveObj)){
						moveObj = null;
						tweenArr.splice(index,1);
					}
					index --;
				}
			}
			
			// cycle queue
			index = queueArr.length-1;
			if(index > -1){
				while(index > -1){
					moveObj = queueArr[index];
					handleQueue(moveObj) ? queueArr.splice(index,1):null;
					index --;
					
				}
			}
			
			tweenCount = tweenArr.length;
			
			if(dispatchTicker){
				dispatchEvent(new Event(TICKER));
			}
		}
		
	}
	
}