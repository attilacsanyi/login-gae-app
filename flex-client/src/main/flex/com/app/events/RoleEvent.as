package com.app.events
{
	import app.dto.Role;
	
	import org.swizframework.utils.async.AsynchronousEvent;

	public class RoleEvent extends AsynchronousEvent
	{
		public static const ROLES_REQUESTED:String = "getAllRoles";
		public static const ROLES_LOADED:String = "rolesLoaded";
		public static const ROLES_DEMO:String = "rolesDemo";
		
		/* CRUD */
		public static const CREATE:String = "create";
		public static const DELETE:String = "delete";
		public static const UPDATE:String = "update";
		
		public var role:Role;
		
		public function RoleEvent( type:String, role:Role = null )
		{
			super( type );
			this.role = role;
		}
	}
}