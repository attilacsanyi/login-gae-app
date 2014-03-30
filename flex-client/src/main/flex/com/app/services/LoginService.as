package com.app.services
{
	import app.dto.Login;
	import app.dto.Role;
	
	import com.app.services.interfaces.ILoginService;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.Operation;
	import mx.rpc.remoting.RemoteObject;
	
	public class LoginService implements ILoginService
	{
		private var loginService:RemoteObject = new RemoteObject;
		
		public function LoginService()
		{
			loginService.destination = "loginService";
		}
		
		// *********************************************************
		// Public Methods 
		// *********************************************************
		
		public function getAllLogins() : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "getAllLogins";
			loginService.operations = [op];
			
			return op.send();
		}
		
		public function createDemoLogin() : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "createDemoLogin";
			loginService.operations = [op];
			
			return op.send();
		}
		
		public function createLogin(login:Login) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "createLogin";
			op.argumentNames = ["login"];
			op.arguments = [login];
			loginService.operations = [op];
			
			return op.send();
		}
		
		public function createLoginWithRole(login:Login, role:Role) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "createLoginWithRole";
			op.argumentNames = ["login", "role"];
			op.arguments = [login, role];
			loginService.operations = [op];
			
			return op.send();
		}
		
	}
}