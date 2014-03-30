package com.app.constants
{
	public final class Constants
	{
        // Role constants
        public static const ROLE_ADMIN:String            		   	= "ROLE_ADMIN";
        public static const ROLE_USER:String             		   	= "ROLE_USER";
        public static const ROLE_GUEST:String						= "ROLE_GUEST";
		public static const ROLE_DEMO:String						= "ROLE_DEMO";
		
		// Login constants
		public static const LOGIN_ACCOUNT_EXPIRED:String    		= "Account is expired";
		public static const LOGIN_ACCOUNT_DISABLED:String    		= "Account is disabled";
		public static const LOGIN_ACCOUNT_LOCKED:String     		= "Account is locked";
		public static const LOGIN_ACCOUNT_PASSWORD_EXPIRED:String	= "Password is expired";
		public static const LOGIN_ACCOUNT_IS_OK:String       	    = "";

		        
        // State constants
		public static const STATE_LOGGEDIN:String					= "loggedIn";
		public static const STATE_LOGGEDOUT:String					= "loggedOut";
		public static const STATE_DEFAULT:String					= "default";
		public static const STATE_CREATE:String						= "create";
		public static const STATE_UPDATE:String						= "update";
		public static const STATE_DELETE:String						= "delete";
		
		// Mock constants
		public static const MOCK_RESPONSE_TIME:Number				= 1000;
		public static const MOCK_SECURITY_RESPONSE_TIME:Number		= 500;
		public static const MOCK_LOGOUT_RESPONSE_TIME:Number		= 1000;
		public static const MOCK_AUTHENTICATE_RESPONSE_TIME:Number	= 500;
		public static const MOCK_LOGIN_RESPONSE_TIME:Number			= 1500;
		public static const MOCK_ROLE_RESPONSE_TIME:Number			= 1700;
		public static const MOCK_CUSTOMER_RESPONSE_TIME:Number		= 1000;
		public static const MOCK_PREFIX:String						= "MOCK - ";
	}
}