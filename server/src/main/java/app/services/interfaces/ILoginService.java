package app.services.interfaces;

import java.util.List;

import app.dto.Login;
import app.dto.Role;

/**
 * Business interface of the login services.
 * 
 * @author Atka
 */
public interface ILoginService
{

	/**
	 * Add role to Login
	 * 
	 * @param login the login
	 * @param role the new role
	 */
	void addRoleToLogin(Login login, Role role);

	/**
	 * Create demo login if no logins available
	 * 
	 * @return the newly created demo login
	 */
	Login createDemoLogin();

	/**
	 * Saves a new login.
	 * 
	 * @param login the new login to be saved/created.
	 * @return the created login
	 */
	Login createLogin(Login login);

	/**
	 * Saves a new login with role.
	 * 
	 * @param login the new login to be saved/created.
	 * @param role the role which was applied to login
	 * @return the created loginEntity
	 */
	Login createLoginWithRole(Login login, Role role);

	/**
	 * Delete all present login objects.
	 * 
	 */
	void deleteAllLogins();

	/**
	 * Delete login object.
	 * 
	 * @param login the login which will be deleted
	 */
	void deleteLogin(Login login);

	/**
	 * Delete login by user name.
	 * 
	 * @param login the login user name which will be deleted
	 */
	void deleteLoginByName(String username);

	/**
	 * Checks whether a login with the passed user name already exists. <br/>
	 * 
	 * @param username the searched user name
	 * @return true if there is already a login with the passed user name, otherwise false
	 */
	boolean existsLogin(String username);

	/**
	 * Finds/loads a login with the passed user name.
	 * 
	 * @param username the user name of the login to load
	 * @return the appertaining login or null if there is no login having this user name
	 */
	Login findLoginByUsername(String username);

	/**
	 * Return all persistent login objects.
	 * 
	 * @return
	 */
	List<Login> getAllLogins();

	/**
	 * Remove all role from Login except Admin role
	 * 
	 * @param login the login
	 */
	void removeAllRoleFromLogin(Login login);

	/**
	 * Remove role from Login
	 * 
	 * @param login the login
	 * @param role the removable role
	 */
	void removeRoleFromLogin(Login login, Role role);

	/**
	 * Update the login. Use create login with existing key
	 * 
	 * @param login the new login to be updated
	 * @return the updated login
	 */
	Login updateLogin(Login login);
}
