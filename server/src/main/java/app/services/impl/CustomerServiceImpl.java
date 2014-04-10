package app.services.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Service;

import app.domains.CustomerEntity;
import app.dto.Customer;
import app.mappers.interfaces.ICustomerMapper;
import app.repositories.CustomerRepository;
import app.services.interfaces.ICustomerService;

/**
 * Service for loading and saving customers (business delegate pattern!!).
 * 
 * @author atka
 * @date 06.02.2010
 */
@Service("customerService")
@RemotingDestination(channels = { "my-amf" })
public class CustomerServiceImpl implements ICustomerService
{

	// private static final Logger LOG = Logger.getLogger(CustomerServiceImpl.class.getName());

	@Autowired
	private ICustomerMapper		customerMapper;

	@Autowired
	private CustomerRepository	customerRepository;

	/**
	 * Transactional method.
	 * 
	 * @see app.service.CustomerService#createCustomer(Customer)
	 */
	// @Secured( { "ROLE_USER", "ROLE_SUPERVISOR" })
	@RemotingInclude
	public Customer createCustomer(Customer customer)
	{

		// System.out.println("createCustomer called:");
		// System.out.println("customer.key: " + customer.getKey());
		// System.out.println("customer.city: " + customer.getCity());
		// System.out.println("customer.firstname: " + customer.getFirstname());
		// System.out.println("customer.lastname: " + customer.getLastname());
		// System.out.println("customer.phone: " + customer.getPhone());
		// System.out.println("customer.postal: " + customer.getPostal());
		// System.out.println("customer.street: " + customer.getStreet());
		//
		customer.setKey(null);
		CustomerEntity customerEntity = customerMapper.mapToCustomerEntity(customer);

		// System.out.println("############ 2 " + customerEntity.getFirstname());

		customerEntity = customerRepository.createCustomer(customerEntity);

		// System.out.println("############ 3 " + customerEntity.getFirstname());
		//
		// System.out.println("saved customer called:");
		// System.out.println("customerEntity.id: " + customerEntity.getKey());
		// System.out.println("customerEntity.city: " + customerEntity.getCity());
		// System.out.println("customerEntity.firstname: " + customerEntity.getFirstname());
		// System.out.println("customerEntity.lastname: " + customerEntity.getLastname());
		// System.out.println("customerEntity.phone: " + customerEntity.getPhone());
		// System.out.println("customerEntity.postal: " + customerEntity.getPostal());
		// System.out.println("customerEntity.street: " + customerEntity.getStreet());

		Customer result = customerMapper.mapToCustomer(customerEntity);

		// System.out.println("result customer called:");
		// System.out.println("result_customer.id: " + result.getKey());
		// System.out.println("result_customer.city: " + result.getCity());
		// System.out.println("result_customer.firstname: " + result.getFirstname());
		// System.out.println("result_customer.lastname: " + result.getLastname());
		// System.out.println("result_customer.phone: " + result.getPhone());
		// System.out.println("result_customer.postal: " + result.getPostal());
		// System.out.println("result_customer.street: " + result.getStreet());
		//
		// System.out.println("############ 4 " + result.getFirstname());
		// result.setFirstname("uuuuuuuuuuuuuuuuuuuu");
		return result;
	}

	@RemotingInclude
	public boolean createDemoUser()
	{
		CustomerEntity customerEntity = new CustomerEntity();
		customerEntity.setFirstname("Demo");
		customerEntity.setLastname("Demo");
		customerEntity.setCity("Demo-City");
		customerEntity.setPhone("11111");
		customerEntity.setPostal("12121");
		customerEntity.setStreet("Demo No. 1");

		customerEntity = customerRepository.createCustomer(customerEntity);

		return customerEntity.getKey() != null;
	}

	@RemotingInclude
	public boolean existsCustomer(String phoneNumber)
	{
		return customerRepository.existsCustomer(phoneNumber);
	}

	/**
	 * Transactional read-only method.
	 * 
	 * @see app.service.CustomerService#findCustomerByPhoneNumber(String)
	 */
	@RemotingInclude
	public Customer findCustomerByPhoneNumber(String phoneNumber)
	{
		CustomerEntity cusomerEntity = customerRepository.findCustomerByPhoneNumber(phoneNumber);
		return customerMapper.mapToCustomer(cusomerEntity);
	}

	@RemotingInclude
	public List<Customer> getAllCustomers()
	{
		List<Customer> all = new ArrayList<Customer>();

		List<CustomerEntity> loadAll = customerRepository.loadAll();
		for (CustomerEntity customerEntity : loadAll)
		{
			all.add(customerMapper.mapToCustomer(customerEntity));
		}

		return all;
	}

	/*
	 * Getter & Setter
	 */

	public CustomerRepository getCustomerManager()
	{
		return customerRepository;
	}

	public void setCustomerManager(CustomerRepository customerManager)
	{
		customerRepository = customerManager;
	}

}
