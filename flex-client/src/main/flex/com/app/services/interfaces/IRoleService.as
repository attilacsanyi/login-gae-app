package com.app.services.interfaces
{
	import app.dto.Role;
	
	import mx.rpc.AsyncToken;

	public interface IRoleService
	{	
		/**
		 * Create a new role.
		 * 
		 * @param role the new role to be saved/created
		 * @return the created role
		 */
		function createRole(role:Role) : AsyncToken;

		/**
		 * Delete all present role objects.
		 * 
		 */
		function deleteAllRoles():AsyncToken;

		/**
		 * Delete role objects.
		 * 
		 * @param role the role which will be deleted
		 */
		function deleteRole(role:Role):AsyncToken;

		/**
		 * Delete role by name.
		 * 
		 * @param role the role name which will be deleted
		 */
		function deleteRoleByName(roleName:String):AsyncToken;
		
		/**
		 * Checks whether a role with the passed name already exists.
		 * 
		 * @param roleName the searched name
		 * @return true if there is already a role with the passed name, otherwise false
		 */
		function existsRole(roleName:String):AsyncToken;

		/**
		 * Finds/loads a role with the passed name.
		 * 
		 * @param name the name of the role to load
		 * @return the founded role or null if there is no role having this name
		 */
		function findRoleByName(roleName:String):AsyncToken;

		/**
		 * Return all present role objects.
		 * 
		 * @return list of existing roles
		 */
		function getAllRoles() : AsyncToken;

		/**
		 * Update the role. Use create role with existing key
		 * 
		 * @param role the new role to be updated
		 * @return the updated role
		 */
		function updateRole(role:Role) : AsyncToken;
	}
}