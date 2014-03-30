package com.app.models.forms
{
	import app.dto.Role;
	
	import com.app.events.LoginEvent;
	import com.app.events.RoleEvent;
	import com.app.models.LoginModel;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.managers.PopUpManager;
	
	import spark.components.TitleWindow;
	
	public class LoginFormPresentationModel
	{
		[Dispatcher] public var dispatcher:IEventDispatcher;		// Dispatcher
		
		[Inject][Bindable] public var loginModel:LoginModel;		// Model
		
		[Inject(source="roleModel.roles", bind="true")]
		[Bindable] public var roles:IList;
		
		[Inject(source="loginModel.selectedRole", bind="true", twoWay="true")]
		[Bindable] public var selectedRole:Role;
		
		public function LoginFormPresentationModel(){/*For avoid warning*/}
				
		// *********************************************************
		// Public Methods 
		// *********************************************************
		
		public function createLogin():void
		{
			loginModel.isLoginCreating = true;
			// Add the selected role
			loginModel.login.roles.addItem(selectedRole);
			dispatcher.dispatchEvent(new LoginEvent( LoginEvent.CREATE, loginModel.login));
		}
		
		public function createLoginWithRole():void
		{
			//dispatcher.dispatchEvent(new LoginEvent( LoginEvent.LOGINS_CREATE_WITH_ROLE, loginModel.login));
		}
		
		public function closeWindow(window:TitleWindow):void
		{
			PopUpManager.removePopUp(window);
		}
		
	}
}