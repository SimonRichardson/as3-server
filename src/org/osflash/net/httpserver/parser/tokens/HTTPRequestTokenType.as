package org.osflash.net.httpserver.parser.tokens
{
	import org.osflash.net.httpserver.parser.errors.HTTPRequestError;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestTokenType
	{
		
		public static const EOF : HTTPRequestTokenType = new HTTPRequestTokenType('EOF');

		public static const STRING : HTTPRequestTokenType = new HTTPRequestTokenType('STRING');
		
		public static const BREAK : HTTPRequestTokenType = new HTTPRequestTokenType('BREAK');
		
		public static const COLON : HTTPRequestTokenType = new HTTPRequestTokenType('COLON');
		
		/**
		 * @private
		 */
		private var _type : String;
		
		/**
		 * @private
		 */
		private var _name : String;
			
		/**
		 * Constructor for the HTTPRequestTokenType, which is used as an Enum 
		 * for HTTPRequestTokenType.
		 */
		public function HTTPRequestTokenType(type : String)
		{
			_type = type;
		}
		
		public static function typeAsString(type : HTTPRequestTokenType) : String
		{
			switch(type)
			{
				case EOF:
				case STRING:
				case BREAK:
				case COLON:
					return type.type;
				default: 
					throw new HTTPRequestError('Unknown HTTPRequestTokenType'); 
			}
		}
		
		public function get name() : String 
		{ 
			if(null == _name) _name = typeAsString(this);
			return _name; 
		}
		
		public function get type() : String { return _type; }
	}
}
