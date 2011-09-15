package org.osflash.net.httpserver.headers.request
{
	import org.osflash.net.httpserver.types.HTTPRequestMethodType;
	import org.osflash.net.httpserver.types.HTTPRequestProtocolType;

	import flash.utils.ByteArray;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class HTTPRequestHeadersParser
	{

		/**
		 * @private
		 */
		private var _byteArray : ByteArray;
		
		/**
		 * @private
		 */
		private var _buffer : String;
		
		public function HTTPRequestHeadersParser(byteArray : ByteArray)
		{
			if(null == byteArray) throw new ArgumentError('ByteArray can not be null');
			
			_byteArray = byteArray;
		}
		
		public function parse() : HTTPRequestHeaders
		{
			_buffer = '';
			byteArray.position = 0;
			
			const headers : HTTPRequestHeaders = new HTTPRequestHeaders();
			
			const total : int = byteArray.length;
			while(byteArray.position < total)
			{
				const byte : int = byteArray.readByte();
				if(byte >= 32 && byte <= 126)
				{
					_buffer += String.fromCharCode(byte);
				}
				else if(byte == 13)
				{
					if(_buffer.length > 0) 
					{
						const colonIndex : int = _buffer.indexOf(":");
						if(colonIndex > 0)
						{
							const name : String = _buffer.substr(0, colonIndex);
							const value : String = _buffer.substr(colonIndex + 1);
							
							headers.add(new HTTPRequestHeader(name, value));
						}
						else
						{
							const spaceIndex0 : int = _buffer.indexOf(' ');
							const spaceIndex1 : int = _buffer.lastIndexOf(' ');
							
							const methodString : String = _buffer.substr(0, spaceIndex0);
							const urlString : String = _buffer.substr(	spaceIndex0 + 1, 
																(spaceIndex1 - 1) - spaceIndex0
																);
							const protocolString : String = _buffer.substr(spaceIndex1 + 1);
							
							const method : HTTPRequestMethodType = 
														HTTPRequestMethodType.create(methodString);
							const url : String = urlString;
							const protocol : HTTPRequestProtocolType = 
													HTTPRequestProtocolType.create(protocolString);
							
							headers.add(new HTTPRequestMethodHeader(method, url, protocol));
						}
					}
					
					_buffer = '';
				}
			}
			
			return headers;
		}
		
		public function get byteArray() : ByteArray { return _byteArray; }
	}
}
