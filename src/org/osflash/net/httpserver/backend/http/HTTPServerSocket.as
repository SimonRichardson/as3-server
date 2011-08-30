package org.osflash.net.httpserver.backend.http
{
	import org.osflash.net.httpserver.backend.IHTTPServerOutput;
	import org.osflash.net.httpserver.errors.HTTPServerError;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osflash.signals.natives.NativeSignal;

	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.net.Socket;
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
		private var _socket : Socket;
		
		/**
		 * @private
		 */
		private var _address : String;
		
		/**
		 * @private
		 */
		private var _port : int;
		
		/**
		 * @private
		 */
		private var _dataSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _errorSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _closeSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _connectSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _nativeCloseSignal : NativeSignal;
		
		/**
		 * @private
		 */
		private var _nativeConnectSignal : NativeSignal;
		
		/**
		 * @private
		 */
		private var _nativeIOErrorSignal : NativeSignal;
		
		/**
		 * @private
		 */
		private var _nativeSecurityErrorSignal : NativeSignal;
		
		/**
		 * @private
		 */
		private var _nativeSocketDataSignal : NativeSignal; 
		
		public function HTTPServerSocket(address : String = '0.0.0.0', port : int = 8888)
		{
			_address = address;
			_port = port;
			
			_nativeCloseSignal = new NativeSignal(null, Event.CLOSE);
			_nativeConnectSignal = new NativeSignal(	null, 
														ServerSocketConnectEvent.CONNECT,
														ServerSocketConnectEvent
														);
			_nativeIOErrorSignal = new NativeSignal(null, IOErrorEvent.IO_ERROR, IOErrorEvent);
			_nativeSecurityErrorSignal = new NativeSignal(	null, 
															SecurityErrorEvent.SECURITY_ERROR, 
															SecurityErrorEvent
															);
			_nativeSocketDataSignal = new NativeSignal(	null, 
														ProgressEvent.SOCKET_DATA, 
														ProgressEvent
														);
			
			if(!supported) 
				throw new HTTPServerError('HTTPServerSocket is not supported on this platform');
		}
		
		/**
		 * @inheritDoc
		 */
		public function connect() : void
		{
			if(null != _serverSocket && _serverSocket.bound) close();
			
			_serverSocket = new ServerSocket();
			
			_nativeCloseSignal.target = _serverSocket;
			_nativeCloseSignal.addOnce(handleCloseSignal);
			
			_nativeConnectSignal.target = _serverSocket;
			_nativeConnectSignal.addOnce(handleConnectSignal);
			
			try
			{
				_serverSocket.bind(port, address);
				_serverSocket.listen();
			}
			catch(error : Error)
			{
				errorSignal.dispatch(this, error);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function close() : void
		{
			try
			{
				_socket.close();
				_serverSocket.close();
			}
			catch(error : Error)
			{
				errorSignal.dispatch(this, error);
			}
			finally 
			{
				_socket = null;
				_serverSocket = null;
			}
		}
				
		/**
		 * @private
		 */
		private function handleCloseSignal(event : Event) : void
		{
			_nativeIOErrorSignal.removeAll();
			_nativeSecurityErrorSignal.removeAll();
			_nativeSocketDataSignal.removeAll();
			
			closeSignal.dispatch(this);
		}
		
		/**
		 * @private
		 */
		private function handleConnectSignal(event : ServerSocketConnectEvent) : void
		{
			_socket = event.socket;
			
			if(null == _socket) errorSignal.dispatch(this, new HTTPServerError('Socket is null'));
			else
			{
				_nativeIOErrorSignal.target = _socket;
				_nativeIOErrorSignal.addOnce(handleErrorSignal);
				
				_nativeSecurityErrorSignal.target = _socket;
				_nativeSecurityErrorSignal.addOnce(handleErrorSignal);
				
				_nativeSocketDataSignal.target = _socket;
				_nativeSocketDataSignal.add(handleSocketDataSignal);
				
				connectSignal.dispatch(this);
			}
		}
		
		/**
		 * @private
		 */
		private function handleErrorSignal(event : ErrorEvent) : void
		{
			errorSignal.dispatch(this, new Error(event.type, event.errorID));
			
			close();
		}
		
		/**
		 * @private
		 */
		private function handleSocketDataSignal(event : ProgressEvent) : void
		{
			const socket : Socket = event.target as Socket;
			
			if(null != socket) dataSignal.dispatch(this, socket);
			else errorSignal.dispatch(this, new Error('Socket was null'));
		}
		
		/**
		 * @inheritDoc
		 */
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
		
		/**
		 * @inheritDoc
		 */
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
		
		/**
		 * @inheritDoc
		 */
		public function get socket() : Socket { return _socket; }
		
		/**
		 * @inheritDoc
		 */
		public function get listening() : Boolean 
		{ 
			return null == _serverSocket ? false : _serverSocket.listening;
		}

		/**
		 * @inheritDoc
		 */
		public function get supported() : Boolean {	return ServerSocket.isSupported; }
		
		/**
		 * @inheritDoc
		 */
		public function get dataSignal() : ISignal 
		{ 
			if(null == _dataSignal) _dataSignal = new Signal(IHTTPServerOutput, Socket);
			return _dataSignal; 
		}
		
		/**
		 * @inheritDoc
		 */
		public function get errorSignal() : ISignal 
		{ 
			if(null == _errorSignal) _errorSignal = new Signal(IHTTPServerOutput, Error);
			return _errorSignal; 
		}
		
		/**
		 * @inheritDoc
		 */
		public function get closeSignal() : ISignal 
		{
			if(null == _closeSignal) _closeSignal = new Signal(IHTTPServerOutput);
			return _closeSignal;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get connectSignal() : ISignal 
		{ 
			if(null == _connectSignal) _connectSignal = new Signal(IHTTPServerOutput);
			return _connectSignal;
		}
	}
}
