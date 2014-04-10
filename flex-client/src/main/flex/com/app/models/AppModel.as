package com.app.models
{
	import flash.events.IEventDispatcher;
	
	import com.app.constants.Constants;
	
	import org.swizframework.reflection.Constant;
	import org.swizframework.utils.chain.EventChain;
	import org.swizframework.utils.chain.EventChainStep;

	public class AppModel
	{	
		[Dispatcher] public var dispatcher:IEventDispatcher;	// Dispatcher
		
		[Bindable] public var currentState:String = Constants.STATE_LOGOUT; // You are logged out by default
		
		private var _loggedLogin:Boolean;
		private var _isLoginAndRoleLoaded:Boolean;
				
		public function AppModel(){}
		
		public function initialize():void
		{
		}
		
		// *********************************************************
		// Getter/Setter 
		// *********************************************************
		
		[Bindable]
		public function get isLoginAndRoleLoaded():Boolean
		{
			return _isLoginAndRoleLoaded;
		}
		
		public function set isLoginAndRoleLoaded(value:Boolean):void
		{
			_isLoginAndRoleLoaded = value;
		}
		
		[Bindable]
		public function get loggedLogin():Boolean
		{
			return _loggedLogin;
		}
		
		public function set loggedLogin(value:Boolean):void
		{
			_loggedLogin = value;
		}
		
		// *********************************************************
		// EventHandlers 
		// *********************************************************
		
		[EventHandler( event="StateChangeEvent.CURRENT_STATE_CHANGE", properties="oldState, newState" )]
		public function onStateChange(oldState:String, newState:String):void {
			//Alert.show("State is changed from [" + oldState + "] to [" + newState + "]");
			currentState = newState;
		}


	}
}