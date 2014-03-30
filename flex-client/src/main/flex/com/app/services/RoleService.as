package com.app.services
{
	import app.dto.Role;
	
	import com.app.services.interfaces.IRoleService;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.Operation;
	import mx.rpc.remoting.RemoteObject;

	public class RoleService implements IRoleService
	{
		private var roleService:RemoteObject = new RemoteObject;
		
		// *********************************************************
		// Public Methods 
		// *********************************************************
		
		public function RoleService()
		{
			roleService.destination = "roleService";
		}
		
		public function getAllRoles() : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "getAllRoles";
			roleService.operations = [op];
			
			return op.send();
		}
		
		public function createDemoRole() : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "createDemoRole";
			roleService.operations = [op];
			
			return op.send();
		}
		
		public function createRole(role:Role) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "createRole";
			op.argumentNames = ["role"];
			op.arguments = [role];
			roleService.operations = [op];
			
			return op.send();
		}
	}
}