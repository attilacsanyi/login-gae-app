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
		
		private function getFakeLogins():ArrayCollection
		{
			var logins:ArrayCollection = new ArrayCollection();
			
			var roles:ArrayCollection = new ArrayCollection();
			var role1:Role = new Role();
			role1.name = Constants.ROLE_ADMIN;
			role1.description = "Admin role";
			role1.key = "001";
			roles.addItem(role1);
			
			var role2:Role = new Role();
			role2.name = Constants.ROLE_USER;
			role2.description = "User role";
			role2.key = "002";
			roles.addItem(role2);
			
			var l1:Login = new Login;
			l1.key = "1";
			l1.username = "demo1";
			l1.password = "demo1";
			l1.status = Constants.LOGIN_LOCKED;
			l1.roles.addAll(roles);
			
			logins.addItem(l1);
			
			l1 = new Login;
			l1.key = "2";
			l1.username = "demo2";
			l1.password = "demo2";
			l1.status = Constants.LOGIN_ACTIVE;
			l1.roles.addItem(role1);
			
			logins.addItem(l1);
			
			return logins;
		}
		
		public function addRoleToLogin(login:Login, role:Role):AsyncToken
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function createDemoLogin():AsyncToken
		{
			//Alert.show(Constants.MOCK_PREFIX + "createDemoLogin");
			var demoLogin:Login = new Login;
			demoLogin.key = "1";
			demoLogin.username = "demo";
			demoLogin.password = "demo";
			demoLogin.status = Constants.LOGIN_ACTIVE;
			
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

		public function deleteAllLogins():AsyncToken
		{
			// TODO Auto Generated method stub
			return null;
		}

		public function deleteLogin(login:Login):AsyncToken
		{
			// TODO Auto Generated method stub
			return null;
		}

		public function deleteLoginByName(username:String):AsyncToken
		{
			// TODO Auto Generated method stub
			return null;
		}

		public function existsLogin(username:String):AsyncToken
		{
			// TODO Auto Generated method stub
			return null;
		}

		public function findLoginByUsername(username:String):AsyncToken
		{
			// TODO Auto Generated method stub
			return null;
		}

		public function getAllLogins():AsyncToken
		{
			//Alert.show(Constants.MOCK_PREFIX + "getAllLogins");		
			return mdh.createMockResult( getFakeLogins(), Constants.MOCK_LOGIN_RESPONSE_TIME );
		}

		public function removeAllRoleFromLogin(login:Login):AsyncToken
		{
			// TODO Auto Generated method stub
			return null;
		}

		public function removeRoleFromLogin(login:Login, role:Role):AsyncToken
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function updateLogin(login:Login):AsyncToken
		{
			// TODO Auto Generated method stub
			return null;
		}
	}
}