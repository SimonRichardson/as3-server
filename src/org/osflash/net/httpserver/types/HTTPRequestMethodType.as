package org.osflash.net.httpserver.types
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class HTTPRequestMethodType
	{
		
		public static const GET : HTTPRequestMethodType = new HTTPRequestMethodType('GET');
		
		public static const POST : HTTPRequestMethodType = new HTTPRequestMethodType('POST');
		
		/**
		 * @private
		 */
		private var _type : String;
		
		/**
		 * @private
		 */
		private var _name : String;

		public function HTTPRequestMethodType(type : String)
		{
			if(null == type) throw new ArgumentError('Type can not be null');
			
			_type = type;
		}
		
		public static function create(name : String) : HTTPRequestMethodType
		{
			switch(name.toUpperCase())
			{
				case GET.name: return GET;
				case POST.name: return POST;
				default:
					throw new ArgumentError('Name is not a valid HTTPRequestMethodType');
			}
			return null;
		}
		
		public static function typeAsString(type : HTTPRequestMethodType) : String
		{
			switch(type)
			{
				case GET:
				case POST:
					return type.type;
				default:
					throw new ArgumentError('Type is not a valid HTTPRequestMethodType');
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
