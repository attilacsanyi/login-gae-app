package com.app.services.mocks
{
	import app.dto.Customer;
	
	import com.app.constants.Constants;
	import com.app.services.interfaces.ICustomerService;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	
	import org.swizframework.utils.services.MockDelegateHelper;
	
	public class MockCustomerService implements ICustomerService
	{
		[Inject]
		public var mdh:MockDelegateHelper;
		
		public var customers:ArrayCollection;
		
		public function getAllCustomers():AsyncToken
		{
			//Alert.show(Constants.MOCK_PREFIX + "getAllCustomers");
			customers = new ArrayCollection();
			return mdh.createMockResult( getFakeCustomers(), Constants.MOCK_CUSTOMER_RESPONSE_TIME );
		}
		
		public function createDemoCustomer():AsyncToken
		{
			//Alert.show(Constants.MOCK_PREFIX + "createDemoRole");
			var demoCustomer:Customer = new Customer;
			demoCustomer.key = "1";
			demoCustomer.firstname = "Demo firstname";
			demoCustomer.lastname = "Demo lastname";
			return mdh.createMockResult( demoCustomer, Constants.MOCK_RESPONSE_TIME );
		}
		
		public function createCustomer(customer:Customer):AsyncToken
		{
			//Alert.show(Constants.MOCK_PREFIX + "createCustomer");
			return mdh.createMockResult( customer, Constants.MOCK_RESPONSE_TIME );
		}
		
		private function getFakeCustomers():ArrayCollection
		{
			var c1:Customer = new Customer;
			c1.key = "AAA";
			c1.firstname = "jgjhg";
			c1.city = "fjh";
			c1.lastname = "llll";
			c1.phone = "777";
			c1.postal = "jklhgljg";
			c1.street = "str";
			customers.addItem(c1);
			
			c1 = new Customer;
			c1.key = "BB";
			c1.firstname = "jgjhg";
			c1.city = "fjh";
			c1.lastname = "llll";
			c1.phone = "777";
			c1.postal = "jklhgljg";
			c1.street = "str";
			customers.addItem(c1);
			
			return customers;
		}
	}
}