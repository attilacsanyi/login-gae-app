package app.mappers;

import java.util.ArrayList;

import app.domains.LoginEntity;
import app.domains.RoleEntity;
import app.dto.Login;
import app.dto.Role;
import app.mappers.interfaces.ILoginMapper;
import app.mappers.interfaces.IRoleMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.google.appengine.api.datastore.KeyFactory;

@Component("loginMapper")
public class LoginMapperImpl implements ILoginMapper {

	@Autowired
	private IRoleMapper roleMapper;
	
    public LoginEntity mapToLoginEntity(Login login){
        if(login == null){
            return null;
        }
        LoginEntity LoginEntity = new LoginEntity();
        if(login.getKey() != null){
            LoginEntity.setKey(KeyFactory.stringToKey(login.getKey()));
        }
        LoginEntity.setUsername(login.getUsername());
        LoginEntity.setPassword(login.getPassword());
        LoginEntity.setStatus(login.getStatus());
        
        ArrayList<RoleEntity> roles = new ArrayList<RoleEntity>();      
        for (Role role : login.getRoles()) {
			roles.add(roleMapper.mapToRoleEntity(role));
		}
        LoginEntity.setRoles(roles);
        return LoginEntity;
    }

    public Login mapToLogin(LoginEntity loginEntity){
        if(loginEntity == null){
            return null;
        }
        Login login = new Login();
        login.setKey(KeyFactory.keyToString(loginEntity.getKey()));
        login.setUsername(loginEntity.getUsername());
        login.setPassword(loginEntity.getPassword());
        login.setStatus(loginEntity.getStatus());
        
        ArrayList<Role> roles = new ArrayList<Role>();      
        for (RoleEntity roleEntity : loginEntity.getRoles()) {
			roles.add(roleMapper.mapToRole((roleEntity)));
		}
        login.setRoles(roles);
        return login;
    }
    
}
