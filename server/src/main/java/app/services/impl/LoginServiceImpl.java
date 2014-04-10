package app.services.impl;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingExclude;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import app.constants.Constants;
import app.domains.LoginEntity;
import app.domains.RoleEntity;
import app.dto.Login;
import app.dto.Role;
import app.exceptions.UserNotFoundException;
import app.exceptions.UserRoleNotProperException;
import app.mappers.interfaces.ILoginMapper;
import app.mappers.interfaces.IRoleMapper;
import app.repositories.LoginRepository;
import app.repositories.RoleRepository;
import app.services.interfaces.ILoginService;

/**
 * The LoginServiceImpl Class.
 * 
 * @author Atka
 */
@Service("loginService")
@RemotingDestination(channels = { "my-amf" })
public class LoginServiceImpl implements ILoginService, UserDetailsService
{

	// ****************************************************************************************************
	// FIELDS
	// ****************************************************************************************************

	@Autowired
	private ILoginMapper	loginMapper;

	@Autowired
	private LoginRepository	loginRepository;

	@Autowired
	private IRoleMapper		roleMapper;

	@Autowired
	private RoleRepository	roleRepository;

	// ****************************************************************************************************
	// METHODS
	// ****************************************************************************************************

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.ILoginService#addRoleToLogin(app.dto.Login, app.dto.Role)
	 */
	@RemotingInclude
	public void addRoleToLogin(Login login, Role role)
	{
		LoginEntity loginEntity = loginMapper.mapToLoginEntity(login);
		loginEntity.getRoles().add(roleMapper.mapToRoleEntity(role));
		loginRepository.updateLogin(loginEntity);
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.ILoginService#createDemoLogin()
	 */
	@RemotingExclude
	public Login createDemoLogin()
	{
		Login demoLogin = new Login();
		demoLogin.setUsername("atka");
		demoLogin.setPassword("atka");
		demoLogin.setStatus(Constants.LOGIN_ACTIVE);

		Role roleUser = new Role();
		roleUser.setName(Constants.ROLE_ADMIN);
		roleUser.setDescription("Admin role");

		return createLoginWithRole(demoLogin, roleUser);
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.ILoginService#createLogin(app.dto.Login)
	 */
	@RemotingInclude
	public Login createLogin(Login login)
	{
		login.setKey(null);
		return mergeLogin(login);
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.ILoginService#createLoginWithRole(app.dto.Login, app.dto.Role)
	 */
	@RemotingInclude
	public Login createLoginWithRole(Login login, Role role)
	{
		login.setKey(null);
		LoginEntity loginEntity = loginMapper.mapToLoginEntity(login);

		// Check if the role is exist or not
		RoleEntity roleEntity = roleRepository.findRoleByName(role.getName());
		if (roleEntity == null)
		{
			// Create the role, because not exist
			roleEntity = roleRepository.createRole(roleMapper.mapToRoleEntity(role));
		}

		Set<RoleEntity> roles = new HashSet<RoleEntity>();
		roles.add(roleEntity);
		loginEntity.setRoles(roles);

		loginEntity = loginRepository.createLogin(loginEntity);

		Login result = loginMapper.mapToLogin(loginEntity);
		return result;
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.ILoginService#deleteAllLogins()
	 */
	@RemotingInclude
	public void deleteAllLogins()
	{
		loginRepository.deleteAllLogins();
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.ILoginService#deleteLogin(app.dto.Login)
	 */
	@RemotingInclude
	public void deleteLogin(Login login)
	{
		LoginEntity loginEntity = loginMapper.mapToLoginEntity(login);
		loginRepository.deleteLogin(loginEntity);
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.ILoginService#deleteLoginByName(java.lang.String)
	 */
	@RemotingInclude
	public void deleteLoginByName(String username)
	{
		LoginEntity loginEntity = loginRepository.findLoginByUsername(username);
		if (loginEntity != null)
		{
			loginRepository.deleteLogin(loginEntity);
		}
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.ILoginService#existsLogin(java.lang.String)
	 */
	@RemotingInclude
	public boolean existsLogin(String username)
	{
		return loginRepository.existsLogin(username);
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.ILoginService#findLoginByUsername(java.lang.String)
	 */
	@RemotingInclude
	public Login findLoginByUsername(String username)
	{
		LoginEntity loginEntity = loginRepository.findLoginByUsername(username);
		return loginMapper.mapToLogin(loginEntity);
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.ILoginService#getAllLogins()
	 */
	@RemotingInclude
	public List<Login> getAllLogins()
	{
		List<Login> all = new ArrayList<Login>();
		List<LoginEntity> loadAll = loginRepository.loadAll();
		for (LoginEntity loginEntity : loadAll)
		{
			all.add(loginMapper.mapToLogin(loginEntity));
		}

		return all;
	}

	/**
	 * Get the Login Manager
	 * 
	 * @return the Login Manager
	 */
	public LoginRepository getLoginManager()
	{
		return loginRepository;
	}

	/**
	 * @param loginEntity
	 * @return
	 */
	private boolean isUserOrAdmin(LoginEntity loginEntity)
	{
		Set<RoleEntity> roles = loginEntity.getRoles();

		if (roles != null)
		{
			String roleName = null;
			for (RoleEntity roleEntity : roles)
			{
				roleName = roleEntity.getName();
				if (roleName.equals(Constants.ROLE_ADMIN)
						|| roleName.equals(Constants.ROLE_USER))
				{
					return true;
				}
			}
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * @see
	 * org.springframework.security.core.userdetails.UserDetailsService#loadUserByUsername(java.
	 * lang.String)
	 */
	@Override
	@RemotingInclude
	public LoginEntity loadUserByUsername(String username) throws UsernameNotFoundException
	{

		LoginEntity loginEntity = loginMapper.mapToLoginEntity(findLoginByUsername(username));

		if (loginEntity == null)
		{
			throw new UserNotFoundException(
					MessageFormat.format(Constants.ERROR_AUTHENTICATION_USER_NOT_EXIST, username));
		}

		if (!isUserOrAdmin(loginEntity))
		{
			throw new UserRoleNotProperException(
					MessageFormat.format(Constants.ERROR_AUTHORIZATION_NOT_PROPER_ROLE, username),
					Constants.ERROR_AUTHORIZATION_PROPER_ROLES);
		}

		return loginEntity;
	}

	/**
	 * Merge login. If key not null then create else update
	 * 
	 * @param login the new login
	 * @return the newly created/updated login
	 */
	@RemotingExclude
	private Login mergeLogin(Login login)
	{
		LoginEntity loginEntity = loginMapper.mapToLoginEntity(login);
		loginEntity = loginRepository.createLogin(loginEntity);
		Login result = loginMapper.mapToLogin(loginEntity);
		return result;
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.ILoginService#removeAllRoleFromLogin(app.dto.Login)
	 */
	@RemotingInclude
	public void removeAllRoleFromLogin(Login login)
	{
		LoginEntity loginEntity = loginMapper.mapToLoginEntity(login);

		Set<RoleEntity> roles = loginEntity.getRoles();

		for (RoleEntity roleEntity : roles)
		{
			// If not the Admin role
			if (!(roleRepository.get(roleEntity.getKey())).getName().equals(Constants.ROLE_ADMIN))
			{
				loginEntity.removeRole(roleEntity);
			}
		}
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.ILoginService#removeRoleFromLogin(app.dto.Login, app.dto.Role)
	 */
	@RemotingInclude
	public void removeRoleFromLogin(Login login, Role role)
	{
		LoginEntity loginEntity = loginMapper.mapToLoginEntity(login);
		loginEntity.removeRole(roleMapper.mapToRoleEntity(role));
	}

	/**
	 * Set the Login Manager
	 * 
	 * @param set the loginManager
	 */
	public void setLoginManager(LoginRepository loginManager)
	{
		loginRepository = loginManager;
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.ILoginService#updateLogin(app.dto.Login)
	 */
	@RemotingInclude
	public Login updateLogin(Login login)
	{
		return mergeLogin(login);
	}
}
