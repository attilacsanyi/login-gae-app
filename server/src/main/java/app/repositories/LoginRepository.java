package app.repositories;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import app.constants.Constants;
import app.domains.LoginEntity;
import app.persistence.JpaGenericDAO;

/**
 * The LoginRepository Class.
 * 
 * @author Atka
 */
@Repository("loginManager")
public class LoginRepository
{

	/** The Login DAO */
	private JpaGenericDAO<LoginEntity, Long>	loginDao	= null;

	/**
	 * Create the login.
	 * 
	 * @param loginEntity which will be created
	 * @return the newly created login entity
	 */
	@Transactional
	public LoginEntity createLogin(LoginEntity loginEntity)
	{
		return loginDao.persist(loginEntity);
	}

	/**
	 * Delete all logins.
	 */
	@Transactional
	public void deleteAllLogins()
	{
		List<LoginEntity> list = loadAll();
		for (LoginEntity loginEntity : list)
		{
			// If not the Admin role
			if (!loginEntity.getUsername().equals(Constants.LOGIN_ATKA))
			{
				loginDao.delete(loginEntity.getKey());
			}
		}
	}

	/**
	 * Delete the login.
	 * 
	 * @param loginEntity which will be deleted by its key
	 */
	@Transactional
	public void deleteLogin(LoginEntity loginEntity)
	{
		loginDao.delete(loginEntity.getKey());
	}

	/**
	 * Check login existence by name.
	 * 
	 * @param name is the user name
	 * @return true if the login is exist
	 */
	@Transactional
	public boolean existsLogin(String username)
	{
		return findLoginByUsername(username) != null;
	}

	/**
	 * Find login by user name.
	 * 
	 * @param name the login which is searched
	 * @return the founded login entity
	 */
	@Transactional
	public LoginEntity findLoginByUsername(String username)
	{
		final Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("username", username);
		List<LoginEntity> resultList = loginDao.findByNamedQuery("LoginEntity.findLoginByUsername", parameters);
		if (resultList != null && resultList.size() > 0)
		{
			/* required for fetching all object graph */
			// Source:
			// http://code.google.com/p/academic-cloud/wiki/Exceptions#Caused_by:_javax.jdo.JDODetachedFieldAccessException:_You_have_j
			LoginEntity firstLoginEntity = resultList.get(0);
			firstLoginEntity.getRoles();
			/* required for fetching all object graph */

			return firstLoginEntity;

		}
		return null;
	}

	/**
	 * Load all logins with all roles
	 * 
	 * @return the list of logins
	 */
	@Transactional
	public List<LoginEntity> loadAll()
	{
		List<LoginEntity> list = loginDao.findByNamedQuery("LoginEntity.loadAll");

		/* required for fetching all object graph */
		// Source:
		// http://code.google.com/p/academic-cloud/wiki/Exceptions#Caused_by:_javax.jdo.JDODetachedFieldAccessException:_You_have_j

		for (LoginEntity loginEntity : list)
		{
			loginEntity.getRoles();
		}

		/* required for fetching all object graph */

		System.out.println("---list.size: " + list.size());
		return list;
	}

	/**
	 * Set entity manager (login DAO).
	 * 
	 * @param entityManager the entity manager
	 */
	@PersistenceContext
	public void setEntityManager(EntityManager entityManager)
	{
		loginDao = new JpaGenericDAO<LoginEntity, Long>(entityManager, LoginEntity.class);
	}

	/**
	 * Update the login. The key is exist; the roles, status will be saved.
	 * 
	 * @param loginEntity which will be updated
	 * @return the updated login entity
	 */
	@Transactional
	public LoginEntity updateLogin(LoginEntity loginEntity)
	{
		return loginDao.persist(loginEntity);
	}

}
