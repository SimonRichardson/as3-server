package org.osflash.net.httpserver.parser.tokens
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestToken
	{
		/**
		 * @private
		 */
		private var _type : HTTPRequestTokenType;		
		
		/**
		 * @private
		 */		
		private var _buffer : String;
		
		/**
		 * Create a new HTTPRequestToken
		 */
		public function HTTPRequestToken(type : HTTPRequestTokenType, buffer : String)
		{
			_type = type;
			_buffer = buffer;
		}
		
		/**
		 * Get the current type of the HTTPRequestTokenType.
		 * 
		 * @return HTTPRequestTokenType
		 */
		public function get type() : HTTPRequestTokenType { return _type; }
		
		/**
		 * Get the current buffer of the HTTPRequestToken
		 * 
		 * @return String
		 */
		public function get buffer() : String { return _buffer; }
		
		public function toString() : String 
		{
			return '[HTTPRequestToken (type:\'' + type.name + '\', buffer:\'' + buffer + '\']';
		}
	}
}
