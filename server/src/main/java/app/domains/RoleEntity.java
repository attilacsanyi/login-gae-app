package app.domains;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * Class implementing a role entity.
 * 
 * @author atka
 */
@SuppressWarnings("serial")
@Table(name = "role")
@Entity
@NamedQueries({
		@NamedQuery(name = "RoleEntity.findRoleByName", query = "SELECT r FROM RoleEntity r WHERE r.name=:name"),
		@NamedQuery(name = "RoleEntity.loadAll", query = "SELECT r FROM RoleEntity r") })
public class RoleEntity implements Serializable
{

	private String	description;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	// private Key key;
	private Long	key;

	private String	name;

	// *********************************************************
	// Getters/Setters
	// *********************************************************

	public String getDescription()
	{
		return description;
	}

	public Long getKey()
	{
		return key;
	}

	public String getName()
	{
		return name;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}

	public void setKey(Long key)
	{
		this.key = key;
	}

	public void setName(String name)
	{
		this.name = name;
	}
}
