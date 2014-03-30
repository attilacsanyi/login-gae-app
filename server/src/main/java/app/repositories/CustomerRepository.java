package app.repositories;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import app.domains.CustomerEntity;
import app.persistence.JpaGenericDAO;


/**
 * 
 * @author atka
 * @date 07.14.2010
 */
@Repository("customerManager")
public class CustomerRepository {

    private JpaGenericDAO<CustomerEntity, Long> customerDao = null;
    
    @PersistenceContext
    public void setEntityManager(EntityManager entityManager) {
        this.customerDao = new JpaGenericDAO<CustomerEntity, Long>(entityManager, CustomerEntity.class);
    }

    @Transactional
    public boolean existsCustomer(String phoneNumber) {
        return findCustomerByPhoneNumber(phoneNumber) != null;
    }

    @Transactional
    public CustomerEntity findCustomerByPhoneNumber(String phoneNumber) {
        final Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("phone", phoneNumber);
        List<CustomerEntity> resultList = this.customerDao.findByNamedQuery("CustomerEntity.findCustomerByPhoneNumber", parameters);
        if(resultList != null && resultList.size() > 0){
            return resultList.get(0);
        }
        return null;
    }

    @Transactional
    public CustomerEntity createCustomer(CustomerEntity customerEntity) {
        return this.customerDao.persist(customerEntity);
    }
    
    @Transactional
    public List<CustomerEntity> loadAll() {
        List<CustomerEntity> list = this.customerDao.findByNamedQuery("CustomerEntity.loadAll");
        System.out.println("---list.size: " + list.size());
        return list;
    }

}
