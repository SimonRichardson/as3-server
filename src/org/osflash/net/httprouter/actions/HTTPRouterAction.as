package org.osflash.net.httprouter.actions
{
	import org.osflash.stream.types.bytearray.StreamByteArray;
	import org.osflash.stream.IStreamInput;
	import org.osflash.net.httprouter.types.HTTPRouterActionType;
	import org.osflash.net.httpserver.headers.HTTPRequestHeaders;
	import org.osflash.stream.IStreamIO;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRouterAction implements IHTTPRouterAction
	{
		
		/**
		 * @private
		 */
		private var _requestHeaders : HTTPRequestHeaders;
		
		/**
		 * @private
		 */
		private var _stream : IStreamIO;
		
		public function HTTPRouterAction()
		{
			_stream = new StreamByteArray();
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
		public final function get stream() : IStreamInput { return _stream; }

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
		
		protected function get ioStream() : IStreamIO { return _stream; }
	}
}
