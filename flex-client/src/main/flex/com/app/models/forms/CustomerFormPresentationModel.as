package com.app.models.forms
{
	import app.dto.Customer;
	
	import com.app.events.CustomerEvent;
	import com.app.models.CustomerModel;
	
	import flash.events.IEventDispatcher;
	
	import mx.managers.PopUpManager;
	
	import spark.components.TitleWindow;
	
	public class CustomerFormPresentationModel
	{
		[Dispatcher] public var dispatcher:IEventDispatcher;		// Dispatcher
		
		[Inject][Bindable] public var customerModel:CustomerModel;	// Model
		
		public function CustomerFormPresentationModel(){/*For avoid warning*/}
		
		// *********************************************************
		// Public Methods 
		// *********************************************************
				
		public function createCustomer():void
		{
			dispatcher.dispatchEvent(new CustomerEvent( CustomerEvent.CREATE, customerModel.customer));
		}
		
		public function closeWindow(window:TitleWindow):void
		{
			PopUpManager.removePopUp(window);
		}

	}
}