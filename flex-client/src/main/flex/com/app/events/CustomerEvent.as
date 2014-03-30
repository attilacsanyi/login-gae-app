package com.app.events
{
	import app.dto.Customer;
	
	import org.swizframework.utils.async.AsynchronousEvent;
	
	public class CustomerEvent extends AsynchronousEvent
	{
		public static const CUSTOMERS_REQUESTED:String = "getAllCustomers";
		public static const CUSTOMERS_LOADED:String = "customersLoaded";
		public static const CUSTOMERS_DEMO:String = "customerDemo";
		
		/* CRUD */
		public static const CREATE:String = "create";
		public static const DELETE:String = "delete";
		public static const UPDATE:String = "update";
		
		public var customer:Customer;
		
		public function CustomerEvent( type:String, customer:Customer = null )
		{
			super( type );
			this.customer = customer;
		}
	}
}