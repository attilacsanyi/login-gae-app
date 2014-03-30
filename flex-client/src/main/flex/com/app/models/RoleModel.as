package com.app.models
{
	import app.dto.Role;
	
	import com.app.events.RoleEvent;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.IList;

	public class RoleModel
	{
		[Dispatcher] public var dispatcher:IEventDispatcher;	// Dispatcher
		
		private var _roles:IList;
		private var _role:Role;
		private var _isRolesLoading:Boolean;
		
		public function RoleModel(){}
		
		// *********************************************************
		// Getters/Setters 
		// *********************************************************

		public function get roles():IList
		{
			return _roles;
		}
		
		public function setRoles( roles:IList ):void
		{
			_roles = roles;
			dispatcher.dispatchEvent( new RoleEvent( RoleEvent.ROLES_LOADED ) );
		}
		
		[Bindable]
		public function get isRolesLoading():Boolean
		{
			return _isRolesLoading;
		}
		
		public function set isRolesLoading(value:Boolean):void
		{
			_isRolesLoading = value;
		}

		[Bindable]
		public function get role():Role
		{
			return _role;
		}

		public function set role(value:Role):void
		{
			_role = value;
		}

	}
}