package com.app.events
{
	import app.dto.Login;
	
	import org.swizframework.utils.async.AsynchronousEvent;
	
	public class LoginEvent extends AsynchronousEvent
	{
		public static const LOGINS_LOADED:String				= "loginsLoaded";
		public static const LOGINS_REQUESTED:String				= "getAllLogins";
		public static const LOGINS_DEMO:String					= "createDemoLogin";
		public static const LOGINS_CREATE_WITH_ROLE:String		= "createLoginWithRole"
		
		/* CRUD */
		public static const CREATE:String = "create";
		public static const DELETE:String = "delete";
		public static const UPDATE:String = "update";
		
		public var login:Login;
		
		/**
		 * This is just a normal Flex event. The only thing to note is that we set 'bubbles' to true,
		 * so that the event will bubble up the display list, allowing Swiz to listen for your events.
		 */
		public function LoginEvent( type : String, login:Login = null)
		{
			super( type, true );
			this.login = login;
		}
	}
}