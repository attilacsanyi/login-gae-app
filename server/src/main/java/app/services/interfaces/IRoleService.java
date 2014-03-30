package app.services.interfaces;

import java.util.List;

import app.dto.Role;

/**
 * Business interface of the role services.
 * 
 * @author atka
 * @date 07.26.2011
 */
public interface IRoleService {

	boolean createDemoRole();

	/**
	 * Checks whether a role with the passed name already exists. <br/>
	 * (pssst - the result should be boolean)
	 * 
	 * @param name
	 *            the searched name
	 * @return true if there is already a role with the passed name, otherwise
	 *         false
	 */
	boolean existsRole(String name);

	/**
	 * Finds/loads a role with the passed name.
	 * 
	 * @param name
	 *            the name of the role to load
	 * @return the appertaining role or null if there is no role having this
	 *         name
	 */
	Role findRoleByName(String name);

	/**
	 * Saves a new role.
	 * 
	 * @param roleEntity
	 *            the new roleEntity to be saved/created.
	 * @return the created roleEntity
	 */
	Role createRole(Role roleEntity);

	/**
	 * Return all perstent role objects.
	 * 
	 * @return
	 */
	List<Role> getAllRoles();
}
