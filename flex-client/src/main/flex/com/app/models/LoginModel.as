package com.app.models
{
	import app.dto.Login;
	import app.dto.Role;
	
	import com.app.events.LoginEvent;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.collections.ListCollectionView;
	
	public class LoginModel
	{
		[Dispatcher] public var dispatcher:IEventDispatcher;	// Dispatcher
		
		private var _logins:IList;
		private var _createdLogin:Login;	// Use when create a new login
		private var _selectedLogin:Login;	// Use when delete a login
		private var _updatedLogin:Login;	// Use when update a login
		private var _selectedRole:Role;
		private var _isLoginsLoading:Boolean;
		private var _isLoginCreating:Boolean;
		
		public function LoginModel(){
			if (_createdLogin == null) { _createdLogin = new Login;}
			if (_selectedLogin == null) { _selectedLogin = new Login; }
			if (_updatedLogin == null) { _updatedLogin = new Login; }
		}
		
		// *********************************************************
		// Getters/Setters 
		// *********************************************************
		
		[Bindable]
		public function get createdLogin():Login
		{
			return _createdLogin;
		}

		public function set createdLogin(value:Login):void
		{
			_createdLogin = value;
		}

		public function get logins():IList
		{
			return _logins;
		}
		
		public function setLogins( logins:IList ):void
		{
			_logins = logins;
			dispatcher.dispatchEvent( new LoginEvent( LoginEvent.LOGINS_LOADED ) );
		}

		[Bindable]
		public function get isLoginsLoading():Boolean
		{
			return _isLoginsLoading;
		}

		public function set isLoginsLoading(value:Boolean):void
		{
			_isLoginsLoading = value;
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
		public function get isLoginCreating():Boolean
		{
			return _isLoginCreating;
		}

		public function set isLoginCreating(value:Boolean):void
		{
			_isLoginCreating = value;
		}

		[Bindable]
		public function get selectedLogin():Login
		{
			return _selectedLogin;
		}

		public function set selectedLogin(value:Login):void
		{
			_selectedLogin = value;
		}

		[Bindable]
		public function get updatedLogin():Login
		{
			return _updatedLogin;
		}

		public function set updatedLogin(value:Login):void
		{
			_updatedLogin = value;
		}


	}
}