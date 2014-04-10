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
import app.domains.RoleEntity;
import app.persistence.JpaGenericDAO;

/**
 * The RoleRepository Class.
 * 
 * @author Atka
 */
@Repository("roleManager")
public class RoleRepository
{

	/** The Login DAO */
	private JpaGenericDAO<LoginEntity, Long>	loginDao	= null;

	/** The Role DAO */
	private JpaGenericDAO<RoleEntity, Long>		roleDao		= null;

	/**
	 * Create the role.
	 * 
	 * @param roleEntity which will be created
	 * @return the newly created role entity
	 */
	@Transactional
	public RoleEntity createRole(RoleEntity roleEntity)
	{
		return roleDao.persist(roleEntity);
	}

	/**
	 * Delete all roles except Admin role
	 */
	@Transactional
	public void deleteAllRoles()
	{
		List<RoleEntity> list = loadAll();
		for (RoleEntity roleEntity : list)
		{
			// If not the Admin role
			if (!roleEntity.getName().equals(Constants.ROLE_ADMIN))
			{
				removeRoleFromLogins(roleEntity);
				roleDao.delete(roleEntity.getKey());
			}
		}
	}

	/**
	 * Delete the role.
	 * 
	 * @param roleEntity which will be deleted by its key
	 */
	@Transactional
	public void deleteRole(RoleEntity roleEntity)
	{
		removeRoleFromLogins(roleEntity);
		roleDao.delete(roleEntity.getKey());
	}

	/**
	 * Check role existence by name.
	 * 
	 * @param name is the role name
	 * @return true if the role is exist
	 */
	@Transactional
	public boolean existsRole(String name)
	{
		return findRoleByName(name) != null;
	}

	/**
	 * Find role by name.
	 * 
	 * @param name the role which is searched
	 * @return the founded role entity
	 */
	@Transactional
	public RoleEntity findRoleByName(String name)
	{
		final Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("name", name);
		List<RoleEntity> resultList = roleDao.findByNamedQuery("RoleEntity.findRoleByName", parameters);
		if (resultList != null && resultList.size() > 0)
		{
			return resultList.get(0);
		}
		return null;
	}

	/**
	 * Create the role.
	 * 
	 * @param roleEntity which will be created
	 * @return the newly created role entity
	 */
	@Transactional
	public RoleEntity get(Long id)
	{
		return roleDao.get(id);
	}

	/**
	 * Load all roles.
	 * 
	 * @return the list of roles
	 */
	@Transactional
	public List<RoleEntity> loadAll()
	{
		List<RoleEntity> list = roleDao.findByNamedQuery("RoleEntity.loadAll");
		System.out.println("---list.size: " + list.size());
		return list;
	}

	/**
	 * Remove roleKey form logins if a role has deleted
	 * 
	 * @param roleEntity the removable role
	 */
	private void removeRoleFromLogins(RoleEntity roleEntity)
	{
		List<LoginEntity> logins = loginDao.findByNamedQuery("LoginEntity.loadAll");
		for (LoginEntity login : logins)
		{
			login.getRoles().remove(roleEntity);
		}
	}

	/**
	 * Set entity manager (role DAO).
	 * 
	 * @param entityManager the entity manager
	 */
	@PersistenceContext
	public void setEntityManager(EntityManager entityManager)
	{
		roleDao = new JpaGenericDAO<RoleEntity, Long>(entityManager, RoleEntity.class);
		loginDao = new JpaGenericDAO<LoginEntity, Long>(entityManager, LoginEntity.class);
	}

	/**
	 * Update the role. The key is exist; the name and description will be saved.
	 * 
	 * @param roleEntity which will be updated
	 * @return the updated role entity
	 */
	@Transactional
	public RoleEntity updateRole(RoleEntity roleEntity)
	{
		return roleDao.persist(roleEntity);
	}

}
