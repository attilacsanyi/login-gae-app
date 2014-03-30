package com.app.models
{
	import app.dto.Customer;
	
	import com.app.events.CustomerEvent;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.IList;
	
	public class CustomerModel
	{
		[Dispatcher] public var dispatcher:IEventDispatcher;	// Dispatcher
		
		private var _customers:IList;
		private var _customer:Customer;
		private var _isCustomersLoading:Boolean;
		
		public function CustomerModel(){
			if (_customer == null) {_customer = new Customer;}
		}
		
		// *********************************************************
		// Getters/Setters 
		// *********************************************************
		
		public function get customers():IList
		{
			return _customers;
		}
		
		public function setCustomers( customers:IList ):void
		{
			_customers = customers;
			dispatcher.dispatchEvent( new CustomerEvent( CustomerEvent.CUSTOMERS_LOADED ) );
		}

		[Bindable]
		public function get isCustomersLoading():Boolean
		{
			return _isCustomersLoading;
		}

		public function set isCustomersLoading(value:Boolean):void
		{
			_isCustomersLoading = value;
		}

		[Bindable]
		public function get customer():Customer
		{
			return _customer;
		}

		public function set customer(value:Customer):void
		{
			_customer = value;
		}
		
	}
}