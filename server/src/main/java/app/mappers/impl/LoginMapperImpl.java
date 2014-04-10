package app.mappers.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import app.domains.LoginEntity;
import app.domains.RoleEntity;
import app.dto.Login;
import app.dto.Role;
import app.mappers.interfaces.ILoginMapper;
import app.mappers.interfaces.IRoleMapper;

@Component("loginMapper")
public class LoginMapperImpl implements ILoginMapper
{

	@Autowired
	private IRoleMapper	roleMapper;

	public Login mapToLogin(LoginEntity loginEntity)
	{
		if (loginEntity == null)
		{
			return null;
		}
		Login login = new Login();
		// login.setKey(KeyFactory.keyToString(loginEntity.getKey()));
		login.setKey(loginEntity.getKey().toString());
		login.setUsername(loginEntity.getUsername());
		login.setPassword(loginEntity.getPassword());
		login.setStatus(loginEntity.getStatus());

		Collection<Role> loginRoles = new ArrayList<Role>();
		Set<RoleEntity> roles = loginEntity.getRoles();
		if (roles != null && !roles.isEmpty())
		{
			for (RoleEntity roleEntity : roles)
			{
				loginRoles.add(roleMapper.mapToRole(roleEntity));
			}
		}
		login.setRoles(loginRoles);
		return login;
	}

	public LoginEntity mapToLoginEntity(Login login)
	{
		if (login == null)
		{
			return null;
		}
		LoginEntity loginEntity = new LoginEntity();
		if (login.getKey() != null)
		{
			// loginEntity.setKey(KeyFactory.stringToKey(login.getKey()));
			loginEntity.setKey(Long.parseLong(login.getKey()));
		}
		loginEntity.setUsername(login.getUsername());
		loginEntity.setPassword(login.getPassword());
		loginEntity.setStatus(login.getStatus());

		// Collection<Key> loginEntityRoleKeys = new ArrayList<Key>();
		Set<RoleEntity> loginRoles = new HashSet<RoleEntity>();
		Collection<Role> roles = login.getRoles();
		if (roles != null && !roles.isEmpty())
		{
			for (Role role : roles)
			{
				loginRoles.add(roleMapper.mapToRoleEntity(role));
			}
		}
		loginEntity.setRoles(loginRoles);
		return loginEntity;
	}

}
