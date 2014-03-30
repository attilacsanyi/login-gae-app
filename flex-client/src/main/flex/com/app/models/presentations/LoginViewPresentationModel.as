package com.app.models.presentations
{
	import com.app.events.LoginEvent;
	import com.app.models.LoginModel;
	import com.app.views.forms.LoginForm;
	
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	
	import mx.managers.PopUpManager;
	
	import org.swizframework.core.ISwiz;
	import org.swizframework.core.ISwizAware;
	
	public class LoginViewPresentationModel implements ISwizAware
	{
		
		[Dispatcher] public var dispatcher:IEventDispatcher;		// Dispatcher
		
		[Inject][Bindable] public var loginModel:LoginModel;	// Model
		
		private var _swiz : ISwiz;
		
		public function LoginViewPresentationModel(){/*For avoid warning*/}
		
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
		
		public function createDemoLogin():void
		{
			dispatcher.dispatchEvent(new LoginEvent( LoginEvent.LOGINS_DEMO));
		}
		
		// *********************************************************
		// EventHandlers 
		// *********************************************************
		
		public function showLoginForm(obj:DisplayObject, state:String):void
		{			
			// Create a modal LoginForm window.
			var loginFormWindow:LoginForm = PopUpManager.createPopUp(obj, LoginForm, true) as LoginForm;
			_swiz.registerWindow( loginFormWindow );
			loginFormWindow.currentState = state;
			PopUpManager.centerPopUp(loginFormWindow);
		}
	}
}