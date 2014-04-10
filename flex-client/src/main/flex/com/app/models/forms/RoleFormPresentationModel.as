package com.app.models.forms
{
	import com.app.events.RoleEvent;
	import com.app.models.RoleModel;
	
	import flash.events.IEventDispatcher;
	
	import mx.managers.PopUpManager;
	
	import spark.components.TitleWindow;
	
	public class RoleFormPresentationModel
	{
		[Dispatcher] public var dispatcher:IEventDispatcher;		// Dispatcher
		
		[Inject][Bindable] public var roleModel:RoleModel;			// Model
		
		public function RoleFormPresentationModel(){/*For avoid warning*/}
		
		// *********************************************************
		// Public Methods 
		// *********************************************************
		
		public function createRole():void
		{
			dispatcher.dispatchEvent(new RoleEvent( RoleEvent.CREATE ));
		}
		
		public function deleteAllRoles():void
		{
			dispatcher.dispatchEvent(new RoleEvent( RoleEvent.DELALL ));
		}
		
		public function deleteRole():void
		{
			dispatcher.dispatchEvent(new RoleEvent( RoleEvent.DELETE ));
		}
		
		public function updateRole():void
		{
			dispatcher.dispatchEvent(new RoleEvent( RoleEvent.UPDATE ));
		}
		
		public function closeWindow(window:TitleWindow):void
		{
			PopUpManager.removePopUp(window);
		}
		
	}
}