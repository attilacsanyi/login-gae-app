package app.services.interfaces;

import java.util.Map;

/**
 * Business interface of the login services.
 * 
 * @author atka
 * @date 07.29.2011
 */
public interface ISecurityService {

	Map<String, Object> getAuthentication();
    
}
