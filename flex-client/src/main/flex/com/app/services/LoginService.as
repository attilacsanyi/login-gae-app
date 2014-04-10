package com.app.services
{
	import app.dto.Login;
	import app.dto.Role;
	
	import com.app.services.interfaces.ILoginService;
	
	import mx.controls.Alert;
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
		
		/**
		 * Add role to Login
		 * 
		 * @param login the login
		 * @param role the new role
		 */
		public function addRoleToLogin(login:Login, role:Role) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "addRoleToLogin";
			op.argumentNames = ["login", "role"];
			op.arguments = [login, role];
			loginService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Create demo login if no logins available
		 * 
		 * @return the newly created demo login
		 */
		public function createDemoLogin() : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "createDemoLogin";
			loginService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Saves a new login.
		 * 
		 * @param login the new login to be saved/created.
		 * @return the created login
		 */
		public function createLogin(login:Login) : AsyncToken
		{	
			//Alert.show((login.roles.getItemAt(0) as Role).name);
			var op:Operation = new Operation();
			
			/*op.name = "createLogin";
			op.argumentNames = ["login", "roles"];
			op.arguments = [login, login.roles.toArray()];
			loginService.operations = [op];*/
			
			op.name = "createLogin";
			op.argumentNames = ["login"];
			op.arguments = [login];
			loginService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Saves a new login with role.
		 * 
		 * @param login the new login to be saved/created.
		 * @param role the role which was applied to login
		 * @return the created loginEntity
		 */
		public function createLoginWithRole(login:Login, role:Role) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "createLoginWithRole";
			op.argumentNames = ["login", "role"];
			op.arguments = [login, role];
			loginService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Delete all present login objects.
		 * 
		 */
		public function deleteAllLogins() : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "deleteAllLogins";
			loginService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Delete login object.
		 * 
		 * @param login the login which will be deleted
		 */
		public function deleteLogin(login:Login) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "deleteLogin";
			op.argumentNames = ["login"];
			op.arguments = [login];
			loginService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Delete login by user name.
		 * 
		 * @param login the login user name which will be deleted
		 */
		public function deleteLoginByName(username:String) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "deleteLoginByName";
			op.argumentNames = ["username"];
			op.arguments = [username];
			loginService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Checks whether a login with the passed user name already exists. <br/>
		 * 
		 * @param username the searched user name
		 * @return true if there is already a login with the passed user name, otherwise false
		 */
		public function existsLogin(username:String) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "existsLogin";
			op.argumentNames = ["username"];
			op.arguments = [username];
			loginService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Finds/loads a login with the passed user name.
		 * 
		 * @param username the user name of the login to load
		 * @return the appertaining login or null if there is no login having this user name
		 */
		public function findLoginByUsername(username:String) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "findLoginByUsername";
			op.argumentNames = ["username"];
			op.arguments = [username];
			loginService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Return all persistent login objects.
		 * 
		 * @return
		 */
		public function getAllLogins() : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "getAllLogins";
			loginService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Remove all role from Login
		 * 
		 * @param login the login
		 */
		public function removeAllRoleFromLogin(login:Login) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "removeAllRoleFromLogin";
			op.argumentNames = ["login"];
			op.arguments = [login];
			loginService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Remove role from Login
		 * 
		 * @param login the login
		 * @param role the removable role
		 */
		public function removeRoleFromLogin(login:Login, role:Role) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "removeRoleFromLogin";
			op.argumentNames = ["login", "role"];
			op.arguments = [login, role];
			loginService.operations = [op];
			
			return op.send();
		}
		
		/**
		 * Update the login. Use create login with existing key
		 * 
		 * @param login the new login to be updated
		 * @return the updated login
		 */
		public function updateLogin(login:Login) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "updateLogin";
			op.argumentNames = ["login"];
			op.arguments = [login];
			loginService.operations = [op];
			
			return op.send();
		}
		
	}
}