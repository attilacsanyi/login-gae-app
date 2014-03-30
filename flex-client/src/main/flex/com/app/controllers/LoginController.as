package com.app.controllers
{	
	import app.dto.Login;
	import app.dto.Role;
	
	import com.app.constants.Constants;
	import com.app.models.AppModel;
	import com.app.models.LoginModel;
	import com.app.models.RoleModel;
	import com.app.services.interfaces.ILoginService;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.StateChangeEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.utils.services.ServiceHelper;
	
	public class LoginController
	{		
		[Dispatcher] public var dispatcher:IEventDispatcher;	// Dispatcher
		
		[Inject] public var serviceHelper	: ServiceHelper;	// Service Helper
		[Inject] public var loginService	: ILoginService;	// Service Inteface
		[Inject] public var loginModel		: LoginModel;		// Model
		[Inject] public var roleModel		: RoleModel;		// Model
		[Inject] public var appModel		: AppModel;			// Model
		
		public function LoginController():void {}
		
		// *********************************************************
		// EventHandlers 
		// *********************************************************
				
		/** Handle login list event */
		[EventHandler( event="LoginEvent.LOGINS_REQUESTED" )]
		public function getAllLogins( ) : void
		{
			serviceHelper.executeServiceCall( loginService.getAllLogins(), handleGetAllLoginsResult, handleGetAllLoginsFault );
		}
		
		/** Handle login demo event */
		[EventHandler( event="LoginEvent.LOGINS_DEMO" )]
		public function createDemoLogin( ) : void
		{
			serviceHelper.executeServiceCall( loginService.createDemoLogin(), handleCreateDemoLoginResult, handleCreateDemoLoginFault );
		}
		
		/** Handle login create event */
		[EventHandler( event="LoginEvent.CREATE", properties="login")]
		public function createLogin( login:Login) : void
		{
			serviceHelper.executeServiceCall( loginService.createLogin(login), handleCreateLoginResult, handleCreateLoginFault );
		}
		
		/** Handle login with role create event */
		[EventHandler( event="LoginEvent.LOGINS_CREATE_WITH_ROLE", properties="login,role")]
		public function createLoginWithRole( login:Login, role:Role ) : void
		{
			//serviceHelper.executeServiceCall( loginService.createLoginWithRole(login, role), handleCreateLoginWithRoleResult, handleCreateLoginWithRoleFault );
		}
		
		// *********************************************************
		// Private Methods 
		// *********************************************************
		
		/** Handle login list result */
		private function handleGetAllLoginsResult( event : ResultEvent ) : void
		{
			loginModel.setLogins( event.result as ArrayCollection );
			loginModel.isLoginsLoading = false;
			if (roleModel.isRolesLoading)
			{
				appModel.isLoginAndRoleLoaded = false;
			}
			else
			{
				appModel.isLoginAndRoleLoaded = true;
			}
			//Alert.show("Login list is loaded");
		}
		
		/** Handle login list fault */
		private function handleGetAllLoginsFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Get all logins failure!" );
			loginModel.isLoginsLoading = false;
		}
		
		/** Handle login demo result */
		private function handleCreateDemoLoginResult( event : ResultEvent ) : void
		{
			//Alert.show("Demo login is created");
			getAllLogins();
		}
		
		/** Handle login demo fault */
		private function handleCreateDemoLoginFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Demo login creation failure!" );
		}
		
		/** Handle login create result */
		private function handleCreateLoginResult( event : ResultEvent ) : void
		{
			var newLogin:Login = event.result as Login;
			var roles:String = (newLogin.roles.length > 0) ? "" : "No roles";
			var sep:String = "";
			for each(var role:Role in newLogin.roles)
			{
				roles += sep + role.name;
				sep = ", ";
			}
			
			
			Alert.show("New login is created: " + newLogin.username + "\nwith role of: " + roles);
			loginModel.login = new Login;
			loginModel.isLoginCreating = false;
			getAllLogins();
		}
		
		/** Handle login create fault */
		private function handleCreateLoginFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Login creation failure!" );
		}
		
		/** Handle login with role create result */
		private function handleCreateLoginWithRoleResult( event : ResultEvent ) : void
		{
			var newLogin:Login = event.result as Login;
			Alert.show("New login with role is created: " + newLogin.username + ": " + ((newLogin.roles.getItemAt(0)) as Role).description);
			getAllLogins();
		}
		
		/** Handle login with role create fault */
		private function handleCreateLoginWithRoleFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Login with role creation failure!" );
		}
	}
}