package org.osflash.net.httpserver
{
	import org.osflash.net.httprouter.HTTPRouter;
	import org.osflash.net.httprouter.IHTTPRouter;
	import org.osflash.net.httpserver.backend.IHTTPServerOutput;
	import org.osflash.net.httpserver.backend.http.HTTPServerSocket;
	import org.osflash.net.httpserver.errors.HTTPServerError;
	import org.osflash.net.httpserver.parser.HTTPRequestLexer;
	import org.osflash.net.httpserver.parser.HTTPRequestParser;

	import flash.net.Socket;
	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPServer
	{
		
		/**
		 * @private
		 */
		private var _router : IHTTPRouter;
		
		/**
		 * @private
		 */
		private var _output : IHTTPServerOutput;
		
		public function HTTPServer(router : IHTTPRouter = null, output : IHTTPServerOutput = null)
		{
			this.router = router;
			this.output = output;
		}
		
		public function connect() : void
		{
			if(null == _output) throw new HTTPServerError('Output can not be null');
			else if(_output.listening) throw new HTTPServerError('Can not connect more than once');
			else _output.connect();
		}
		
		public function close() : void
		{
			if(null == _output) throw new HTTPServerError('Output can not be null');
			else if(_output.listening) _output.close();
		}
			
		/**
		 * @private
		 */
		private function handleCloseSignal(output : IHTTPServerOutput) : void
		{
			
		}
		
		/**
		 * @private
		 */
		private function handleConnectSignal(output : IHTTPServerOutput) : void
		{
			
		}
		
		/**
		 * @private
		 */
		private function handleDataSignal(output : IHTTPServerOutput, socket : Socket) : void
		{
			const byteArray : ByteArray = new ByteArray();
			byteArray.position = 0;
			
			socket.readBytes(byteArray);
			
			const source : String = byteArray.toString();
			const lexer : HTTPRequestLexer = new HTTPRequestLexer(source);
			const parser : HTTPRequestParser = new HTTPRequestParser(lexer);
			
			output.close();
		}
		
		/**
		 * @private
		 */
		private function handleErrorSignal(output : IHTTPServerOutput, error : Error) : void
		{
			
		}
		
		public function get port() : int { return _output.port; }
		
		public function get address() : String { return _output.address; } 
		
		public function get router() : IHTTPRouter { return _router; }
		public function set router(value : IHTTPRouter) : void 
		{ 
			_router = value || new HTTPRouter();
		}
		
		public function get output() : IHTTPServerOutput { return _output; }
		public function set output(value : IHTTPServerOutput) : void
		{
			if(null != _output)
			{
				_output.closeSignal.remove(handleCloseSignal);
				_output.connectSignal.remove(handleConnectSignal);
				_output.dataSignal.remove(handleDataSignal);
				_output.errorSignal.remove(handleErrorSignal);
				
				_output = null;
			}
			
			_output = value || new HTTPServerSocket();
			_output.closeSignal.add(handleCloseSignal);
			_output.connectSignal.add(handleConnectSignal);
			_output.dataSignal.add(handleDataSignal);
			_output.errorSignal.add(handleErrorSignal);
		}
	}
}
