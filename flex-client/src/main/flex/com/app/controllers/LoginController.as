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
	import mx.collections.ArrayList;
	import mx.collections.ListCollectionView;
	import mx.controls.Alert;
	import mx.events.StateChangeEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectUtil;
	
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
		[EventHandler( event="LoginEvent.GETALL" )]
		public function getAllLoginsHandler() : void
		{
			serviceHelper.executeServiceCall( loginService.getAllLogins(), handleGetAllLoginsResult, handleGetAllLoginsFault );
		}
		
		/** Handle login demo event */
		[EventHandler( event="LoginEvent.DEMO" )]
		public function createDemoLoginHandler() : void
		{
			serviceHelper.executeServiceCall( loginService.createDemoLogin(), handleCreateDemoLoginResult, handleCreateDemoLoginFault );
		}
		
		/** Handle login create event */
		[EventHandler( event="LoginEvent.CREATE")]
		public function createLoginHandler() : void
		{
			serviceHelper.executeServiceCall( loginService.createLogin(loginModel.createdLogin), handleCreateLoginResult, handleCreateLoginFault );
		}
		
		/** Handle login delete all event */
		[EventHandler( event="LoginEvent.DELALL")]
		public function deleteAllLoginsHandler() : void
		{
			serviceHelper.executeServiceCall( loginService.deleteAllLogins(), handleDeleteAllLoginsResult, handleDeleteAllLoginsFault );
		}
		
		/** Handle login delete event */
		[EventHandler( event="LoginEvent.DELETE")]
		public function deleteLoginHandler() : void
		{
			serviceHelper.executeServiceCall( loginService.deleteLogin(loginModel.selectedLogin), handleDeleteLoginResult, handleDeleteLoginFault );
		}
		
		/** Handle login update event */
		[EventHandler( event="LoginEvent.UPDATE")]
		public function updateLoginHandler() : void
		{
			serviceHelper.executeServiceCall( loginService.updateLogin(loginModel.updatedLogin), handleUpdateLoginResult, handleUpdateLoginFault );
		}
		
		/** Handle login with role create event */
		[EventHandler( event="LoginEvent.CREATE_WITH_ROLE", properties="login,role")]
		public function createLoginWithRoleHandler( login:Login, role:Role ) : void
		{
			serviceHelper.executeServiceCall( loginService.createLoginWithRole(login, role), handleCreateLoginWithRoleResult, handleCreateLoginWithRoleFault );
		}

		/** Handle add role to login event */
		[EventHandler( event="LoginEvent.ADD_ROLE", properties="login,role")]
		public function addRoleToLoginHandler( login:Login, role:Role ) : void
		{
			serviceHelper.executeServiceCall( loginService.addRoleToLogin(login, role), handleAddRoleToLoginResult, handleAddRoleToLoginFault );
		}
		
		/** Handle add role to login event */
		[EventHandler( event="LoginEvent.DELBY", properties="username")]
		public function deleteLoginByNameHandler( username:String ) : void
		{
			serviceHelper.executeServiceCall( loginService.deleteLoginByName(username), handleDeleteLoginByNameResult, handleDeleteLoginByNameFault );
		}

		/** Handle exists login event */
		[EventHandler( event="LoginEvent.EXISTS", properties="username")]
		public function existsLoginHandler( username:String ) : void
		{
			serviceHelper.executeServiceCall( loginService.existsLogin(username), handleExistsLoginResult, handleExistsLoginFault );
		}
		
		/** Handle remove all role from login event */
		[EventHandler( event="LoginEvent.DELALL_ROLES", properties="login")]
		public function removeAllRolesFromLoginHandler( login:Login ) : void
		{
			serviceHelper.executeServiceCall( loginService.removeAllRoleFromLogin(login), handleRemoveAllRoleFromLoginResult, handleRemoveAllRoleFromLoginFault );
		}

		/** Handle remove role from login event */
		[EventHandler( event="LoginEvent.DELETE_ROLE", properties="login, role")]
		public function removeRoleFromLoginHandler( login:Login, role:Role ) : void
		{
			serviceHelper.executeServiceCall( loginService.removeRoleFromLogin(login, role), handleRemoveRoleFromLoginResult, handleRemoveRoleFromLoginFault );
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
			getAllLoginsHandler();
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
			/*var roles:String = (newLogin.roles.length > 0) ? "" : "No roles";
			var sep:String = "";
			for each(var role:Role in newLogin.roles)
			{
				roles += sep + role.name;
				sep = ", ";
			}*/		
			
			//Alert.show("New login is created: " + newLogin.username + "\nwith role of: " + roles);
			//loginModel.isLoginCreating = false;
			getAllLoginsHandler();
			loginModel.createdLogin = new Login;
		}
		
		/** Handle login create fault */
		private function handleCreateLoginFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Login creation failure!" );
		}
		
		/** Handle login delete all result */
		private function handleDeleteAllLoginsResult( event : ResultEvent ) : void
		{
			getAllLoginsHandler();
		}
		
		/** Handle login delete all fault */
		private function handleDeleteAllLoginsFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Delete all logins failure!" );
		}
		
		/** Handle login update result */
		private function handleUpdateLoginResult( event : ResultEvent ) : void
		{
			getAllLoginsHandler();

			// Create copy into updated login object
			loginModel.updatedLogin = ObjectUtil.copy(loginModel.selectedLogin) as Login;
		}
		
		/** Handle login update fault */
		private function handleUpdateLoginFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Update login failure!" );
		}
		
		/** Handle login delete result */
		private function handleDeleteLoginResult( event : ResultEvent ) : void
		{
			getAllLoginsHandler();
		}
		
		/** Handle login delete fault */
		private function handleDeleteLoginFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Delete login failure!" );
		}
		
		/** Handle login with role create result */
		private function handleCreateLoginWithRoleResult( event : ResultEvent ) : void
		{
			var newLogin:Login = event.result as Login;
			Alert.show("New login with role is created: " + newLogin.username + ": " + ((newLogin.roles.getItemAt(0)) as Role).description);
			getAllLoginsHandler();
		}
		
		/** Handle login with role create fault */
		private function handleCreateLoginWithRoleFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Login with role creation failure!" );
		}
		
		/** Handle add role to login result */
		private function handleAddRoleToLoginResult( event : ResultEvent ) : void
		{
			Alert.show("Add role to login was successful!");
		}
		
		/** Handle add role to login fault */
		private function handleAddRoleToLoginFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Add role to login failure!" );
		}
		
		/** Handle delete login by name result */
		private function handleDeleteLoginByNameResult( event : ResultEvent ) : void
		{
			Alert.show("Delete login by name was successful!");
		}
		
		/** Handle delete login by name fault */
		private function handleDeleteLoginByNameFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Delete login by name failure!" );
		}
		
		/** Handle exists login result */
		private function handleExistsLoginResult( event : ResultEvent ) : void
		{
			Alert.show("Exists login was successful!");
		}
		
		/** Handle exists login fault */
		private function handleExistsLoginFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Exists login failure!" );
		}
		
		/** Handle remove all role from login result */
		private function handleRemoveAllRoleFromLoginResult( event : ResultEvent ) : void
		{
			Alert.show("Remove all role from login was successful!");
		}
		
		/** Handle remove all role from login fault */
		private function handleRemoveAllRoleFromLoginFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Remove all role from login failure!" );
		}
		
		/** Handle remove role from login result */
		private function handleRemoveRoleFromLoginResult( event : ResultEvent ) : void
		{
			Alert.show("Remove role from login was successful!");
		}
		
		/** Handle remove role from login fault */
		private function handleRemoveRoleFromLoginFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Remove role from login failure!" );
		}
		
	}
}