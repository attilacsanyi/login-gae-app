package com.app.models.grids
{
	import com.app.events.RoleEvent;
	import com.app.models.RoleModel;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.IList;

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
			dispatcher.dispatchEvent(new RoleEvent( RoleEvent.ROLES_REQUESTED));
			roleModel.isRolesLoading = true;
		}
		
		// *********************************************************
		// Public Methods 
		// *********************************************************
		
		public function createDemoRole():void
		{
			dispatcher.dispatchEvent(new RoleEvent( RoleEvent.ROLES_DEMO));
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