package com.app.services
{
	import app.dto.Customer;
	
	import com.app.services.interfaces.ICustomerService;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.Operation;
	import mx.rpc.remoting.RemoteObject;
	
	public class CustomerService implements ICustomerService
	{
		private var customerService:RemoteObject = new RemoteObject;
		
		// *********************************************************
		// Public Methods 
		// *********************************************************
		
		public function CustomerService()
		{
			customerService.destination = "customerService";
		}
		
		public function getAllCustomers() : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "getAllCustomers";
			customerService.operations = [op];
			
			return op.send();
		}
		
		public function createDemoCustomer() : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "createDemoUser";
			customerService.operations = [op];
			
			return op.send();
		}
		
		public function createCustomer(customer:Customer) : AsyncToken
		{	
			var op:Operation = new Operation();
			
			op.name = "createCustomer";
			op.argumentNames = ["customer"];
			op.arguments = [customer];
			customerService.operations = [op];
			
			return op.send();
		}
	}
}