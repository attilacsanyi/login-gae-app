package com.app.constants
{
	import mx.collections.ArrayCollection;

	public final class Constants
	{
		
		// Security errro messages
		public static const ERROR_CODE_AUTHENTICATION:String		= "1001";
		public static const ERROR_CODE_AUTHORIZATION:String			= "1002";
		
        // Role constants
        public static const ROLE_ADMIN:String            		   	= "ROLE_ADMIN";
        public static const ROLE_USER:String             		   	= "ROLE_USER";
        public static const ROLE_GUEST:String						= "ROLE_GUEST";
		public static const ROLE_DEMO:String						= "ROLE_DEMO";
		
		// Login constants
		public static const LOGIN_EXPIRED:String    				= "Expired";
		public static const LOGIN_DISABLED:String    				= "Disabled";
		public static const LOGIN_LOCKED:String     				= "Locked";
		public static const LOGIN_PASSWORD:String					= "Password";
		public static const LOGIN_ACTIVE:String						= "Active";

        // State constants
		public static const STATE_LOGIN:String						= "login";
		public static const STATE_LOGOUT:String						= "logout";
		public static const STATE_CREATE:String						= "create";
		public static const STATE_UPDATE:String						= "update";
		public static const STATE_DELETE:String						= "delete";
		public static const STATE_DELALL:String						= "delall";
		
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