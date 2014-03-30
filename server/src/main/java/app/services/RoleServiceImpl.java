package app.services;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.stereotype.Service;

import app.domains.RoleEntity;
import app.dto.Role;
import app.mappers.interfaces.IRoleMapper;
import app.repositories.RoleRepository;
import app.services.interfaces.IRoleService;

/**
 * Service for loading and saving logins (business delegate pattern!!).
 * 
 * @author atka
 * @date 07.26.2011
 */
@Service("roleService")
@RemotingDestination(channels = { "my-amf" })
public class RoleServiceImpl implements IRoleService {

	private static final Logger LOG = Logger.getLogger(RoleServiceImpl.class.getName());

	@Autowired
	private RoleRepository roleRepository;

	@Autowired
	private IRoleMapper roleMapper;

	public boolean existsRole(String name) {
		return this.roleRepository.existsRole(name);
	}

	public boolean createDemoRole() {
		RoleEntity roleEntity = new RoleEntity();
		roleEntity.setName("ROLE_DEMO");
		roleEntity.setDescription("Demo role");

		roleEntity = this.roleRepository.createRole(roleEntity);

		return roleEntity.getKey() != null;
	}

	/**
	 * Transactional read-only method.
	 * 
	 * @see app.service.RoleService#findRoleByName(String)
	 */
	public Role findRoleByName(String name) {
		RoleEntity roleEntity = this.roleRepository.findRoleByName(name);
		return this.roleMapper.mapToRole(roleEntity);
	}

	/**
	 * Transactional method.
	 * 
	 * @see app.service.LoginService#createRole(role)
	 */
	// @Secured( { "ROLE_USER", "ROLE_SUPERVISOR" })
	public Role createRole(Role role) {

		role.setKey(null);
		RoleEntity roleEntity = this.roleMapper.mapToRoleEntity(role);
		roleEntity = this.roleRepository.createRole(roleEntity);
		Role result = this.roleMapper.mapToRole(roleEntity);
		return result;
	}

	public List<Role> getAllRoles() {
		List<Role> all = new ArrayList<Role>();

		List<RoleEntity> loadAll = this.roleRepository.loadAll();
		for (RoleEntity roleEntity : loadAll) {
			all.add(this.roleMapper.mapToRole(roleEntity));
		}

		return all;
	}

	/*
	 * Getter & Setter
	 */

	public RoleRepository getRoleManager() {
		return this.roleRepository;
	}

	public void setRoleManager(RoleRepository roleManager) {
		this.roleRepository = roleManager;
	}

}
