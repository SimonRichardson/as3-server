package org.osflash.net.httpserver.types
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class HTTPRequestHeaderType
	{
		
		public static const METHOD : HTTPRequestHeaderType = new HTTPRequestHeaderType(0x01);
		
		public static const VARIABLES : HTTPRequestHeaderType = new HTTPRequestHeaderType(0x02);
		
		/**
		 * @private
		 */
		private var _type : int;

		public function HTTPRequestHeaderType(type : int)
		{
			if(isNaN(type)) throw new ArgumentError('Type can not be NaN');
			
			_type = type;
		}
		
		public static function typeAsString(type : HTTPRequestHeaderType) : int
		{
			switch(type)
			{
				case METHOD:
				case VARIABLES:
					return type.type;
				default:
					throw new ArgumentError('Type is not a valid HTTPRequestHeaderType');
			}
		}
		
		public function get type() : int { return _type; }
	}
}
