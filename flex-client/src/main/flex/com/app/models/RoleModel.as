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
		private var _createdRole:Role;	// Use when create a new role
		private var _selectedRole:Role;	// Use when delete a role
		private var _updatedRole:Role;	// Use when update a role
		private var _isRolesLoading:Boolean;
		
		public function RoleModel(){
			if (_createdRole == null) { _createdRole = new Role;}
			if (_selectedRole == null) { _selectedRole = new Role;}
			if (_updatedRole == null) { _updatedRole = new Role;}
		}
		
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
		public function get selectedRole():Role
		{
			return _selectedRole;
		}

		public function set selectedRole(value:Role):void
		{
			_selectedRole = value;
		}

		[Bindable]
		public function get createdRole():Role
		{
			return _createdRole;
		}

		public function set createdRole(value:Role):void
		{
			_createdRole = value;
		}

		[Bindable]
		public function get updatedRole():Role
		{
			return _updatedRole;
		}

		public function set updatedRole(value:Role):void
		{
			_updatedRole = value;
		}


	}
}