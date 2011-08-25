package org.osflash.net.httprouter.actions.async
{
	import org.osflash.net.http.HTTPStatusCode;
	import org.osflash.net.httprouter.actions.HTTPRouterAsyncAction;
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
			if(null == handler)
			{
				const result : String = handler();
				
				if(null == result) dispatchError(HTTPStatusCode.INTERNAL_SERVER_ERROR);
				else 
				{
					ioStream.position = 0;
					ioStream.writeUTF(result);
					
					dispatchComplete();
				}
			}
			else dispatchError(HTTPStatusCode.INTERNAL_SERVER_ERROR);
		}
		
		public function get handler() : Function { return _handler; }
		public function set handler(value : Function) : void 
		{ 
			if(null == handler) throw new ArgumentError('Handler can not be null');
			_handler = value; 
		} 
	}
}
