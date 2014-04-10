package com.app.events
{
	import app.dto.Login;
	
	import org.swizframework.utils.async.AsynchronousEvent;
	
	public class LoginEvent extends AsynchronousEvent
	{
		public static const LOGINS_LOADED:String	= "loginsLoaded";
		
		/* CRUD */
		public static const CREATE:String			= "create";
		public static const DELETE:String			= "delete";
		public static const DELETE_ROLE:String		= "deleteRole";
		public static const UPDATE:String			= "update";
		public static const GETALL:String			= "getAll";
		public static const CREATE_WITH_ROLE:String	= "createWithRole"
		public static const ADD_ROLE:String			= "addRole"
		public static const EXISTS:String			= "exists";
		public static const DELALL:String			= "deleteAll";
		public static const DELALL_ROLES:String		= "deleteAllRoles";
		public static const FINDBY:String			= "findByName";
		public static const DELBY:String			= "deleteByName";
		public static const DEMO:String				= "demoLogin";
		
		/**
		 * This is just a normal Flex event. The only thing to note is that we set 'bubbles' to true,
		 * so that the event will bubble up the display list, allowing Swiz to listen for your events.
		 */
		public function LoginEvent( type : String)
		{
			super( type, true );
		}
	}
}