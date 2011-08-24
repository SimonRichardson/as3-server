package org.osflash.net.httprouter.actions
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRouterCallbackAction extends HTTPRouterAsyncAction
	{
		
		/**
		 * @private
		 */
		private var _handler : Function;
		
		public function HTTPRouterCallbackAction(handler : Function)
		{
			if(null == handler) throw new ArgumentError('Handler can not be null');
			
			_handler = handler;
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function execute() : void
		{
			resultSignal.dispatch(handler());
		}
		
		public function get handler() : Function { return _handler; }
		public function set handler(value : Function) : void { _handler = value; } 
	}
}
