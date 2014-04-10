package app.services.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import app.services.interfaces.ILoginService;
import app.services.interfaces.ISecurityService;

@Service("securityService")
@RemotingDestination(channels = { "my-amf" })
public class SecurityServiceImpl implements ISecurityService
{

	@Autowired
	ILoginService	loginService;

	@RemotingInclude
	public Map<String, Object> getAuthentication()
	{
		// Create demo login if no login exist and put into result
		if (loginService.getAllLogins().isEmpty())
		{
			loginService.createDemoLogin();
		}

		return getAuthenticationResult();
	}

	/**
	 * @return
	 */
	private Map<String, Object> getAuthenticationResult()
	{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null)
		{
			return null;
		}
		Map<String, Object> authenticationResult = new HashMap<String, Object>();
		authenticationResult.put("name", authentication.getName());
		String[] authorities = new String[authentication.getAuthorities().size()];
		int i = 0;
		for (GrantedAuthority granted : authentication.getAuthorities())
		{
			System.out.println("authority: " + granted.getAuthority());
			// Authority is only a role key stored in getAuthorities() in LoginEntity
			authorities[i++] = granted.getAuthority();
		}
		authenticationResult.put("authorities", authorities);
		return authenticationResult;
	}
}
