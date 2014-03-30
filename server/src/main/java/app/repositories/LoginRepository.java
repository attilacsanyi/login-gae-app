package app.repositories;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import app.domains.LoginEntity;
import app.persistence.JpaGenericDAO;


/**
 * 
 * @author atka
 * @date 07.14.2011
 */
@Repository("loginManager")
public class LoginRepository {

    private JpaGenericDAO<LoginEntity, Long> loginDao = null;
    
    @PersistenceContext
    public void setEntityManager(EntityManager entityManager) {
        this.loginDao = new JpaGenericDAO<LoginEntity, Long>(entityManager, LoginEntity.class);
    }

    @Transactional
    public boolean existsLogin(String username) {
        return findLoginByUsername(username) != null;
    }

    @Transactional
    public LoginEntity findLoginByUsername(String username) {
        final Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("username", username);
        List<LoginEntity> resultList = this.loginDao.findByNamedQuery("LoginEntity.findLoginByUsername", parameters);
        if(resultList != null && resultList.size() > 0){
        	/* required for fetching all object graph */
            // Source: http://code.google.com/p/academic-cloud/wiki/Exceptions#Caused_by:_javax.jdo.JDODetachedFieldAccessException:_You_have_j
        	LoginEntity firstLoginEntity = resultList.get(0);
        	firstLoginEntity.getRoles();
        	return firstLoginEntity;
        }
        return null;
    }

    @Transactional
    public LoginEntity createLogin(LoginEntity loginEntity) {
        return this.loginDao.persist(loginEntity);
    }
    
    @Transactional
    public List<LoginEntity> loadAll() {
        List<LoginEntity> list = this.loginDao.findByNamedQuery("LoginEntity.loadAll");
        
        /* required for fetching all object graph */
        // Source: http://code.google.com/p/academic-cloud/wiki/Exceptions#Caused_by:_javax.jdo.JDODetachedFieldAccessException:_You_have_j
        for (LoginEntity loginEntity : list) {
        	loginEntity.getRoles();
        }
        /* required for fetching all object graph */
        
        System.out.println("---list.size: " + list.size());
        return list;
    }

}
