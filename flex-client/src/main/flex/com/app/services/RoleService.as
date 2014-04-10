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
		
		/**
		 * Create a new role.
		 * 
		 * @param role the new role to be saved/created
		 * @return the created role
		 */
		public function createRole(role:Role) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "createRole";
			op.argumentNames = ["role"];
			op.arguments = [role];
			roleService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Delete all present role objects.
		 * 
		 */
		public function deleteAllRoles():AsyncToken
		{
			var op:Operation = new Operation();
			
			op.name = "deleteAllRoles";
			roleService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Delete role objects.
		 * 
		 * @param role the role which will be deleted
		 */
		public function deleteRole(role:Role):AsyncToken
		{
			var op:Operation = new Operation();
			
			op.name = "deleteRole";
			op.argumentNames = ["role"];
			op.arguments = [role];
			roleService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Delete role by name.
		 * 
		 * @param role the role name which will be deleted
		 */
		public function deleteRoleByName(roleName:String):AsyncToken
		{
			var op:Operation = new Operation();
			
			op.name = "deleteRoleByName";
			op.argumentNames = ["roleName"];
			op.arguments = [roleName];
			roleService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Checks whether a role with the passed name already exists.
		 * 
		 * @param roleName the searched name
		 * @return true if there is already a role with the passed name, otherwise false
		 */
		public function existsRole(roleName:String):AsyncToken
		{
			var op:Operation = new Operation();
			
			op.name = "existsRole";
			op.argumentNames = ["roleName"];
			op.arguments = [roleName];
			roleService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Finds/loads a role with the passed name.
		 * 
		 * @param name the name of the role to load
		 * @return the founded role or null if there is no role having this name
		 */
		public function findRoleByName(roleName:String):AsyncToken
		{
			var op:Operation = new Operation();
			
			op.name = "findRoleByName";
			op.argumentNames = ["roleName"];
			op.arguments = [roleName];
			roleService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Return all present role objects.
		 * 
		 * @return list of existing roles
		 */
		public function getAllRoles() : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "getAllRoles";
			roleService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Update the role. Use create role with existing key
		 * 
		 * @param role the new role to be updated
		 * @return the updated role
		 */
		public function updateRole(role:Role) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "updateRole";
			op.argumentNames = ["role"];
			op.arguments = [role];
			roleService.operations = [op];
			
			return op.send();
		}

	}
}