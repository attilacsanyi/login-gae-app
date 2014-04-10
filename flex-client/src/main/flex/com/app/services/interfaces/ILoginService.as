package com.app.services.interfaces
{
	import app.dto.Login;
	import app.dto.Role;
	
	import mx.rpc.AsyncToken;

	public interface ILoginService
	{	
		/**
		 * Add role to Login
		 * 
		 * @param login the login
		 * @param role the new role
		 */
		function addRoleToLogin(login:Login, role:Role) : AsyncToken;
				
		/**
		 * Create demo login if no logins available
		 * 
		 * @return the newly created demo login
		 */
		function createDemoLogin() : AsyncToken;
		
		/**
		 * Saves a new login.
		 * 
		 * @param login the new login to be saved/created.
		 * @return the created login
		 */
		function createLogin(login:Login) : AsyncToken;
		
		/**
		 * Saves a new login with role.
		 * 
		 * @param login the new login to be saved/created.
		 * @param role the role which was applied to login
		 * @return the created loginEntity
		 */
		function createLoginWithRole(login:Login, role:Role) : AsyncToken;
		
		/**
		 * Delete all present login objects.
		 * 
		 */
		function deleteAllLogins() : AsyncToken;
		
		/**
		 * Delete login object.
		 * 
		 * @param login the login which will be deleted
		 */
		function deleteLogin(login:Login) : AsyncToken;

		/**
		 * Delete login by user name.
		 * 
		 * @param login the login user name which will be deleted
		 */
		function deleteLoginByName(username:String) : AsyncToken;

		/**
		 * Checks whether a login with the passed user name already exists. <br/>
		 * 
		 * @param username the searched user name
		 * @return true if there is already a login with the passed user name, otherwise false
		 */
		function existsLogin(username:String) : AsyncToken;

		/**
		 * Finds/loads a login with the passed user name.
		 * 
		 * @param username the user name of the login to load
		 * @return the appertaining login or null if there is no login having this user name
		 */
		function findLoginByUsername(username:String) : AsyncToken;

		/**
		 * Return all persistent login objects.
		 * 
		 * @return
		 */
		function getAllLogins() : AsyncToken;

		/**
		 * Remove all role from Login
		 * 
		 * @param login the login
		 */
		function removeAllRoleFromLogin(login:Login) : AsyncToken;

		/**
		 * Remove role from Login
		 * 
		 * @param login the login
		 * @param role the removable role
		 */
		function removeRoleFromLogin(login:Login, role:Role) : AsyncToken;

		/**
		 * Update the login. Use create login with existing key
		 * 
		 * @param login the new login to be updated
		 * @return the updated login
		 */
		function updateLogin(login:Login) : AsyncToken;
	}
}