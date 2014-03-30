package com.app.models.presentations
{
	import com.app.events.CustomerEvent;
	import com.app.models.CustomerModel;
	import com.app.views.forms.CustomerForm;
	
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	
	import mx.managers.PopUpManager;
	
	import org.swizframework.core.ISwiz;
	import org.swizframework.core.ISwizAware;
	
	import spark.components.TitleWindow;

	public class CustomerViewPresentationModel implements ISwizAware
	{
		
		[Dispatcher] public var dispatcher:IEventDispatcher;		// Dispatcher
		
		[Inject][Bindable] public var customerModel:CustomerModel;	// Model
		
		private var _swiz : ISwiz;
		
		public function CustomerViewPresentationModel(){/*For avoid warning*/}
				
		// *********************************************************
		// Getter/Setter 
		// *********************************************************
		
		/**
		 * Implement ISwizAware so that we get the Swiz instance injected. We'll use this
		 * to register additional PopUps.
		 */ 
		public function set swiz( swiz : ISwiz ) : void
		{
			_swiz = swiz;
		}
		
		// *********************************************************
		// Public Methods 
		// *********************************************************
		
		public function createDemoCustomer():void
		{
			dispatcher.dispatchEvent(new CustomerEvent( CustomerEvent.CUSTOMERS_DEMO));
		}
		
		// *********************************************************
		// EventHandlers 
		// *********************************************************
				
		public function showCustomerForm(obj:DisplayObject, state:String):void
		{			
			// Create a modal CustomerForm window.
			var customerFormWindow:CustomerForm = PopUpManager.createPopUp(obj, CustomerForm, true) as CustomerForm;
			_swiz.registerWindow( customerFormWindow );
			customerFormWindow.currentState = state;
			PopUpManager.centerPopUp(customerFormWindow);
		}
	}
}