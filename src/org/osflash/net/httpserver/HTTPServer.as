package org.osflash.net.httpserver
{
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import org.osflash.net.http.HTTPStatusCode;
	import org.osflash.net.httprouter.HTTPRouter;
	import org.osflash.net.httprouter.IHTTPRouter;
	import org.osflash.net.httprouter.actions.IHTTPRouterAsyncAction;
	import org.osflash.net.httprouter.services.IHTTPRouterService;
	import org.osflash.net.httprouter.types.HTTPRouterActionType;
	import org.osflash.net.httpserver.backend.IHTTPServerOutput;
	import org.osflash.net.httpserver.backend.http.HTTPServerSocket;
	import org.osflash.net.httpserver.errors.HTTPServerError;
	import org.osflash.net.httpserver.headers.request.HTTPRequestHeaders;
	import org.osflash.net.httpserver.headers.request.HTTPRequestHeadersParser;
	import org.osflash.net.httpserver.headers.request.HTTPRequestMethodHeader;
	import org.osflash.net.httpserver.headers.request.IHTTPRequestHeader;
	import org.osflash.net.httpserver.types.HTTPRequestHeaderType;
	import org.osflash.net.httpserver.types.HTTPRequestMethodType;
	import org.osflash.net.httpserver.utils.urlExistsAsFile;
	import org.osflash.net.httpserver.utils.getFileFromURL;

	import flash.filesystem.File;
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
			
			const parser : HTTPRequestHeadersParser = new HTTPRequestHeadersParser(byteArray);
			const headers : HTTPRequestHeaders = parser.parse();
			
			const methodType : HTTPRequestHeaderType = HTTPRequestHeaderType.METHOD;
			const method : IHTTPRequestHeader = headers.getByType(methodType);
			
			var sync : Boolean = true;
			
			if(null != method)
			{
				// -- get request
				if(method.type == HTTPRequestMethodType.GET)
				{
					const methodGet : HTTPRequestMethodHeader = HTTPRequestMethodHeader(method);
					const pattern : RegExp = new RegExp(methodGet.url);
					if(router.contains(pattern))
					{
						 const service : IHTTPRouterService = router.getByPattern(pattern);
						 const actionType : HTTPRouterActionType = service.actionType;
						 if(actionType == HTTPRouterActionType.SYNC)
						 {
						 	service.execute(headers);
							
							socket.writeUTF(service.content);
						 }
						 else if(actionType == HTTPRouterActionType.ASYNC)
						 {
							sync = false;
							
							service.actionCompleteSignal.addOnce(handleActionCompleteSignal);
							service.execute(headers);						
						 }
						 else throw new HTTPServerError('Invalid serivce type');
					}
					else if(urlExistsAsFile(methodGet.url))
					{
						// TODO : see if the content is the form of a static content i.e. a File.
						const file : File = getFileFromURL(methodGet.url);
						const fileStream : FileStream = new FileStream();
						fileStream.openAsync(file, FileMode.READ);
					}
					// TODO : show a 404 error
					// else throw new Error('No valid content found');
				}
				else throw new Error('Method not supported');
			}
			else 
			{
				// TODO : show a 500 error
				// socket.writeUTF(value);
			}
			
			if(sync)
			{
				socket.flush();
			
				output.close();
			}
		}
		
		/**
		 * @private
		 */
		private function handleErrorSignal(output : IHTTPServerOutput, error : Error) : void
		{
			if(null != output.socket)
			{
				// TODO : work out what type of error it is and server a reasonable error page.
			}
			else throw error;
		}
		
		/**
		 * @private 
		 */
		private function handleActionCompleteSignal(	action : IHTTPRouterAsyncAction, 
														status : int,
														output : IHTTPServerOutput,
														socket : Socket,
														service : IHTTPRouterService
														) : void
		{
			if(null == socket || null == output) throw new HTTPServerError('Internal server error');
			else
			{
				if(status != HTTPStatusCode.OK) 
				{
					// TODO : show a status error
					// socket.writeUTF(value);
				}
				else
				{
					socket.writeUTF(service.content);
					socket.flush();
					
					output.close();
				}
			}
			
			action;
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
