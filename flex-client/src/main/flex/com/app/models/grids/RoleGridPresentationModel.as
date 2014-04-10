package com.app.models.grids
{
	import app.dto.Role;
	
	import com.app.events.RoleEvent;
	import com.app.models.RoleModel;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.IList;
	import mx.utils.ObjectUtil;
	
	import spark.components.DataGrid;

	public class RoleGridPresentationModel
	{
		[Dispatcher] public var dispatcher:IEventDispatcher;		// Dispatcher
		
		[Inject][Bindable] public var roleModel:RoleModel;			// Model
		
		[Inject(source="roleModel.roles", bind="true")]
		[Bindable] public var roles:IList;
		
		public function RoleGridPresentationModel(){/*For avoid warning*/}
		
		[PostConstruct]
		public function postConstruct():void
		{
			dispatcher.dispatchEvent(new RoleEvent( RoleEvent.GETALL));
			roleModel.isRolesLoading = true;
		}
		
		// *********************************************************
		// Public Methods 
		// *********************************************************
		
		// Set selected role when click on the role grid	
		public function setSelectedRole(dg:DataGrid):void
		{
			if (dg.selectedItem != null) {
				var selRole:Role = dg.selectedItem as Role;
				if (selRole != null && selRole is Role)
				{
					roleModel.selectedRole = selRole;

					// Create copy into updated role object
					roleModel.updatedRole = ObjectUtil.copy(selRole) as Role;
				}
			}
		}
		
		// *********************************************************
		// EventHandlers 
		// *********************************************************
		
		[EventHandler( event="RoleEvent.ROLES_LOADED" )]
		public function getLoadedRoles():void
		{
			roles = roleModel.roles;
		}
	}
}