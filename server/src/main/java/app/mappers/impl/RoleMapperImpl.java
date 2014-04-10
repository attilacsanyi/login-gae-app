package app.mappers.impl;

import org.springframework.stereotype.Component;

import app.domains.RoleEntity;
import app.dto.Role;
import app.mappers.interfaces.IRoleMapper;

@Component("roleMapper")
public class RoleMapperImpl implements IRoleMapper
{

	public Role mapToRole(RoleEntity roleEntity)
	{
		if (roleEntity == null)
		{
			return null;
		}
		Role role = new Role();
		// role.setKey(KeyFactory.keyToString(roleEntity.getKey()));
		role.setKey(roleEntity.getKey().toString());
		role.setName(roleEntity.getName());
		role.setDescription(roleEntity.getDescription());
		return role;
	}

	public RoleEntity mapToRoleEntity(Role role)
	{
		if (role == null)
		{
			return null;
		}
		RoleEntity roleEntity = new RoleEntity();
		if (role.getKey() != null)
		{
			// roleEntity.setKey(KeyFactory.stringToKey(role.getKey()));
			roleEntity.setKey(Long.parseLong(role.getKey()));
		}
		roleEntity.setName(role.getName());
		roleEntity.setDescription(role.getDescription());
		return roleEntity;
	}

}
