package org.osflash.net.httpserver.headers.request
{
	import org.osflash.net.httpserver.types.HTTPRequestHeaderType;
	import org.osflash.net.httpserver.errors.HTTPServerError;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestHeaders
	{

		/**
		 * @private
		 */
		private var _headers : Vector.<IHTTPRequestHeader>;
		
		public function HTTPRequestHeaders()
		{
			_headers = new Vector.<IHTTPRequestHeader>();
		}
				
		public function add(header : IHTTPRequestHeader) : IHTTPRequestHeader
		{
			if(null == header) throw new ArgumentError('Header can not be null');
			
			if(_headers.indexOf(header) == -1) _headers.push(header);
			else throw new HTTPServerError('Header already exists');
			
			return header;
		}
		
		public function getAt(index : int) : IHTTPRequestHeader
		{
			if(index < 0 || index >= length) throw new RangeError();
			
			return _headers[index];		
		}
		
		public function getByName(name : String) : IHTTPRequestHeader
		{
			var index : int = length;
			while(--index > -1)
			{
				const header : IHTTPRequestHeader = _headers[index]; 
				if(header.name == name) return header;
			}
			return null;
		}
		
		public function getByType(type : HTTPRequestHeaderType) : IHTTPRequestHeader
		{
			var index : int = length;
			while(--index > -1)
			{
				const header : IHTTPRequestHeader = _headers[index]; 
				if(header.type == type) return header;
			}
			return null;
		}
		
		public function getIndex(name : String) : int
		{
			var index : int = length;
			while(--index > -1)
			{
				const header : IHTTPRequestHeader = _headers[index]; 
				if(header.name == name) return index;
			}
			return -1;
		}
		
		public function contains(name : String) : Boolean
		{
			var index : int = length;
			while(--index > -1)
			{
				const header : IHTTPRequestHeader = _headers[index]; 
				if(header.name == name) return true;
			}
			return false;
		}
		
		public function get length() : int { return _headers.length; }
	}
}
