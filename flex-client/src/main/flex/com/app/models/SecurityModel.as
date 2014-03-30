package com.app.models
{
	import app.dto.Login;

	public class SecurityModel
	{
		private var _login:Login;
		private var _isLoginProgress:Boolean;
		private var _isLogoutProgress:Boolean;
		
		public function SecurityModel()
		{
			if (_login == null) { _login = new Login;}
		}
		
		// *********************************************************
		// Getters/Setters 
		// *********************************************************
		
		[Bindable]
		public function get isLoginProgress():Boolean
		{
			return _isLoginProgress;
		}

		public function set isLoginProgress(value:Boolean):void
		{
			_isLoginProgress = value;
		}

		[Bindable]
		public function get isLogoutProgress():Boolean
		{
			return _isLogoutProgress;
		}

		public function set isLogoutProgress(value:Boolean):void
		{
			_isLogoutProgress = value;
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
	}
}