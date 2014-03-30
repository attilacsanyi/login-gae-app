package com.app.events
{
	import app.dto.Login;
	
	import org.swizframework.utils.async.AsynchronousEvent;
	
	public class SecurityEvent extends AsynchronousEvent
	{
		
		public static const LOGIN_REQUESTED : String = "login";
		public static const LOGOUT_REQUESTED : String = "logout";
		public static const AUTHENTICATE_REQUESTED : String = "authenticate";
		
		public var login:Login;
		
		/**
		 * This is just a normal Flex event. The only thing to note is that we set 'bubbles' to true,
		 * so that the event will bubble up the display list, allowing Swiz to listen for your events.
		 */
		public function SecurityEvent( type : String, login:Login = null)
		{
			super( type, true );
			this.login = login;
		}
	}
}