package com.app.models
{
	import app.dto.Login;
	import app.dto.Role;
	
	import com.app.events.LoginEvent;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.IList;
	
	public class LoginModel
	{
		[Dispatcher] public var dispatcher:IEventDispatcher;	// Dispatcher
		
		private var _logins:IList;
		private var _login:Login;
		private var _selectedRole:Role;
		private var _isLoginsLoading:Boolean;
		private var _isLoginCreating:Boolean;
		
		public function LoginModel(){
			if (_login == null) { _login = new Login; }
		}
		
		// *********************************************************
		// Getters/Setters 
		// *********************************************************
		
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
		public function get login():Login
		{
			return _login;
		}

		public function set login(value:Login):void
		{
			_login = value;
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


	}
}