package app.persistence;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * @author iwaszkiewicz
 * @date 03.03.2010
 */
public class JpaGenericDAO<E, ID extends Serializable> implements GenericDAO<E, ID> {

    final private Class<E> persistentClass;

    final private EntityManager entityManager;

    public JpaGenericDAO(EntityManager entityManager, Class<E> persistentClass) {
        this.entityManager = entityManager;
        this.persistentClass = persistentClass;
    }

    public E persist(E e) {
        E saved = this.entityManager.merge(e);
        //this.entityManager.flush();
        //this.entityManager.getTransaction().commit();
        return saved;
    }

    public void delete(E e) {
        E forDelete = this.entityManager.getReference(getPersistentClass(), e);
        this.entityManager.remove(forDelete);
        this.entityManager.flush();
    }

    public E load(ID id) {
        return this.entityManager.find(getPersistentClass(), id);
    }

    public boolean exists(ID id) {
        return load(id) != null;
    }

    public List<E> loadAll() {
        return this.entityManager.createQuery("select t from " + getPersistentClass().getSimpleName() + " t")
                .getResultList();
    }

    /**
     * @return the supportedClass
     */
    public Class<E> getPersistentClass() {
        return this.persistentClass;
    }
    
    public List<E> findByNamedQuery(String namedQuery) {
        return findByNamedQuery(namedQuery, null);
    }    
    
    public List<E> findByNamedQuery(String namedQuery, Map<String, Object> parameters) {
        return addParameters(this.entityManager.createNamedQuery(namedQuery), parameters).getResultList();
    }

    private static Query addParameters(Query query, Map<String, Object> parameters) {
        if (null == parameters) {
            return query;
        }
        for (final Map.Entry<String, Object> entry : parameters.entrySet()) {
            query.setParameter(entry.getKey(), entry.getValue());
        }
        return query;

    }

    public List<E> findByNamedQuery(String namedQuery, Map<String, Object> parameters, int firstResult, int maxResults) {
        return addParameters(this.entityManager.createNamedQuery(namedQuery), parameters).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
    public EntityManager getEntityManager(){
        return this.entityManager;
    }
}
