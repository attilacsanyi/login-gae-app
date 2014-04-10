package app.services.interfaces;

import java.util.List;

import app.dto.Role;

/**
 * Business interface of the role services.
 * 
 * @author Atka
 */
public interface IRoleService
{

	/**
	 * Create a new role.
	 * 
	 * @param role the new role to be saved/created
	 * @return the created role
	 */
	Role createRole(Role role);

	/**
	 * Delete all present role objects.
	 * 
	 */
	void deleteAllRoles();

	/**
	 * Delete role objects.
	 * 
	 * @param role the role which will be deleted
	 */
	void deleteRole(Role role);

	/**
	 * Delete role by name.
	 * 
	 * @param role the role name which will be deleted
	 */
	void deleteRoleByName(String roleName);

	/**
	 * Checks whether a role with the passed name already exists.
	 * 
	 * @param roleName the searched name
	 * @return true if there is already a role with the passed name, otherwise false
	 */
	boolean existsRole(String roleName);

	/**
	 * Finds/loads a role with the passed name.
	 * 
	 * @param name the name of the role to load
	 * @return the founded role or null if there is no role having this name
	 */
	Role findRoleByName(String roleName);

	/**
	 * Return all present role objects.
	 * 
	 * @return list of existing roles
	 */
	List<Role> getAllRoles();

	/**
	 * Update the role. Use create role with existing key
	 * 
	 * @param role the new role to be updated
	 * @return the updated role
	 */
	Role updateRole(Role role);

}
