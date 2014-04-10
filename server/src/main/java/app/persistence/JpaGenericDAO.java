package app.persistence;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.Query;

/**
 * The JpaGenericDAO Class. API:
 * http://docs.oracle.com/javaee/5/api/javax/persistence/package-summary.html
 * 
 * @author Atka
 */
public class JpaGenericDAO<E, ID extends Serializable> implements GenericDAO<E, ID>
{

	/**
	 * Add parameters to query
	 * 
	 * @param query the query
	 * @param parameters the parameters for query
	 * @return the query with parameters
	 */
	private static Query addParameters(Query query, Map<String, Object> parameters)
	{
		if (null == parameters)
		{
			return query;
		}
		for (final Map.Entry<String, Object> entry : parameters.entrySet())
		{
			query.setParameter(entry.getKey(), entry.getValue());
		}
		return query;

	}

	/** The entity manager */
	/** API: http://download.oracle.com/javaee/6/api/javax/persistence/EntityManager.html */
	final private EntityManager	entityManager;

	/** The persistent class */
	final private Class<E>		persistentClass;

	/**
	 * Creates JpaGenericDAO
	 * 
	 * @param entityManager the entity manager
	 * @param persistentClass the persistent class
	 */
	public JpaGenericDAO(EntityManager entityManager, Class<E> persistentClass)
	{
		this.entityManager = entityManager;
		this.persistentClass = persistentClass;
	}

	/*
	 * (non-Javadoc)
	 * @see app.persistence.GenericDAO#delete(com.google.appengine.api.datastore.Key)
	 */
	@Override
	public void delete(ID id)
	{
		E forDelete = this.entityManager.getReference(getPersistentClass(), id);
		this.entityManager.remove(forDelete);
		this.entityManager.flush();
	}

	/*
	 * (non-Javadoc)
	 * @see app.persistence.GenericDAO#exists(java.io.Serializable)
	 */
	public boolean exists(ID id)
	{
		return load(id) != null;
	}

	/**
	 * Find by name query.
	 * 
	 * @param namedQuery the name of the query
	 * @return the named query result list
	 */
	public List<E> findByNamedQuery(String namedQuery)
	{
		return findByNamedQuery(namedQuery, null);
	}

	/**
	 * Find by name query with parameters support.
	 * 
	 * @param namedQuery the name of the query
	 * @param parameters the query parameters
	 * @return the result list
	 */
	@SuppressWarnings("unchecked")
	public List<E> findByNamedQuery(String namedQuery, Map<String, Object> parameters)
	{
		return addParameters(this.entityManager.createNamedQuery(namedQuery), parameters).getResultList();
	}

	/**
	 * Find by name query with parameters and page support.
	 * 
	 * @param namedQuery the name of the query
	 * @param parameters the query parameters
	 * @param firstResult first page
	 * @param maxResults max result per page
	 * @return the result list of the query
	 */
	@SuppressWarnings("unchecked")
	public List<E> findByNamedQuery(String namedQuery, Map<String, Object> parameters, int firstResult, int maxResults)
	{
		return addParameters(this.entityManager.createNamedQuery(namedQuery), parameters).setFirstResult(firstResult)
				.setMaxResults(maxResults).getResultList();
	}

	/*
	 * (non-Javadoc)
	 * @see app.persistence.GenericDAO#get(com.google.appengine.api.datastore.Key)
	 */
	@Override
	public E get(ID id)
	{
		return this.entityManager.getReference(getPersistentClass(), id);
	}

	/**
	 * Get the entity manager.
	 * 
	 * @return the entity manager
	 */
	public EntityManager getEntityManager()
	{
		return this.entityManager;
	}

	/**
	 * Get the persistent class.
	 * 
	 * @return the supportedClass
	 */
	public Class<E> getPersistentClass()
	{
		return this.persistentClass;
	}

	/*
	 * (non-Javadoc)
	 * @see app.persistence.GenericDAO#load(java.io.Serializable)
	 */
	public E load(ID id)
	{
		return this.entityManager.find(getPersistentClass(), id);
	}

	/*
	 * (non-Javadoc)
	 * @see app.persistence.GenericDAO#loadAll()
	 */
	@SuppressWarnings("unchecked")
	public List<E> loadAll()
	{
		return this.entityManager.createQuery("select t from " + getPersistentClass().getSimpleName() + " t")
				.getResultList();
	}

	/*
	 * (non-Javadoc)
	 * @see app.persistence.GenericDAO#persist(java.lang.Object)
	 */
	public E persist(E e)
	{
		E saved = this.entityManager.merge(e);
		return saved;
	}
}
