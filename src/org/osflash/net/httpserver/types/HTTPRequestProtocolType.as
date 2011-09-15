package org.osflash.net.httpserver.types
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class HTTPRequestProtocolType
	{
		
		public static const HTTP_1_0 : HTTPRequestProtocolType = 
															new HTTPRequestProtocolType('HTTP/1.0');
		
		public static const HTTP_1_1 : HTTPRequestProtocolType = 
															new HTTPRequestProtocolType('HTTP/1.1');
		
		/**
		 * @private
		 */
		private var _type : String;
		
		/**
		 * @private
		 */
		private var _name : String;

		public function HTTPRequestProtocolType(type : String)
		{
			if(null == type) throw new ArgumentError('Type can not be null');
			
			_type = type;
		}
		
		public static function create(name : String) : HTTPRequestProtocolType
		{
			switch(name.toUpperCase())
			{
				case HTTP_1_0.name: return HTTP_1_0;
				case HTTP_1_1.name: return HTTP_1_1;
				default:
					throw new ArgumentError('Name is not a valid HTTPRequestProtocolType');
			}
			return null;
		}
		
		public static function typeAsString(type : HTTPRequestProtocolType) : String
		{
			switch(type)
			{
				case HTTP_1_0:
				case HTTP_1_1:
					return type.type;
				default:
					throw new ArgumentError('Type is not a valid HTTPRequestProtocolType');
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
