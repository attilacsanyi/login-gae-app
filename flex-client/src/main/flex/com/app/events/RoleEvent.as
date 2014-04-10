package com.app.events
{
	import org.swizframework.utils.async.AsynchronousEvent;

	public class RoleEvent extends AsynchronousEvent
	{
		public static const ROLES_LOADED:String = "rolesLoaded";
		
		/* CRUD */
		public static const CREATE:String	= "create";
		public static const DELETE:String	= "delete";
		public static const UPDATE:String	= "update";
		public static const GETALL:String	= "getAll";
		public static const EXISTS:String	= "exists";
		public static const DELALL:String	= "deleteAll";
		public static const FINDBY:String	= "findByName";
		public static const DELBY:String	= "deleteByName";
				
		public function RoleEvent( type:String )
		{
			super( type );
		}
	}
}