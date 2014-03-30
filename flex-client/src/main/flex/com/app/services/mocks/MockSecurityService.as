package com.app.services.mocks
{
	import app.dto.Login;
	
	import com.app.constants.Constants;
	import com.app.services.interfaces.ISecurityService;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	
	import org.swizframework.utils.services.MockDelegateHelper;
	
	public class MockSecurityService implements ISecurityService
	{
		[Inject]
		public var mdh:MockDelegateHelper;
		
		private var user:Object;	
		
		public function login(login:Login):AsyncToken
		{
			//Alert.show(Constants.MOCK_PREFIX + username + ", " + password);
			
			var username:String = login.username;
			var password:String = login.password;
			
			if (username == "atka" && password == "atka")
			{
				user = new Object();
				user.name = username;
				user.password = password;
				
				return mdh.createMockResult( user, Constants.MOCK_SECURITY_RESPONSE_TIME );
			}
			else
			{
				var fault:Fault = new Fault("1001", "Invalid user and password");
				return mdh.createMockFault(fault, Constants.MOCK_SECURITY_RESPONSE_TIME);
			}
		}
		
		public function logout():AsyncToken
		{
			//Alert.show(Constants.MOCK_PREFIX + "logout");
			return mdh.createMockResult( new Object, Constants.MOCK_LOGOUT_RESPONSE_TIME );
		}
		
		public function authenticate():AsyncToken
		{
			//Alert.show(Constants.MOCK_PREFIX + "authenticate");
			
			user = new Object();
			user.name = "anonymousUser";
			
			return mdh.createMockResult( user, Constants.MOCK_AUTHENTICATE_RESPONSE_TIME );
		}
		
	}
}