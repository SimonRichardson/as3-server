package org.osflash.net.httpserver.headers.request
{
	import org.osflash.net.httpserver.types.HTTPRequestHeaderType;
	import org.osflash.net.httpserver.types.HTTPRequestMethodType;
	import org.osflash.net.httpserver.types.HTTPRequestProtocolType;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class HTTPRequestMethodHeader implements IHTTPRequestHeader
	{
		
		/**
		 * @private
		 */
		private var _method : HTTPRequestMethodType;
		
		/**
		 * @private
		 */
		private var _url : String;
		
		/**
		 * @private
		 */
		private var _protocol : HTTPRequestProtocolType;
		
		public function HTTPRequestMethodHeader(	method : HTTPRequestMethodType, 
													url : String, 
													protocol : HTTPRequestProtocolType = null
													)
		{
			if(null == method) throw new ArgumentError('Method can not be null');
			if(null == url) throw new ArgumentError('URL can not be null');
			
			_method = method;
			_url = url;
			_protocol = protocol || HTTPRequestProtocolType.HTTP_1_1;
		}

		public function get name() : String { return method.name; }
		
		public function get method() : HTTPRequestMethodType { return _method; }
		
		public function get url() : String { return _url; }
		
		public function get protocol() : HTTPRequestProtocolType { return _protocol; }
		
		public function get type() : HTTPRequestHeaderType { return HTTPRequestHeaderType.METHOD; }
	}
}
