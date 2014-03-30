package app.services;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import app.constants.Constants;
import app.domains.LoginEntity;
import app.domains.RoleEntity;
import app.dto.Login;
import app.dto.Role;
import app.mappers.interfaces.ILoginMapper;
import app.mappers.interfaces.IRoleMapper;
import app.repositories.LoginRepository;
import app.repositories.RoleRepository;
import app.services.interfaces.ILoginService;

/**
 * Service for loading and saving logins (business delegate pattern!!).
 * 
 * @author atka
 * @date 07.14.2011
 */
@Service("loginService")
@RemotingDestination(channels = { "my-amf" })
public class LoginServiceImpl implements ILoginService, UserDetailsService {

	private static final Logger LOG = Logger.getLogger(LoginServiceImpl.class
			.getName());

	@Autowired
	private LoginRepository loginRepository;
	
	@Autowired
	private RoleRepository roleRepository;

	@Autowired
	private ILoginMapper loginMapper;
	
	@Autowired
	private IRoleMapper roleMapper;

	public boolean existsLogin(String username) {
		return this.loginRepository.existsLogin(username);
	}

	@Override
	public LoginEntity loadUserByUsername(String username)
			throws UsernameNotFoundException {

		LoginEntity loginEntity = loginMapper
				.mapToLoginEntity(findLoginByUsername(username));

		if (loginEntity == null)
			throw new UsernameNotFoundException("User not found!");

		if (!loginEntity.hasProperRole())
			throw new UsernameNotFoundException("User has no proper role!");

		return loginEntity;
	}

	public boolean createDemoLogin() {
		LoginEntity loginEntity = new LoginEntity();
		loginEntity.setUsername("demo");
		loginEntity.setPassword("demo");
		loginEntity.setStatus(Constants.LOGIN_ACCOUNT_LOCKED);
		loginEntity.setRoles(new ArrayList<RoleEntity>());

		loginEntity = this.loginRepository.createLogin(loginEntity);

		return loginEntity.getKey() != null;
	}

	/**
	 * Transactional read-only method.
	 * 
	 * @see app.service.LoginService#findLoginByUsername(String)
	 */
	public Login findLoginByUsername(String username) {
		LoginEntity loginEntity = this.loginRepository
				.findLoginByUsername(username);
		return this.loginMapper.mapToLogin(loginEntity);
	}

	/**
	 * Transactional method.
	 * 
	 * @see app.service.LoginService#createLogin(Login)
	 */
	// @Secured( { "ROLE_USER", "ROLE_SUPERVISOR" })
	public Login createLogin(Login login) {
		login.setKey(null);
		LoginEntity loginEntity = this.loginMapper.mapToLoginEntity(login);

		loginEntity = this.loginRepository.createLogin(loginEntity);

		Login result = this.loginMapper.mapToLogin(loginEntity);
		return result;
	}
	
	/**
	 * Transactional method.
	 * 
	 * @see app.service.LoginService#createLoginWithRole(Login)
	 */
	// @Secured( { "ROLE_USER", "ROLE_SUPERVISOR" })
	public Login createLoginWithRole(Login login, Role role) {
		login.setKey(null);
		LoginEntity loginEntity = this.loginMapper.mapToLoginEntity(login);
		RoleEntity roleEntity = this.roleMapper.mapToRoleEntity(role);

		// Check if the role is exist or not
		boolean roleExist = this.roleRepository.existsRole(roleEntity.getName());
		if (!roleExist)
		{
			roleEntity = this.roleRepository.createRole(roleEntity);
		}
		loginEntity.addRole(roleEntity);
		loginEntity = this.loginRepository.createLogin(loginEntity);

		Login result = this.loginMapper.mapToLogin(loginEntity);
		return result;
	}

	public List<Login> getAllLogins() {
		List<Login> all = new ArrayList<Login>();
		List<LoginEntity> loadAll = this.loginRepository.loadAll();
		for (LoginEntity loginEntity : loadAll) {
			all.add(this.loginMapper.mapToLogin(loginEntity));
		}

		return all;
	}

	public void addRoleToLogin(Login login, Role role) {
		LoginEntity loginEntity = this.loginMapper.mapToLoginEntity(login);
		RoleEntity roleEntity = this.roleMapper.mapToRoleEntity(role);
		
		loginEntity.addRole(roleEntity);
	}

	public void removeRoleFromLogin(Login login, Role role) {
		LoginEntity loginEntity = this.loginMapper.mapToLoginEntity(login);
		RoleEntity roleEntity = this.roleMapper.mapToRoleEntity(role);
		
		loginEntity.removeRole(roleEntity);
	}

	public void removeAllRoleFromLogin(Login login) {
		LoginEntity loginEntity = this.loginMapper.mapToLoginEntity(login);
		
		loginEntity.removeAllRole();
	}
	
	/*
	 * Getter & Setter
	 */

	public LoginRepository getLoginManager() {
		return this.loginRepository;
	}

	public void setLoginManager(LoginRepository loginManager) {
		this.loginRepository = loginManager;
	}

}
