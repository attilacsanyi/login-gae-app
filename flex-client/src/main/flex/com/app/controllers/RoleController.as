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
	import mx.utils.ObjectUtil;
	
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
		[EventHandler( event="RoleEvent.GETALL" )]
		public function getAllRolesHandler() : void
		{
			serviceHelper.executeServiceCall( roleService.getAllRoles(), handleGetAllRolesResult, handleGetAllRolesFault );
		}
				
		/** Handle role create event */
		[EventHandler( event="RoleEvent.CREATE")]
		public function createRoleHandler() : void
		{
			serviceHelper.executeServiceCall( roleService.createRole(roleModel.createdRole), handleCreateRoleResult, handleCreateRoleFault );
		}
		
		/** Handle role delete all event */
		[EventHandler( event="RoleEvent.DELALL")]
		public function deleteAllRolesHandler() : void
		{
			serviceHelper.executeServiceCall( roleService.deleteAllRoles(), handleDeleteAllRolesResult, handleDeleteAllRolesFault );
		}
		
		/** Handle role delete event */
		[EventHandler( event="RoleEvent.DELETE")]
		public function deleteRoleHandler() : void
		{
			serviceHelper.executeServiceCall( roleService.deleteRole(roleModel.selectedRole), handleDeleteRoleResult, handleDeleteRoleFault );
		}
		
		/** Handle role update event */
		[EventHandler( event="RoleEvent.UPDATE")]
		public function updateRoleHandler() : void
		{
			serviceHelper.executeServiceCall( roleService.updateRole(roleModel.updatedRole), handleUpdateRoleResult, handleUpdateRoleFault );
		}
		
		/** Handle find role by name event */
		[EventHandler( event="RoleEvent.FINDBY", properties="role")]
		public function findRoleByNameHandler( role:Role) : void
		{
			serviceHelper.executeServiceCall( roleService.findRoleByName(role.name), handleFindRoleByNameResult, handleFindRoleByNameFault );
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
		}
		
		/** Handle role list fault */
		private function handleGetAllRolesFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Get all roles failure!" );
			roleModel.isRolesLoading = false;
		}
		
		/** Handle role create result */
		private function handleCreateRoleResult( event : ResultEvent ) : void
		{
			getAllRolesHandler();
			
			// Set empty role if creation was successful
			roleModel.createdRole = new Role; 
		}
		
		/** Handle role create fault */
		private function handleCreateRoleFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Role creation failure!" );
		}
		
		/** Handle role delete all result */
		private function handleDeleteAllRolesResult( event : ResultEvent ) : void
		{
			getAllRolesHandler();
		}
		
		/** Handle role delete all fault */
		private function handleDeleteAllRolesFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Delete all roles failure!" );
		}
		
		/** Handle role update result */
		private function handleUpdateRoleResult( event : ResultEvent ) : void
		{
			getAllRolesHandler();

			// Create copy into updated role object
			roleModel.updatedRole = ObjectUtil.copy(roleModel.selectedRole) as Role;
		}
		
		/** Handle role update fault */
		private function handleUpdateRoleFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Update role failure!" );
		}
		
		/** Handle role delete result */
		private function handleDeleteRoleResult( event : ResultEvent ) : void
		{
			getAllRolesHandler();
		}
		
		/** Handle role delete fault */
		private function handleDeleteRoleFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Delete role failure!" );
		}
		
		/** Handle find role by name result */
		private function handleFindRoleByNameResult( event : ResultEvent ) : void
		{
			var foundedRole:Role = event.result as Role;
			Alert.show("Founded role is: " + foundedRole.name);
		}
		
		/** Handle find role by name fault */
		private function handleFindRoleByNameFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Find role by name failure!" );
		}
	}
}