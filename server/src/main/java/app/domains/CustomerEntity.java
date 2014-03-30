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
 * Class implementing a customer entity.
 * 
 * @author iwaszkiewicz
 * @date 06.02.2010
 */
@Table(name = "customer")
@Entity
@NamedQueries({
    @NamedQuery(name = "CustomerEntity.findCustomerByPhoneNumber",
    		query = "SELECT c FROM CustomerEntity c WHERE c.phone=:phone"),
    @NamedQuery(name = "CustomerEntity.loadAll", query = "SELECT c FROM CustomerEntity c") 
})
public class CustomerEntity implements Serializable {
 
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Key key;

    private String firstname;

    private String lastname;

    private String phone;

    private String street;

    private String postal;

    private String city;

    /*
     * getter & setter
     */

    public Key getKey() {
        return this.key;
    }

    public void setKey(Key key) {
        this.key = key;
    }

    public String getPhone() {
        return this.phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getStreet() {
        return this.street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getPostal() {
        return this.postal;
    }

    public void setPostal(String postal) {
        this.postal = postal;
    }

    public String getCity() {
        return this.city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getFirstname() {
        return this.firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return this.lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

}
