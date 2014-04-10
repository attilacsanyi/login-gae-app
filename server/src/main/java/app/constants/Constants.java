package app.constants;

public final class Constants
{

	// Security constants messages
	public static final String	ERROR_AUTHENTICATION_USER_NOT_EXIST	= "The given ''{0}'' user is not found, please give an existing user";
	public static final String	ERROR_AUTHORIZATION_NOT_PROPER_ROLE	= "The given ''{0}'' user has not proper role";
	public static final String	ERROR_AUTHORIZATION_PROPER_ROLES	= "Only users and admins can log in";

	// Security error codes
	public static final String	ERROR_CODE_AUTHENTICATION			= "1001";
	public static final String	ERROR_CODE_AUTHORIZATION			= "1002";

	// Login constants
	public static final String	LOGIN_ACTIVE						= "Active";
	public static final String	LOGIN_ATKA							= "atka";
	public static final String	LOGIN_DISABLED						= "Disabled";
	public static final String	LOGIN_EMPTY							= "";
	public static final String	LOGIN_EXPIRED						= "Expired";
	public static final String	LOGIN_LOCKED						= "Locked";
	public static final String	LOGIN_PASSWORD						= "Password";

	// Role constants
	public static final String	ROLE_ADMIN							= "ROLE_ADMIN";
	public static final String	ROLE_DEMO							= "ROLE_DEMO";
	public static final String	ROLE_GUEST							= "ROLE_GUEST";
	public static final String	ROLE_USER							= "ROLE_USER";
}
