package app.translators;

/** ©2012 All Rights Reserved. */

import org.springframework.flex.core.ExceptionTranslator;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.util.ClassUtils;

import app.constants.Constants;
import app.exceptions.UserNotFoundException;
import app.exceptions.UserRoleNotProperException;
import flex.messaging.MessageException;

/**
 * The UserNotFoundExceptionTranslator Class. Source sample:
 * http://forum.springsource.org/showthread.php?72455-Custom-Exception-Translation
 * 
 * @author Atka
 */
public class UserNotFoundExceptionTranslator implements ExceptionTranslator
{

	/*
	 * (non-Javadoc)
	 * @see org.springframework.flex.core.ExceptionTranslator#handles(java.lang.Class)
	 */
	@Override
	public boolean handles(Class<?> clazz)
	{

		return (!ClassUtils.isAssignable(AuthenticationException.class, clazz)
				&& !ClassUtils.isAssignable(AccessDeniedException.class, clazz))
				|| ClassUtils.isAssignable(UserNotFoundException.class, clazz)
				|| ClassUtils.isAssignable(UserRoleNotProperException.class, clazz);
	}

	/*
	 * (non-Javadoc)
	 * @see org.springframework.flex.core.ExceptionTranslator#translate(java.lang.Throwable)
	 */
	@Override
	public MessageException translate(Throwable t)
	{
		MessageException ex = new MessageException();
		if (t != null)
		{
			if (t instanceof UserNotFoundException)
			{
				ex.setCode(Constants.ERROR_CODE_AUTHENTICATION.toString()); // fault.faultCode
			}
			else if (t instanceof UserRoleNotProperException)
			{
				ex.setCode(Constants.ERROR_CODE_AUTHORIZATION.toString()); // fault.faultCode
			}
			ex.setDetails(((UserRoleNotProperException) t).getMessage()); // fault.faultDetail
			ex.setMessage(t.getMessage()); // fault.faultString
		}

		return ex;
	}
}
