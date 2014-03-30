package com.app.models
{
	import app.dto.Customer;
	import app.dto.Login;
	import app.dto.Role;
	
	import com.app.constants.Constants;
	import com.app.events.CustomerEvent;
	import com.app.events.LoginEvent;
	import com.app.events.RoleEvent;
	
	import flash.events.IEventDispatcher;
	
	import org.swizframework.reflection.Constant;
	import org.swizframework.utils.chain.EventChain;
	import org.swizframework.utils.chain.EventChainStep;

	public class AppModel
	{	
		[Dispatcher] public var dispatcher:IEventDispatcher;	// Dispatcher
		
		[Inject][Bindable] public var roleModel:RoleModel;
		[Inject][Bindable] public var loginModel:LoginModel;
		[Inject][Bindable] public var customerModel:CustomerModel;
		
		[Bindable] public var currentState:String;
		
		private var _isLoggingOut:Boolean;
		private var _isLoginAndRoleLoaded:Boolean;
				
		public function AppModel(){}
		
		public function initialize():void
		{
			/*var eventChain : EventChain = new EventChain( dispatcher );
			eventChain.addStep( new EventChainStep( new LoginEvent( LoginEvent.LOGINS_REQUESTED, new Login ) ) );
			eventChain.addStep( new EventChainStep( new RoleEvent( RoleEvent.ROLES_REQUESTED, new Role ) ) );
			eventChain.addStep( new EventChainStep( new CustomerEvent( CustomerEvent.CUSTOMERS_REQUESTED, new Customer ) ) );
			eventChain.start();*/
			
			/*dispatcher.dispatchEvent(new LoginEvent( LoginEvent.LOGINS_REQUESTED));
			dispatcher.dispatchEvent(new RoleEvent( RoleEvent.ROLES_REQUESTED));
			dispatcher.dispatchEvent(new CustomerEvent( CustomerEvent.CUSTOMERS_REQUESTED));*/
			/*loginModel.isLoginsLoading = true;
			roleModel.isRolesLoading = true;
			customerModel.isCustomersLoading = true;*/
		}
		
		// *********************************************************
		// Getter/Setter 
		// *********************************************************
		
		[Bindable]
		public function get isLoggingOut():Boolean
		{
			return _isLoggingOut;
		}
		
		public function set isLoggingOut(value:Boolean):void
		{
			_isLoggingOut = value;
		}
		
		
		[Bindable]
		public function get isLoginAndRoleLoaded():Boolean
		{
			return _isLoginAndRoleLoaded;
		}
		
		public function set isLoginAndRoleLoaded(value:Boolean):void
		{
			_isLoginAndRoleLoaded = value;
		}
		
		// *********************************************************
		// EventHandlers 
		// *********************************************************
		
		[EventHandler( event="StateChangeEvent.CURRENT_STATE_CHANGE", properties="oldState, newState" )]
		public function onStateChange(oldState:String, newState:String):void {
			//Alert.show("State is changed from [" + oldState + "] to [" + newState + "]");
			currentState = newState;
		}
		
		[EventHandler( event="StateChangeEvent.CURRENT_STATE_CHANGING", properties="oldState, newState" )]
		public function onStateChanging(oldState:String, newState:String):void {
			
			// Starting to log out
			if (oldState == Constants.STATE_LOGGEDIN &&
				newState == Constants.STATE_LOGGEDOUT)
			{
				isLoggingOut = false
			}
			else
			{
				isLoggingOut = true;
			}
		}

	}
}