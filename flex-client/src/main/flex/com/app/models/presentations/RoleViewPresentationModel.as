package com.app.models.presentations
{
	import com.app.events.CustomerEvent;
	import com.app.events.RoleEvent;
	import com.app.models.RoleModel;
	import com.app.views.forms.CustomerForm;
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
		// Public Methods 
		// *********************************************************
		
		public function createDemoRole():void
		{
			dispatcher.dispatchEvent(new RoleEvent( RoleEvent.ROLES_DEMO));
		}
		
		// *********************************************************
		// EventHandlers 
		// *********************************************************
		
		public function showRoleForm(obj:DisplayObject, state:String):void
		{			
			// Create a modal RoleForm window.
			var roleFormWindow:RoleForm = PopUpManager.createPopUp(obj, RoleForm, true) as RoleForm;
			_swiz.registerWindow( roleFormWindow );
			roleFormWindow.currentState = state;
			PopUpManager.centerPopUp(roleFormWindow);
		}
	}
}