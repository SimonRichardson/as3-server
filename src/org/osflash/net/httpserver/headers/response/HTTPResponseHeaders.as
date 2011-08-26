package org.osflash.net.httpserver.headers.response
{
	import org.osflash.net.httpserver.errors.HTTPServerError;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPResponseHeaders
	{
		
		/**
		 * @private
		 */
		private var _headers : Vector.<HTTPResponseHeader>;
		
		public function HTTPResponseHeaders()
		{
			_headers = new Vector.<HTTPResponseHeader>();
		}
		
		public function add(header : HTTPResponseHeader) : HTTPResponseHeader
		{
			if(null == header) throw new ArgumentError('Header can not be null');
			
			if(_headers.indexOf(header) == -1) _headers.push(header);
			else throw new HTTPServerError('Header already exists');
			
			return header;
		}
		
		public function remove(header : HTTPResponseHeader) : HTTPResponseHeader
		{
			if(null == header) throw new ArgumentError('Header can not be null');
			
			const index : int = _headers.indexOf(header);
			if(index >= 0) _headers.splice(index, 1);
			else throw new HTTPServerError('No such Header');
			
			return header;
		}
		
		public function getAt(index : int) : HTTPResponseHeader
		{
			if(index < 0 || index >= length) throw new RangeError();
			
			return _headers[index];		
		}
		
		public function getByName(name : String) : HTTPResponseHeader
		{
			var index : int = length;
			while(--index > -1)
			{
				const header : HTTPResponseHeader = _headers[index]; 
				if(header.name == name) return header;
			}
			return null;
		}
		
		public function getIndex(name : String) : int
		{
			var index : int = length;
			while(--index > -1)
			{
				const header : HTTPResponseHeader = _headers[index]; 
				if(header.name == name) return index;
			}
			return -1;
		}
		
		public function contains(name : String) : Boolean
		{
			var index : int = length;
			while(--index > -1)
			{
				const header : HTTPResponseHeader = _headers[index]; 
				if(header.name == name) return true;
			}
			return false;
		}
		
		public function get length() : int { return _headers.length; }
	}
}
