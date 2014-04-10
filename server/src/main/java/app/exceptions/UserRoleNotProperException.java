/** ©2012 All Rights Reserved. */
package app.exceptions;

import org.springframework.security.authentication.BadCredentialsException;

/**
 * The UserNotFoundException Class.
 * 
 * @author Atka
 */
public class UserRoleNotProperException extends BadCredentialsException
{

	/** The generated serial version UID */
	private static final long	serialVersionUID	= -1488462682117372310L;

	/**
	 * @param msg
	 */
	public UserRoleNotProperException(String msg)
	{
		super(msg);
	}

	/**
	 * @param msg
	 * @param extraInformation
	 */
	public UserRoleNotProperException(String msg, Object extraInformation)
	{
		super(msg, extraInformation);
	}

	/**
	 * @param msg
	 * @param t
	 */
	public UserRoleNotProperException(String msg, Throwable t)
	{
		super(msg, t);
	}

}
