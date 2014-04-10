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
 * Class implementing a customer entity.
 * 
 * @author iwaszkiewicz
 * @date 06.02.2010
 */
@SuppressWarnings("serial")
@Table(name = "customer")
@Entity
@NamedQueries({
		@NamedQuery(name = "CustomerEntity.findCustomerByPhoneNumber",
				query = "SELECT c FROM CustomerEntity c WHERE c.phone=:phone"),
		@NamedQuery(name = "CustomerEntity.loadAll", query = "SELECT c FROM CustomerEntity c")
})
public class CustomerEntity implements Serializable
{

	private String	city;

	private String	firstname;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	// private Key key;
	private Long	key;

	private String	lastname;

	private String	phone;

	private String	postal;

	private String	street;

	/*
	 * getter & setter
	 */

	public String getCity()
	{
		return city;
	}

	public String getFirstname()
	{
		return firstname;
	}

	public Long getKey()
	{
		return key;
	}

	public String getLastname()
	{
		return lastname;
	}

	public String getPhone()
	{
		return phone;
	}

	public String getPostal()
	{
		return postal;
	}

	public String getStreet()
	{
		return street;
	}

	public void setCity(String city)
	{
		this.city = city;
	}

	public void setFirstname(String firstname)
	{
		this.firstname = firstname;
	}

	public void setKey(Long key)
	{
		this.key = key;
	}

	public void setLastname(String lastname)
	{
		this.lastname = lastname;
	}

	public void setPhone(String phone)
	{
		this.phone = phone;
	}

	public void setPostal(String postal)
	{
		this.postal = postal;
	}

	public void setStreet(String street)
	{
		this.street = street;
	}

}
