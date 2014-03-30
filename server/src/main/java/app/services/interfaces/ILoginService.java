package app.services.interfaces;

import java.util.List;

import app.domains.LoginEntity;
import app.domains.RoleEntity;
import app.dto.Login;
import app.dto.Role;

/**
 * Business interface of the login services.
 * 
 * @author atka
 * @date 07.14.2011
 */
public interface ILoginService {

    boolean createDemoLogin();
    
    /**
     * Checks whether a login with the passed username already exists. <br/>
     * (pssst - the result should be boolean)
     * 
     * @param username
     *            the searched username
     * @return true if there is already a login with the passed username, otherwise false
     */
    boolean existsLogin(String username);

    /**
     * Finds/loads a login with the passed username.
     * 
     * @param username
     *            the username of the login to load
     * @return the appertaining login or null if there is no login having this username
     */
    Login findLoginByUsername(String username);

    /**
     * Saves a new login.
     * 
     * @param login
     *            the new login to be saved/created.
     * @return the created login
     */
    Login createLogin(Login login);
    
    /**
     * Saves a new login with role.
     * 
     * @param login
     *            the new login to be saved/created.
     * @param role the role which was applied to login
     * @return the created loginEntity
     */
    Login createLoginWithRole(Login login, Role role);
    
    /**
     * Return all perstent login objects.
     * 
     * @return
     */
    List<Login> getAllLogins();
    
    /**
     * Add role to Login
     * 
     * @param login the login
     * @param role the new role
     */
	void addRoleToLogin(Login login, Role role);

	/**
     * Remove role from Login
     * 
     * @param login the login
     * @param role the removable role
     */
	void removeRoleFromLogin(Login login, Role role);

	/**
     * Remove all role from Login
     * 
     * @param login the login
     */
	void removeAllRoleFromLogin(Login login);
}
