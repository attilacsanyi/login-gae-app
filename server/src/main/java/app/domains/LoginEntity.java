package app.domains;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserDetails;

import app.constants.Constants;

import com.google.appengine.api.datastore.Key;

/**
 * Class implementing a login entity.
 * 
 * @author atka
 * @date 07.14.2011
 */
@Table(name = "login")
@Entity
@NamedQueries({
		@NamedQuery(name = "LoginEntity.findLoginByUsername", query = "SELECT l FROM LoginEntity l WHERE l.username=:username"),
		@NamedQuery(name = "LoginEntity.loadAll", query = "SELECT l FROM LoginEntity l") })
public class LoginEntity implements Serializable, UserDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Key key;

	private String username;

	private String password;

	private String status;

	/**
	 * Unidirectional one-to-many association to {@link RoleEntity}.
	 */
	@OneToMany(cascade = CascadeType.ALL)
	private Collection<RoleEntity> roles;

	/**
	 * Indicates whether the user's account has expired. An expired account
	 * cannot be authenticated.
	 * 
	 * @return <code>true</code> if the user's account is valid (ie
	 *         non-expired), <code>false</code> if no longer valid (ie expired)
	 */
	private boolean accountNonExpired;
	private String accountExpired;

	/**
	 * Indicates whether the user is locked or unlocked. A locked user cannot be
	 * authenticated.
	 * 
	 * @return <code>true</code> if the user is not locked, <code>false</code>
	 *         otherwise
	 */
	private boolean accountNonLocked;
	private String accountLocked;

	/**
	 * Indicates whether the user's credentials (password) has expired. Expired
	 * credentials prevent authentication.
	 * 
	 * @return <code>true</code> if the user's credentials are valid (ie
	 *         non-expired), <code>false</code> if no longer valid (ie expired)
	 */
	private boolean credentialsNonExpired;
	private String credentialsExpired;

	/**
	 * Indicates whether the user is enabled or disabled. A disabled user cannot
	 * be authenticated.
	 * 
	 * @return <code>true</code> if the user is enabled, <code>false</code>
	 *         otherwise
	 */
	private boolean enabled;
	private String disabled;

	@Override
	public Collection<GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

		if (roles != null && !roles.isEmpty()) {
			for (RoleEntity role : roles) {
				authorities.add(new GrantedAuthorityImpl(role.getName()));
			}
		}

		return authorities;
	}

	public boolean hasProperRole() {
		return true || findRole(Constants.ROLE_ADMIN) || findRole(Constants.ROLE_USER);
	}

	private boolean findRole(String role) {
		boolean founded = false;
		if (roles != null && !roles.isEmpty()) {
			for (RoleEntity actRole : roles) {
				if (actRole.getName().equals(role)) {
					founded = true;
					break;
				}
			}
		}

		return founded;
	}

	/**
	 * Check weather the loginEntity has role or not
	 */
	public boolean hasRole() {
		if (roles == null || roles.size() > 0) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * Add new role to the roles list
	 * 
	 * @param role
	 *            the new role
	 */
	public void addRole(RoleEntity role) {
		if (roles == null)
			roles = new ArrayList<RoleEntity>();
		if (!roles.contains(role)) {
			roles.add(role);
		}
	}

	/**
	 * Remove existing role from the roles list
	 * 
	 * @param role
	 *            which will be removed
	 */
	public void removeRole(RoleEntity role) {
		if (roles != null && roles.contains(role)) {
			roles.remove(role);
		}
	}

	/**
	 * Remove all role from the roles list
	 * 
	 * @param role
	 *            which will be removed
	 */
	public void removeAllRole() {
		if (roles != null) {
			for (RoleEntity role : roles) {
				roles.remove(role);
			}
		}
	}

	/*
	 * getter & setter
	 */

	public Key getKey() {
		return this.key;
	}

	public void setKey(Key key) {
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

	public boolean isAccountNonExpired() {
		return this.accountNonExpired;
	}

	public void isAccountNonExpired(boolean accountNonExpired) {
		this.accountNonExpired = accountNonExpired;
	}

	private String getAccountExpired() {
		boolean nonExpired = isAccountNonExpired();
		if (nonExpired) {
			setAccountExpired(Constants.LOGIN_ACCOUNT_IS_OK);
		} else {
			setAccountExpired(Constants.LOGIN_ACCOUNT_EXPIRED);
		}

		return this.accountExpired;
	}

	private void setAccountExpired(String accountExpired) {
		this.accountExpired = accountExpired;
		boolean state = (Constants.LOGIN_ACCOUNT_IS_OK.equals(accountExpired)) ? true
				: false;
		isAccountNonExpired(state);
	}

	public boolean isAccountNonLocked() {
		return this.accountNonLocked;
	}

	public void isAccountNonLocked(boolean accountNonLocked) {
		this.accountNonLocked = accountNonLocked;
	}

	private String getAccountLocked() {
		boolean nonLocked = isAccountNonLocked();
		if (nonLocked) {
			setAccountLocked(Constants.LOGIN_ACCOUNT_IS_OK);
		} else {
			setAccountLocked(Constants.LOGIN_ACCOUNT_LOCKED);
		}

		return this.accountLocked;
	}

	private void setAccountLocked(String locked) {
		this.accountLocked = locked;
		boolean state = (Constants.LOGIN_ACCOUNT_IS_OK.equals(locked)) ? true
				: false;
		isAccountNonLocked(state);
	}

	public boolean isCredentialsNonExpired() {
		return this.credentialsNonExpired;
	}

	public void isCredentialsNonExpired(boolean credentialsNonExpired) {
		this.credentialsNonExpired = credentialsNonExpired;
	}

	private String getCredentialsExpired() {
		boolean nonExpired = isCredentialsNonExpired();
		if (nonExpired) {
			setCredentialsExpired(Constants.LOGIN_ACCOUNT_IS_OK);
		} else {
			setCredentialsExpired(Constants.LOGIN_ACCOUNT_PASSWORD_EXPIRED);
		}

		return this.credentialsExpired;
	}

	private void setCredentialsExpired(String credentialsExpired) {
		this.credentialsExpired = credentialsExpired;
		boolean state = (Constants.LOGIN_ACCOUNT_IS_OK
				.equals(credentialsExpired)) ? true : false;
		isCredentialsNonExpired(state);
	}

	public boolean isEnabled() {
		return this.enabled;
	}

	public void isEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	private String getDisabled() {
		boolean enabled = isEnabled();
		if (enabled) {
			setDisabled(Constants.LOGIN_ACCOUNT_IS_OK);
		} else {
			setDisabled(Constants.LOGIN_ACCOUNT_DISABLED);
		}

		return this.disabled;
	}

	private void setDisabled(String disabled) {
		this.disabled = disabled;
		boolean state = (Constants.LOGIN_ACCOUNT_IS_OK.equals(disabled)) ? true
				: false;
		isEnabled(state);
	}

	public Collection<RoleEntity> getRoles() {
		return roles;
	}

	public void setRoles(Collection<RoleEntity> roles) {
		this.roles = roles;
	}

	public String getStatus() {
		String status = Constants.LOGIN_ACCOUNT_IS_OK;

		if (!Constants.LOGIN_ACCOUNT_IS_OK.equals(getAccountExpired())) {
			status = getAccountExpired();
		} else if (!Constants.LOGIN_ACCOUNT_IS_OK.equals(getAccountLocked())) {
			status = getAccountLocked();
		} else if (!Constants.LOGIN_ACCOUNT_IS_OK
				.equals(getCredentialsExpired())) {
			status = getCredentialsExpired();
		} else if (!Constants.LOGIN_ACCOUNT_IS_OK.equals(getDisabled())) {
			status = getDisabled();
		}

		return status;
	}

	public void setStatus(String newStatus) {
		String status = newStatus;
		String okStatus = Constants.LOGIN_ACCOUNT_IS_OK;

		if (Constants.LOGIN_ACCOUNT_EXPIRED.equals(status)) {
			status = Constants.LOGIN_ACCOUNT_EXPIRED;
			setAccountExpired(status);
			setAccountLocked(okStatus);
			setCredentialsExpired(okStatus);
			setDisabled(okStatus);
		} else if (Constants.LOGIN_ACCOUNT_LOCKED.equals(status)) {
			status = Constants.LOGIN_ACCOUNT_LOCKED;
			setAccountLocked(status);
			setAccountExpired(okStatus);
			setCredentialsExpired(okStatus);
			setDisabled(okStatus);
		} else if (Constants.LOGIN_ACCOUNT_PASSWORD_EXPIRED.equals(status)) {
			status = Constants.LOGIN_ACCOUNT_PASSWORD_EXPIRED;
			setCredentialsExpired(status);
			setAccountExpired(okStatus);
			setAccountLocked(okStatus);
			setDisabled(okStatus);
		} else if (Constants.LOGIN_ACCOUNT_DISABLED.equals(status)) {
			status = Constants.LOGIN_ACCOUNT_DISABLED;
			setDisabled(status);
			setAccountExpired(okStatus);
			setAccountLocked(okStatus);
			setCredentialsExpired(okStatus);
		} else {
			status = Constants.LOGIN_ACCOUNT_IS_OK;
			setDisabled(okStatus);
			setAccountExpired(okStatus);
			setAccountLocked(okStatus);
			setCredentialsExpired(okStatus);
		}

		this.status = status;
	}

}
