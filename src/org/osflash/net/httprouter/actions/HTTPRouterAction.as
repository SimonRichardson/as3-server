package org.osflash.net.httprouter.actions
{
	import org.osflash.net.httpserver.headers.HTTPRequestHeaders;
	import org.osflash.net.httprouter.types.HTTPRouterActionType;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRouterAction implements IHTTPRouterAction
	{
		
		/**
		 * @private
		 */
		private var _requestHeaders : HTTPRequestHeaders;
		
		public function HTTPRouterAction()
		{
			
		}
		
		/**
		 * @inheritDoc
		 */
		public function execute() : void
		{
			throw new Error('Abstract Method Error');
		}

		/**
		 * @inheritDoc
		 */
		public function get content() : String { throw new Error('Abstract Error'); }

		/**
		 * @inheritDoc
		 */
		public function get type() : HTTPRouterActionType { return HTTPRouterActionType.SYNC; }

		/**
		 * @inheritDoc
		 */
		public function get requestHeaders() : HTTPRequestHeaders { return _requestHeaders; }
		public function set requestHeaders(value : HTTPRequestHeaders) : void 
		{ 
			_requestHeaders = value; 
		}
	}
}
