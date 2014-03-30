package com.app.controllers
{	
	import app.dto.Customer;
	
	import com.app.models.CustomerModel;
	import com.app.services.interfaces.ICustomerService;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.utils.services.ServiceHelper;
	
	public class CustomerController
	{		
		[Dispatcher] public var dispatcher:IEventDispatcher;	// Dispatcher
		
		[Inject] public var serviceHelper	: ServiceHelper;	// Service Helper
		[Inject] public var customerService : ICustomerService;	// Service Inteface
		[Inject] public var customerModel	: CustomerModel;	// Model
		
		public function CustomerController():void {}
		
		// *********************************************************
		// EventHandlers 
		// *********************************************************
		
		/** Handle customer list event */
		[EventHandler( event="CustomerEvent.CUSTOMERS_REQUESTED" )]
		public function getAllCustomers( ) : void
		{
			serviceHelper.executeServiceCall( customerService.getAllCustomers(), handleGetAllCustomersResult, handleGetAllCustomersFault );
		}
		
		/** Handle customer demo event */
		[EventHandler( event="CustomerEvent.CUSTOMERS_DEMO" )]
		public function createDemoCustomer( ) : void
		{
			serviceHelper.executeServiceCall( customerService.createDemoCustomer(), handleCreateDemoCustomerResult, handleCreateDemoCustomerFault );
		}
		
		/** Handle customer create event */
		[EventHandler( event="CustomerEvent.CREATE", properties="customer" )]
		public function createCustomer(customer:Customer ) : void
		{
			serviceHelper.executeServiceCall( customerService.createCustomer(customer), handleCreateCustomerResult, handleCreateCustomerFault );
		}
		
		// *********************************************************
		// Private Methods 
		// *********************************************************
		
		/** Handle customer list result */
		private function handleGetAllCustomersResult( event : ResultEvent ) : void
		{
			customerModel.setCustomers( event.result as ArrayCollection );
			customerModel.isCustomersLoading = false;
			//Alert.show("Customer list is loaded");
		}
		
		/** Handle customer list fault */
		private function handleGetAllCustomersFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Get all customers failure!" );
			customerModel.isCustomersLoading = false;
		}
		
		/** Handle customer demo result */
		private function handleCreateDemoCustomerResult( event : ResultEvent ) : void
		{
			var demoCustomer:Customer = event.result as Customer;
			Alert.show("Demo customer is created: " + demoCustomer.firstname);
			getAllCustomers();
		}
		
		/** Handle customer demo fault */
		private function handleCreateDemoCustomerFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Demo customer creation failure!" );
		}
		
		/** Handle customer create result */
		private function handleCreateCustomerResult( event : ResultEvent ) : void
		{
			var newCustomer:Customer = event.result as Customer;
			Alert.show("Customer is created: " + newCustomer.firstname);
			getAllCustomers();
		}
		
		/** Handle customer create fault */
		private function handleCreateCustomerFault( event : FaultEvent ) : void
		{
			Alert.show( event.fault.faultString, "Customer creation failure!" );
		}
	}
}