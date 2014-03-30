package com.app.models.grids
{
	import com.app.events.LoginEvent;
	import com.app.models.LoginModel;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.IList;
	
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
			dispatcher.dispatchEvent(new LoginEvent( LoginEvent.LOGINS_REQUESTED));
			loginModel.isLoginsLoading = true;
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