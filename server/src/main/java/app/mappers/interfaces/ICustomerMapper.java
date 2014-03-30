package app.mappers.interfaces;

import app.domains.CustomerEntity;
import app.dto.Customer;

public interface ICustomerMapper {

    CustomerEntity mapToCustomerEntity(Customer customer);

    Customer mapToCustomer(CustomerEntity customerEntity);
    
}
