package app.services.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import app.domains.RoleEntity;
import app.dto.Role;
import app.mappers.interfaces.IRoleMapper;
import app.repositories.RoleRepository;
import app.services.interfaces.IRoleService;

/**
 * The RoleServiceImpl Class.
 * 
 * Service for loading and saving roles (business delegate pattern).
 * 
 * @author Atka
 */
@Service("roleService")
@RemotingDestination(channels = { "my-amf" })
public class RoleServiceImpl implements IRoleService
{

	// ****************************************************************************************************
	// FIELDS
	// ****************************************************************************************************

	@Autowired
	private IRoleMapper		roleMapper;

	@Autowired
	private RoleRepository	roleRepository;

	// ****************************************************************************************************
	// METHODS
	// ****************************************************************************************************

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.IRoleService#createRole(app.dto.Role)
	 */
	// @Secured( { "ROLE_USER", "ROLE_SUPERVISOR" })
	@RemotingInclude
	public Role createRole(Role role)
	{
		role.setKey(null);
		return mergeRole(role);
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.IRoleService#deleteAllRoles()
	 */
	@Override
	@RemotingInclude
	public void deleteAllRoles()
	{
		roleRepository.deleteAllRoles();
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.IRoleService#deleteRole(app.dto.Role)
	 */
	@RemotingInclude
	public void deleteRole(Role role)
	{
		RoleEntity roleEntity = roleMapper.mapToRoleEntity(role);
		roleRepository.deleteRole(roleEntity);
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.IRoleService#deleteRoleByName(java.lang.String)
	 */
	@RemotingInclude
	public void deleteRoleByName(String roleName)
	{
		RoleEntity roleEntity = roleRepository.findRoleByName(roleName);
		if (roleEntity != null)
		{
			roleRepository.deleteRole(roleEntity);
		}
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.IRoleService#existsRole(java.lang.String)
	 */
	@RemotingInclude
	public boolean existsRole(String name)
	{
		return roleRepository.existsRole(name);
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.IRoleService#findRoleByName(java.lang.String)
	 */
	@RemotingInclude
	public Role findRoleByName(String roleName)
	{
		RoleEntity roleEntity = roleRepository.findRoleByName(roleName);
		return roleMapper.mapToRole(roleEntity);
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.IRoleService#getAllRoles()
	 */
	@RemotingInclude
	public List<Role> getAllRoles()
	{
		List<Role> all = new ArrayList<Role>();

		List<RoleEntity> loadAll = roleRepository.loadAll();
		for (RoleEntity roleEntity : loadAll)
		{
			all.add(roleMapper.mapToRole(roleEntity));
		}

		return all;
	}

	/**
	 * Get the Role Manager
	 * 
	 * @return the Role manager
	 */
	public RoleRepository getRoleManager()
	{
		return roleRepository;
	}

	/**
	 * Merge role. If key not null then create else update
	 * 
	 * @param role the new role
	 * @return the newly created/updated role
	 */
	private Role mergeRole(Role role)
	{
		RoleEntity roleEntity = roleMapper.mapToRoleEntity(role);
		roleEntity = roleRepository.createRole(roleEntity);
		Role result = roleMapper.mapToRole(roleEntity);
		return result;
	}

	/**
	 * Set the Role Manager
	 * 
	 * @param set the roleManager
	 */
	public void setRoleManager(RoleRepository roleManager)
	{
		roleRepository = roleManager;
	}

	/*
	 * (non-Javadoc)
	 * @see app.services.interfaces.IRoleService#updateRole(app.dto.Role)
	 */
	@RemotingInclude
	public Role updateRole(Role role)
	{
		return mergeRole(role);
	}

}
