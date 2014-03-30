package com.app.models.grids
{
	import com.app.events.CustomerEvent;
	import com.app.models.CustomerModel;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.IList;
	
	public class CustomerGridPresentationModel
	{
		[Dispatcher] public var dispatcher:IEventDispatcher;		// Dispatcher
		
		[Inject][Bindable] public var customerModel:CustomerModel;	// Model
		
		[Inject(source="customerModel.customers", bind="true")]
		[Bindable] public var customers:IList;
		
		public function CustomerGridPresentationModel(){/*For avoid warning*/}
		
		[PostConstruct]
		public function postConstruct():void
		{
			dispatcher.dispatchEvent(new CustomerEvent( CustomerEvent.CUSTOMERS_REQUESTED));
			customerModel.isCustomersLoading = true;
		}
		
		// *********************************************************
		// EventHandlers 
		// *********************************************************
		
		[EventHandler( event="CustomerEvent.CUSTOMERS_LOADED" )]
		public function getLoadedCustomers():void
		{
			customers = customerModel.customers;
		}
	}
}