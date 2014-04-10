package app.dto;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Customer implements Serializable {
 
    private String key;

    private String firstname;

    private String lastname;

    private String phone;

    private String street;

    private String postal;

    private String city;

    /*
     * getter & setter
     */

    public String getPhone() {
        return this.phone;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
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
