package com.app.models.presentations
{
	import com.app.events.SecurityEvent;
	import com.app.models.SecurityModel;
	
	import flash.events.IEventDispatcher;

	public class SecurityViewPresentationModel
	{
		[Dispatcher] public var dispatcher:IEventDispatcher;	// Dispatcher
		
		[Inject][Bindable] public var securityModel:SecurityModel;	// Model
		
		public function SecurityViewPresentationModel(){/*For avoid warning*/}
		
		[PostConstruct]
		public function postConstruct():void
		{	
			authenticate();
		}
		
		// *********************************************************
		// Public Methods 
		// *********************************************************

		public function authenticate():void
		{			
			dispatcher.dispatchEvent( new SecurityEvent( SecurityEvent.AUTHENTICATE_REQUESTED ));
			securityModel.isAuthenticationProgress = true;
		}	
		
		public function login():void
		{			
			dispatcher.dispatchEvent(new SecurityEvent( SecurityEvent.LOGIN_REQUESTED/*, securityModel.login*/));
			securityModel.isLoginProgress = true;
		}
		
		public function logout():void
		{
			dispatcher.dispatchEvent( new SecurityEvent( SecurityEvent.LOGOUT_REQUESTED ));
			securityModel.isLogoutProgress = true;
		}

	}
}