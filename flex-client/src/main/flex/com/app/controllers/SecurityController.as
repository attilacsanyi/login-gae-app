package com.app.controllers
{	
	import app.dto.Login;
	
	import com.app.constants.Constants;
	import com.app.models.AppModel;
	import com.app.models.SecurityModel;
	import com.app.services.interfaces.ISecurityService;
	
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	import mx.events.StateChangeEvent;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.reflection.Constant;
	import org.swizframework.utils.services.ServiceHelper;
	
	public class SecurityController
	{		
		[Dispatcher] public var dispatcher:IEventDispatcher;	// Dispatcher
		
		[Inject] public var serviceHelper	: ServiceHelper;	// Service Helper
		[Inject] public var securityService	: ISecurityService;	// Service Inteface
		[Inject] public var securityModel	: SecurityModel;	// Model
		[Inject] public var appModel		: AppModel;			// Model
		
		public function SecurityController():void {}
		
		// *********************************************************
		// EventHandlers 
		// *********************************************************
		
		/** Handle login event */
		[EventHandler( event="SecurityEvent.LOGIN_REQUESTED")]
		public function login() : void
		{
			serviceHelper.executeServiceCall( securityService.login( securityModel.login ), handleLoginResult, handleLoginFault );
		}
		
		/** Handle logout event */
		[EventHandler( event="SecurityEvent.LOGOUT_REQUESTED" )]
		public function logout() : void
		{
			serviceHelper.executeServiceCall( securityService.logout(), handleLogoutResult, handleLogoutFault );
			// Mark that state is going to change frim loggedin to loggedout
			dispatcher.dispatchEvent(new StateChangeEvent(StateChangeEvent.CURRENT_STATE_CHANGING, true, false, Constants.STATE_LOGIN, Constants.STATE_LOGOUT));
		}
		
		/** Handle authenticate event */
		[EventHandler( event="SecurityEvent.AUTHENTICATE_REQUESTED" )]
		public function authenticate() : void
		{
			serviceHelper.executeServiceCall( securityService.authenticate(), handleAuthenticateResult, handleAuthenticateFault );
		}
		
		// *********************************************************
		// Private Methods 
		// *********************************************************
		
		/** Handle login result */
		private function handleLoginResult( event : ResultEvent ) : void
		{
			//Alert.show(event.result.name + " - Login was successful");
			dispatcher.dispatchEvent(new StateChangeEvent(StateChangeEvent.CURRENT_STATE_CHANGE, true, false, Constants.STATE_LOGOUT, Constants.STATE_LOGIN));
			securityModel.isLoginProgress = false;
			
			// Init app (request all data)
			appModel.initialize();
		}
		
		/** Handle login fault */
		private function handleLoginFault( event : FaultEvent ) : void
		{
			Alert.show( processFault(event.fault), "Login failure!" );		
			securityModel.isLoginProgress = false;
		}
		
		private function processFault(fault:Fault) : String
		{
			var errorCode:String = fault.faultCode;
			var errorDetail:String = fault.faultDetail;
			var errorString:String = fault.faultString;
			
			var errorType:String = new String();
			if (errorCode == Constants.ERROR_CODE_AUTHENTICATION)
			{
				errorType = "Authentication";
			} else if (errorCode == Constants.ERROR_CODE_AUTHORIZATION)
			{
				errorType = "Authorization";
			}
			
			var errorMessage:String = errorType + " error" + "\n\n" + errorString;
			if (errorDetail != null && errorDetail.length > 0)
			{
				errorMessage += "\n\n(" + errorDetail + ")"; 
			}
			
			return errorMessage;
		}
		
		/** Handle logout result */
		private function handleLogoutResult( event : ResultEvent ) : void
		{           
			//Alert.show("Logout was successful");
			dispatcher.dispatchEvent(new StateChangeEvent(StateChangeEvent.CURRENT_STATE_CHANGE, true, false, Constants.STATE_LOGIN, Constants.STATE_LOGOUT));
			securityModel.isLogoutProgress = false;
			securityModel.login = new Login;
		}
		
		/** Handle logout fault */
		private function handleLogoutFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Logout failure!" );
			securityModel.isLogoutProgress = false;
		}
		
		/** Handle authenticate result */
		private function handleAuthenticateResult( event : ResultEvent ) : void
		{
			var user:Object = event.result;
			if (user != null && user.name != "" && user.name != "anonymousUser") {
				//Alert.show("Authentication was successful");
				handleLoginResult(event);
			} else {
				//Alert.show("Authentication is required");
			}
			securityModel.isAuthenticationProgress = false;
		}
		
		/** Handle authenticate fault */
		private function handleAuthenticateFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Authentication failure!" );
			securityModel.isAuthenticationProgress = false;
		}

	}
}