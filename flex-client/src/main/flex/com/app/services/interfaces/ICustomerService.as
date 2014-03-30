package com.app.services.interfaces
{
	import app.dto.Customer;
	
	import mx.rpc.AsyncToken;

	public interface ICustomerService
	{
		function getAllCustomers():AsyncToken;
		function createDemoCustomer():AsyncToken;
		function createCustomer(customer:Customer):AsyncToken;
	}
}