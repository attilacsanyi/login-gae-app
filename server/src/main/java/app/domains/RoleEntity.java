package app.domains;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.google.appengine.api.datastore.Key;

/**
 * Class implementing a role entity.
 * 
 * @author atka
 * @date 07.26.2011
 */
@Table(name = "role")
@Entity
@NamedQueries({
		@NamedQuery(name = "RoleEntity.findRoleByName", query = "SELECT l FROM RoleEntity l WHERE l.name=:name"),
		@NamedQuery(name = "RoleEntity.loadAll", query = "SELECT l FROM RoleEntity l") })
public class RoleEntity implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Key key;

	private String name;

	private String description;

	/*
	 * getter & setter
	 */

	public Key getKey() {
		return this.key;
	}

	public void setKey(Key key) {
		this.key = key;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
