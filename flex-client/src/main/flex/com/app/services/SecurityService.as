package com.app.services
{
	import app.dto.Login;
	
	import com.app.services.interfaces.ISecurityService;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.Operation;
	import mx.rpc.remoting.RemoteObject;
	
	public class SecurityService implements ISecurityService
	{
		private var securityService:RemoteObject = new RemoteObject;
		
		public function SecurityService()
		{
			securityService.destination = "securityService";
		}
		
		// *********************************************************
		// Public Methods 
		// *********************************************************
		
		public function login( login:Login ) : AsyncToken
		{				 
			return securityService.channelSet.login(login.username, login.password);
		}
		
		public function logout() : AsyncToken
		{	
			return securityService.channelSet.logout();
		}
		
		public function authenticate() : AsyncToken
		{	
			var authOp:Operation = new Operation();
			
			authOp.name = "getAuthentication";
			securityService.operations = [authOp];
			
			return authOp.send();
		}		
	}
}