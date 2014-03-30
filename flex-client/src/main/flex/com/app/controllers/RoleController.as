package com.app.controllers
{
	import app.dto.Role;
	
	import com.app.models.AppModel;
	import com.app.models.LoginModel;
	import com.app.models.RoleModel;
	import com.app.services.interfaces.IRoleService;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.utils.services.ServiceHelper;

	public class RoleController
	{
		[Dispatcher] public var dispatcher:IEventDispatcher;	// Dispatcher
		
		[Inject] public var serviceHelper	: ServiceHelper;	// Service Helper
		[Inject] public var roleService		: IRoleService;		// Service Inteface
		[Inject] public var roleModel		: RoleModel;		// Model
		[Inject] public var loginModel		: LoginModel;		// Model
		[Inject] public var appModel		: AppModel;			// Model
		
		public function RoleController():void {}
		
		// *********************************************************
		// EventHandlers 
		// *********************************************************
		
		/** Handle role list event */
		[EventHandler( event="RoleEvent.ROLES_REQUESTED" )]
		public function getAllRoles( ) : void
		{
			serviceHelper.executeServiceCall( roleService.getAllRoles(), handleGetAllRolesResult, handleGetAllRolesFault );
		}
		
		/** Handle role demo event */
		[EventHandler( event="RoleEvent.ROLES_DEMO" )]
		public function createDemoRole( ) : void
		{
			serviceHelper.executeServiceCall( roleService.createDemoRole(), handleCreateDemoRoleResult, handleCreateDemoRoleFault );
		}
		
		/** Handle role create event */
		[EventHandler( event="RoleEvent.CREATE", properties="role")]
		public function createLogin( role:Role) : void
		{
			serviceHelper.executeServiceCall( roleService.createRole(role), handleCreateRoleResult, handleCreateRoleFault );
		}
		
		// *********************************************************
		// Private Methods 
		// *********************************************************
		
		/** Handle role list result */
		private function handleGetAllRolesResult( event : ResultEvent ) : void
		{
			roleModel.setRoles( event.result as ArrayCollection );
			roleModel.isRolesLoading = false;
			
			// After the roles is loaded choose the first role as a selected role
			if (roleModel.roles != null && roleModel.roles.length > 0) {
				var firstRole:Role = roleModel.roles.getItemAt(0) as Role;
				loginModel.selectedRole = firstRole;
			}
			
			if (loginModel.isLoginsLoading)
			{
				appModel.isLoginAndRoleLoaded = false;
			}
			else
			{
				appModel.isLoginAndRoleLoaded = true;
			}
			//Alert.show("Role list is loaded");
		}
		
		/** Handle role list fault */
		private function handleGetAllRolesFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Get all roles failure!" );
			roleModel.isRolesLoading = false;
		}
		
		/** Handle role demo result */
		private function handleCreateDemoRoleResult( event : ResultEvent ) : void
		{
			//Alert.show("Demo role is created");
		}
		
		/** Handle role demo fault */
		private function handleCreateDemoRoleFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Demo role creation failure!" );
		}
		
		/** Handle role create result */
		private function handleCreateRoleResult( event : ResultEvent ) : void
		{
			var newRole:Role = event.result as Role;
			Alert.show("New role is created: " + newRole.name);
			getAllRoles();
		}
		
		/** Handle role create fault */
		private function handleCreateRoleFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Role creation failure!" );
		}
	}
}