package com.app.services.mocks
{
	import app.dto.Login;
	import app.dto.Role;
	
	import com.app.constants.Constants;
	import com.app.services.interfaces.ILoginService;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	
	import org.swizframework.utils.services.MockDelegateHelper;
	
	public class MockLoginService implements ILoginService
	{
		[Inject]
		public var mdh:MockDelegateHelper;
				
		public function getAllLogins():AsyncToken
		{
			//Alert.show(Constants.MOCK_PREFIX + "getAllLogins");		
			return mdh.createMockResult( getFakeLogins(), Constants.MOCK_LOGIN_RESPONSE_TIME );
		}
		
		public function createDemoLogin():AsyncToken
		{
			//Alert.show(Constants.MOCK_PREFIX + "createDemoLogin");
			var demoLogin:Login = new Login;
			demoLogin.key = "1";
			demoLogin.username = "demo";
			demoLogin.password = "demo";
			demoLogin.status = Constants.LOGIN_ACCOUNT_IS_OK;
			
			return mdh.createMockResult( demoLogin, Constants.MOCK_RESPONSE_TIME );
		}
		
		public function createLogin(login:Login):AsyncToken
		{
			Alert.show(Constants.MOCK_PREFIX + "createLogin");
			
			return mdh.createMockResult( login, Constants.MOCK_RESPONSE_TIME );
		}
		
		public function createLoginWithRole(login:Login, role:Role):AsyncToken
		{
			Alert.show(Constants.MOCK_PREFIX + "createLoginWithRole");
			login.roles.addItem(role);
			
			return mdh.createMockResult( login, Constants.MOCK_RESPONSE_TIME );
		}
		
		private function getFakeLogins():ArrayCollection
		{
			var logins:ArrayCollection = new ArrayCollection();
			
			var l1:Login = new Login;
			l1.key = "1";
			l1.username = "demo1";
			l1.password = "demo1";
			l1.status = Constants.LOGIN_ACCOUNT_LOCKED;
			logins.addItem(l1);
			
			l1 = new Login;
			l1.key = "2";
			l1.username = "demo2";
			l1.password = "demo2";
			l1.status = Constants.LOGIN_ACCOUNT_IS_OK;
			logins.addItem(l1);
			
			return logins;
		}
	}
}