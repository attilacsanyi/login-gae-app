package com.app.models.presentations
{
	import com.app.models.RoleModel;
	import com.app.views.RoleView;
	import com.app.views.forms.RoleForm;
	
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	
	import mx.managers.PopUpManager;
	
	import org.swizframework.core.ISwiz;
	import org.swizframework.core.ISwizAware;
	
	public class RoleViewPresentationModel implements ISwizAware
	{
		
		[Dispatcher] public var dispatcher:IEventDispatcher;		// Dispatcher
		
		[Inject][Bindable] public var roleModel:RoleModel;			// Model
		
		private var _swiz : ISwiz;
		
		public function RoleViewPresentationModel(){/*For avoid warning*/}
				
		// *********************************************************
		// Getter/Setter 
		// *********************************************************
		
		/**
		 * Implement ISwizAware so that we get the Swiz instance injected. We'll use this
		 * to register additional PopUps.
		 */ 
		public function set swiz( swiz : ISwiz ) : void
		{
			_swiz = swiz;
		}
		
		// *********************************************************
		// EventHandlers 
		// *********************************************************
		
		public function showRoleForm(obj:DisplayObject, state:String):void
		{			
			// Create a modal RoleForm window.
			var roleFormWindow:RoleForm = PopUpManager.createPopUp(obj, RoleForm, true) as RoleForm;
			_swiz.registerWindow( roleFormWindow );
			roleFormWindow.roleView = obj as RoleView;
			roleFormWindow.currentState = state;
			PopUpManager.centerPopUp(roleFormWindow);
		}
	}
}