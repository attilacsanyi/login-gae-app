package app.domains;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import app.constants.Constants;

/**
 * Class implementing a login entity.
 * 
 * @author atka
 * @date 07.14.2011
 */
@SuppressWarnings("serial")
@Table(name = "login")
@Entity
@NamedQueries({
		@NamedQuery(name = "LoginEntity.findLoginByUsername", query = "SELECT l FROM LoginEntity l WHERE l.username=:username"),
		@NamedQuery(name = "LoginEntity.loadAll", query = "SELECT l FROM LoginEntity l") })
public class LoginEntity implements Serializable, UserDetails
{

	private String			accountExpired;
	private String			accountLocked;

	/**
	 * Indicates whether the user's account has expired. An expired account cannot be authenticated.
	 * 
	 * @return <code>true</code> if the user's account is valid (ie non-expired), <code>false</code>
	 *         if no longer valid (ie expired)
	 */
	private boolean			accountNonExpired;

	/**
	 * Indicates whether the user is locked or unlocked. A locked user cannot be authenticated.
	 * 
	 * @return <code>true</code> if the user is not locked, <code>false</code> otherwise
	 */
	private boolean			accountNonLocked;
	private String			credentialsExpired;

	/**
	 * Indicates whether the user's credentials (password) has expired. Expired credentials prevent
	 * authentication.
	 * 
	 * @return <code>true</code> if the user's credentials are valid (ie non-expired),
	 *         <code>false</code> if no longer valid (ie expired)
	 */
	private boolean			credentialsNonExpired;
	private String			disabled;

	/**
	 * Indicates whether the user is enabled or disabled. A disabled user cannot be authenticated.
	 * 
	 * @return <code>true</code> if the user is enabled, <code>false</code> otherwise
	 */
	private boolean			enabled;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	// private Key key;
	private Long			key;

	private String			password;

	/** Store only the role keys */
	// private Collection<Key> roleKeys;

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	private Set<RoleEntity>	roles	= new HashSet<RoleEntity>();

	@SuppressWarnings("unused")
	private String			status;
	private String			username;

	/**
	 * Add new role key to the roles list
	 * 
	 * @param roleKey the key of the new role
	 */
	// public void addRoleKey(Key roleKey)
	// {
	// if (roleKeys == null)
	// {
	// roleKeys = new ArrayList<Key>();
	// }
	// if (!roleKeys.contains(roleKey))
	// {
	// roleKeys.add(roleKey);
	// }
	// }

	/*
	 * private boolean findRole(String role) { boolean founded = false; if (roles != null &&
	 * !roles.isEmpty()) { for (RoleEntity actRole : roles) { if (actRole.getName().equals(role)) {
	 * founded = true; break; } } } return founded; }
	 */

	private String getAccountExpired()
	{
		boolean nonExpired = isAccountNonExpired();
		if (nonExpired)
		{
			setAccountExpired(Constants.LOGIN_EMPTY);
		}
		else
		{
			setAccountExpired(Constants.LOGIN_EXPIRED);
		}

		return accountExpired;
	}

	private String getAccountLocked()
	{
		boolean nonLocked = isAccountNonLocked();
		if (nonLocked)
		{
			setAccountLocked(Constants.LOGIN_EMPTY);
		}
		else
		{
			setAccountLocked(Constants.LOGIN_LOCKED);
		}

		return accountLocked;
	}

	/**
	 * Authority contains the role keys
	 */
	@Override
	public Collection<GrantedAuthority> getAuthorities()
	{
		Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

		// if (roleKeys != null && !roleKeys.isEmpty())
		// {
		// for (Key key : roleKeys)
		// {
		// authorities.add(new GrantedAuthorityImpl(KeyFactory.keyToString(key)));
		// }
		// }

		if (roles != null && !roles.isEmpty())
		{
			for (RoleEntity role : roles)
			{
				authorities.add(new SimpleGrantedAuthority(role.getName()));
			}
		}

		return authorities;
	}

	private String getCredentialsExpired()
	{
		boolean nonExpired = isCredentialsNonExpired();
		if (nonExpired)
		{
			setCredentialsExpired(Constants.LOGIN_EMPTY);
		}
		else
		{
			setCredentialsExpired(Constants.LOGIN_PASSWORD);
		}

		return credentialsExpired;
	}

	/*
	 * getter & setter
	 */

	private String getDisabled()
	{
		boolean enabled = isEnabled();
		if (enabled)
		{
			setDisabled(Constants.LOGIN_EMPTY);
		}
		else
		{
			setDisabled(Constants.LOGIN_DISABLED);
		}

		return disabled;
	}

	public Long getKey()
	{
		return key;
	}

	public String getPassword()
	{
		return password;
	}

	// public Collection<Key> getRoleKeys()
	// {
	// return roleKeys;
	// }

	/**
	 * Get
	 * 
	 * @return the roles
	 */
	public Set<RoleEntity> getRoles()
	{
		return roles;
	}

	public String getStatus()
	{
		String status = Constants.LOGIN_ACTIVE;

		if (!Constants.LOGIN_EMPTY.equals(getAccountExpired()))
		{
			status = getAccountExpired();
		}
		else if (!Constants.LOGIN_EMPTY.equals(getAccountLocked()))
		{
			status = getAccountLocked();
		}
		else if (!Constants.LOGIN_EMPTY.equals(getCredentialsExpired()))
		{
			status = getCredentialsExpired();
		}
		else if (!Constants.LOGIN_EMPTY.equals(getDisabled()))
		{
			status = getDisabled();
		}

		return status;
	}

	public String getUsername()
	{
		return username;
	}

	/**
	 * Check weather the loginEntity has role or not
	 */
	public boolean hasRole()
	{
		// if (roleKeys == null || roleKeys.size() > 0)
		// {
		// return true;
		// }
		if (roles == null || roles.size() > 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	public boolean isAccountNonExpired()
	{
		return accountNonExpired;
	}

	public void isAccountNonExpired(boolean accountNonExpired)
	{
		this.accountNonExpired = accountNonExpired;
	}

	public boolean isAccountNonLocked()
	{
		return accountNonLocked;
	}

	public void isAccountNonLocked(boolean accountNonLocked)
	{
		this.accountNonLocked = accountNonLocked;
	}

	public boolean isCredentialsNonExpired()
	{
		return credentialsNonExpired;
	}

	public void isCredentialsNonExpired(boolean credentialsNonExpired)
	{
		this.credentialsNonExpired = credentialsNonExpired;
	}

	public boolean isEnabled()
	{
		return enabled;
	}

	public void isEnabled(boolean enabled)
	{
		this.enabled = enabled;
	}

	/**
	 * Remove existing role key from the roles list
	 * 
	 * @param role which will be removed
	 */
	public void removeRole(/* Key roleKey */RoleEntity role)
	{
		// if (roleKeys != null && roleKeys.contains(roleKey))
		// {
		// roleKeys.remove(roleKey);
		// }
		if (roles != null && roles.contains(role))
		{
			roles.remove(role);
		}
	}

	private void setAccountExpired(String accountExpired)
	{
		this.accountExpired = accountExpired;
		boolean state = (Constants.LOGIN_EMPTY.equals(accountExpired)) ? true : false;
		isAccountNonExpired(state);
	}

	private void setAccountLocked(String locked)
	{
		accountLocked = locked;
		boolean state = (Constants.LOGIN_EMPTY.equals(locked)) ? true : false;
		isAccountNonLocked(state);
	}

	private void setCredentialsExpired(String credentialsExpired)
	{
		this.credentialsExpired = credentialsExpired;
		boolean state = (Constants.LOGIN_EMPTY.equals(credentialsExpired)) ? true : false;
		isCredentialsNonExpired(state);
	}

	private void setDisabled(String disabled)
	{
		this.disabled = disabled;
		boolean state = (Constants.LOGIN_EMPTY.equals(disabled)) ? true : false;
		isEnabled(state);
	}

	public void setKey(Long key)
	{
		this.key = key;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	// public void setRoleKeys(Collection<Key> roleKeys)
	// {
	// this.roleKeys = roleKeys;
	// }

	public void setRoles(Set<RoleEntity> roles)
	{
		this.roles = roles;
	}

	public void setStatus(String newStatus)
	{
		String status = newStatus;
		String okStatus = Constants.LOGIN_EMPTY;

		if (Constants.LOGIN_EXPIRED.equals(status))
		{
			status = Constants.LOGIN_EXPIRED;
			setAccountExpired(status);
			setAccountLocked(okStatus);
			setCredentialsExpired(okStatus);
			setDisabled(okStatus);
		}
		else if (Constants.LOGIN_LOCKED.equals(status))
		{
			status = Constants.LOGIN_LOCKED;
			setAccountLocked(status);
			setAccountExpired(okStatus);
			setCredentialsExpired(okStatus);
			setDisabled(okStatus);
		}
		else if (Constants.LOGIN_PASSWORD.equals(status))
		{
			status = Constants.LOGIN_PASSWORD;
			setCredentialsExpired(status);
			setAccountExpired(okStatus);
			setAccountLocked(okStatus);
			setDisabled(okStatus);
		}
		else if (Constants.LOGIN_DISABLED.equals(status))
		{
			status = Constants.LOGIN_DISABLED;
			setDisabled(status);
			setAccountExpired(okStatus);
			setAccountLocked(okStatus);
			setCredentialsExpired(okStatus);
		}
		else
		{
			status = Constants.LOGIN_ACTIVE;
			setDisabled(okStatus);
			setAccountExpired(okStatus);
			setAccountLocked(okStatus);
			setCredentialsExpired(okStatus);
		}

		this.status = status;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

}
