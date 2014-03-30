package com.app.services.interfaces
{
	import app.dto.Login;
	import app.dto.Role;
	
	import mx.rpc.AsyncToken;

	public interface ILoginService
	{	
		function getAllLogins():AsyncToken;
		function createDemoLogin():AsyncToken;
		function createLoginWithRole(login:Login, role:Role):AsyncToken;
		function createLogin(login:Login):AsyncToken;
	}
}