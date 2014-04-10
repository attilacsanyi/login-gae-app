package app.dto;

import java.io.Serializable;
import java.util.Collection;

@SuppressWarnings("serial")
public class Login implements Serializable {
 
	private String key;

    private String username;

    private String password;

    private String status;
    
    private Collection<Role> roles;
    
    /*
     * getter & setter
     */

	public String getKey() {
        return this.key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Collection<Role> getRoles() {
    	return roles;
    }
    
    public void setRoles(Collection<Role> roles) {
    	this.roles = roles;
    }
}
