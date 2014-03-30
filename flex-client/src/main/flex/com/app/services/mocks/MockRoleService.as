package com.app.services.mocks
{
	import app.dto.Role;
	
	import com.app.constants.Constants;
	import com.app.services.interfaces.IRoleService;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	
	import org.swizframework.utils.services.MockDelegateHelper;

	public class MockRoleService implements IRoleService
	{
		[Inject]
		public var mdh:MockDelegateHelper;
		
		public function getAllRoles():AsyncToken
		{
			//Alert.show(Constants.MOCK_PREFIX + "getAllRoles");		
			return mdh.createMockResult( getFakeRoles(), Constants.MOCK_ROLE_RESPONSE_TIME );
		}
		
		public function createDemoRole():AsyncToken
		{
			//Alert.show(Constants.MOCK_PREFIX + "createDemoRole");
			var demoRole:Role = new Role;
			demoRole.key = "1";
			demoRole.name = "DEMO_ROLE";
			demoRole.description = "Demo role";
			return mdh.createMockResult( demoRole, Constants.MOCK_RESPONSE_TIME );
		}
		
		public function createRole(role:Role):AsyncToken
		{
			Alert.show(Constants.MOCK_PREFIX + "createRole");
			
			return mdh.createMockResult( role, Constants.MOCK_RESPONSE_TIME );
		}
		
		private function getFakeRoles():ArrayCollection
		{
			var roles:ArrayCollection = new ArrayCollection();
			
			var r1:Role = new Role;
			r1.key = "1";
			r1.name = "ROLE_1";
			r1.description = "Role 1";
			roles.addItem(r1);
			
			r1 = new Role;
			r1.key = "2";
			r1.name = "ROLE_2";
			r1.description = "Role 2";
			roles.addItem(r1);
			
			return roles;
		}
	}
}