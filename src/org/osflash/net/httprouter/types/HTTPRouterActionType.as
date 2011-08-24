package org.osflash.net.httprouter.types
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRouterActionType
	{
		
		public static const SYNC : HTTPRouterActionType = new HTTPRouterActionType('sync');

		public static const ASYNC : HTTPRouterActionType = new HTTPRouterActionType('async');
		
		/**
		 * @private
		 */
		private var _type : String;

		/**
		 * @private
		 */
		private var _name : String;

		public function HTTPRouterActionType(type : String)
		{
			if(null == type) throw new ArgumentError('Type can not be null');
			if(type.length == 0) throw new ArgumentError('Type can not be empty');
			
			_type = type;
		}
		
		public static function typeAsString(type : HTTPRouterActionType) : String
		{
			switch(type)
			{
				case SYNC:
				case ASYNC:
					return type.type;
				default: 
					throw new ArgumentError('Unknown HTTPRouterActionType found');
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
