package com.app.models.forms
{
	import app.dto.Role;
	
	import com.app.events.LoginEvent;
	import com.app.models.LoginModel;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.collections.IList;
	import mx.managers.PopUpManager;
	
	import spark.components.TitleWindow;
	
	public class LoginFormPresentationModel
	{
		[Dispatcher] public var dispatcher:IEventDispatcher;		// Dispatcher
		
		[Inject][Bindable] public var loginModel:LoginModel;		// Model
		
		[Inject(source="roleModel.roles", bind="true")]
		[Bindable] public var roles:IList;
		
		public function LoginFormPresentationModel(){/*For avoid warning*/}
		
		// *********************************************************
		// Public Methods 
		// *********************************************************
		
		public function createLogin():void
		{
			dispatcher.dispatchEvent(new LoginEvent( LoginEvent.CREATE ));
		}
		
		public function deleteAllLogins():void
		{
			dispatcher.dispatchEvent(new LoginEvent( LoginEvent.DELALL ));
		}
		
		public function deleteLogin():void
		{
			dispatcher.dispatchEvent(new LoginEvent( LoginEvent.DELETE ));
		}
		
		public function updateLogin():void
		{
			dispatcher.dispatchEvent(new LoginEvent( LoginEvent.UPDATE ));
		}
		
		public function createLoginWithRole():void
		{
			dispatcher.dispatchEvent(new LoginEvent( LoginEvent.CREATE_WITH_ROLE ));
		}
		
		public function closeWindow(window:TitleWindow):void
		{
			PopUpManager.removePopUp(window);
		}
		
	}
}