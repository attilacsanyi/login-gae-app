package com.app.models.grids
{
	import app.dto.Login;
	
	import com.app.events.LoginEvent;
	import com.app.models.LoginModel;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.IList;
	import mx.utils.ObjectUtil;
	
	import spark.components.DataGrid;
	
	public class LoginGridPresentationModel
	{
		[Dispatcher] public var dispatcher:IEventDispatcher;		// Dispatcher
		
		[Inject][Bindable] public var loginModel:LoginModel;		// Model
		
		[Inject(source="loginModel.logins", bind="true")]
		[Bindable] public var logins:IList;
		
		public function LoginGridPresentationModel(){/*For avoid warning*/}
		
		[PostConstruct]
		public function postConstruct():void
		{
			dispatcher.dispatchEvent(new LoginEvent( LoginEvent.GETALL));
			loginModel.isLoginsLoading = true;
		}
		
		// *********************************************************
		// Public Methods 
		// *********************************************************
		
		// Set selected login when click on the login grid	
		public function setSelectedLogin(dg:DataGrid):void
		{
			if (dg.selectedItem != null) {
				var selLogin:Login = dg.selectedItem as Login;
				if (selLogin != null && selLogin is Login)
				{
					loginModel.selectedLogin = selLogin;
					
					// Create copy into updated login object
					loginModel.updatedLogin = ObjectUtil.copy(selLogin) as Login;
				}
			}
		}
		
		// *********************************************************
		// EventHandlers 
		// *********************************************************
		
		[EventHandler( event="LoginEvent.LOGINS_LOADED" )]
		public function getLoadedLogins():void
		{
			logins = loginModel.logins;
		}
	}
}