package app.mappers.impl;

import org.springframework.stereotype.Component;

import app.domains.CustomerEntity;
import app.dto.Customer;
import app.mappers.interfaces.ICustomerMapper;

@Component("customerMapper")
public class CustomerMapperImpl implements ICustomerMapper
{

	public Customer mapToCustomer(CustomerEntity customerEntity)
	{
		if (customerEntity == null)
		{
			return null;
		}
		Customer customer = new Customer();
		// Key sollte hier niemals null sein
		// customer.setKey(KeyFactory.keyToString(customerEntity.getKey()));
		customer.setKey(customerEntity.getKey().toString());
		customer.setCity(customerEntity.getCity());
		customer.setFirstname(customerEntity.getFirstname());
		customer.setLastname(customerEntity.getLastname());
		customer.setPhone(customerEntity.getPhone());
		customer.setPostal(customerEntity.getPostal());
		customer.setStreet(customerEntity.getStreet());
		return customer;
	}

	public CustomerEntity mapToCustomerEntity(Customer customer)
	{
		if (customer == null)
		{
			return null;
		}
		CustomerEntity customerEntity = new CustomerEntity();
		if (customer.getKey() != null)
		{
			// customerEntity.setKey(KeyFactory.stringToKey(customer.getKey()));
			customerEntity.setKey(Long.parseLong(customer.getKey()));
		}
		customerEntity.setCity(customer.getCity());
		customerEntity.setFirstname(customer.getFirstname());
		customerEntity.setLastname(customer.getLastname());
		customerEntity.setPhone(customer.getPhone());
		customerEntity.setPostal(customer.getPostal());
		customerEntity.setStreet(customer.getStreet());
		return customerEntity;
	}

}
