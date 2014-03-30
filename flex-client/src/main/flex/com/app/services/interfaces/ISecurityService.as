package com.app.services.interfaces
{
	import app.dto.Login;
	
	import mx.rpc.AsyncToken;

	public interface ISecurityService
	{
		function login(login:Login):AsyncToken;
		function logout():AsyncToken;
		function authenticate():AsyncToken;
	}
}