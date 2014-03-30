package app.repositories;

import app.domains.RoleEntity;
import app.persistence.JpaGenericDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


/**
 * 
 * @author atka
 * @date 07.26.2011
 */
@Repository("roleManager")
public class RoleRepository {

    private JpaGenericDAO<RoleEntity, Long> roleDao = null;
    
    @PersistenceContext
    public void setEntityManager(EntityManager entityManager) {
        this.roleDao = new JpaGenericDAO<RoleEntity, Long>(entityManager, RoleEntity.class);
    }

    @Transactional
    public boolean existsRole(String name) {
        return findRoleByName(name) != null;
    }

    @Transactional
    public RoleEntity findRoleByName(String name) {
        final Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("name", name);
        List<RoleEntity> resultList = this.roleDao.findByNamedQuery("RoleEntity.findRoleByName", parameters);
        if(resultList != null && resultList.size() > 0){
            return resultList.get(0);
        }
        return null;
    }

    @Transactional
    public RoleEntity createRole(RoleEntity roleEntity) {
        return this.roleDao.persist(roleEntity);
    }
    
    @Transactional
    public List<RoleEntity> loadAll() {
        List<RoleEntity> list = this.roleDao.findByNamedQuery("RoleEntity.loadAll");
        System.out.println("---list.size: " + list.size());
        return list;
    }

}
