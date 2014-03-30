package app.services.interfaces;

import java.util.List;

import app.dto.Customer;

/**
 * Business interface of the customer services.
 * 
 * @author iwaszkiewicz
 * @date 06.02.2010
 */
public interface ICustomerService {

    boolean createDemoUser();
    
    /**
     * Checks whether a custoer with the passed phone number already exists. <br/>
     * (pssst - the result should be boolean)
     * 
     * @param phoneNumber
     *            the searched phone number
     * @return true if there is already a customer with the passed phone number, otherwise false
     */
    boolean existsCustomer(String phoneNumber);

    /**
     * Finds/loads a customer with the passed phone number.
     * 
     * @param phoneNumber
     *            the phone number of the cusomer to load
     * @return the appertaining customer or null if there is no customer having this phone number
     */
    Customer findCustomerByPhoneNumber(String phoneNumber);

    /**
     * Saves a new customer.
     * 
     * @param customerEntity
     *            the new customerEntity to be saved/created.
     * @return the created customerEntity
     */
    Customer createCustomer(Customer customerEntity);
    
    /**
     * Return all perstent customer objects.
     * 
     * @return
     */
    List<Customer> getAllCustomers();
}
