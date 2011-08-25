package org.osflash.net.httpserver.backend.http
{
	import org.osflash.net.httpserver.errors.HTTPServerError;
	import flash.net.ServerSocket;
	import org.osflash.net.httpserver.backend.IHTTPServerOutput;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPServerSocket implements IHTTPServerOutput
	{
		
		/**
		 * @private
		 */
		private var _serverSocket : ServerSocket;
		
		/**
		 * @private
		 */
		private var _address : String;
		
		/**
		 * @private
		 */
		private var _port : int;
		
				
		public function HTTPServerSocket(address : String = '0.0.0.0', port : int = 8888)
		{
			if(supported)
			{
				_serverSocket = new ServerSocket();
				
				_address = address;
				_port = port;
			}
			else throw new HTTPServerError('HTTPServerSocket is not supported on this platform');
		}
		
		public function connect() : void
		{
			_serverSocket.bind(port, address);
			_serverSocket.listen();
		}
		
		public function close() : void
		{
			try
			{
				_serverSocket.close();
			}
			catch(error : Error)
			{
				
			}
		}
		
		public function get address() : String { return _address; }
		public function set address(value : String) : void
		{ 
			if(address != value)
			{
				if(listening) close();
				
				_address = address;
				
				connect(); 
			}
		}
		
		public function get port() : int { return _port; }
		public function set port(value : int) : void
		{ 
			if(port != value)
			{
				if(listening) close();
				
				_port = port;
				
				connect(); 
			}
		}
		
		public function get listening() : Boolean { return _serverSocket.listening; }

		public function get supported() : Boolean {	return ServerSocket.isSupported; }		
	}
}
