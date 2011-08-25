package org.osflash.net.httpserver.parser.expressions
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class HTTPRequestExpressionType
	{
		
		public static const NAME : HTTPRequestExpressionType = new HTTPRequestExpressionType(0x01);
		
		public static const COLON : HTTPRequestExpressionType = new HTTPRequestExpressionType(0x02);
		
		public static const BREAK : HTTPRequestExpressionType = new HTTPRequestExpressionType(0x03);
		
		/**
		 * @private
		 */
		private var _type : int;

		public function HTTPRequestExpressionType(type : int)
		{
			_type = type;
		}

		public static function getType(type : int) : String
		{
			switch(type)
			{
				case NAME.type: return 'name';
				case COLON.type: return 'colon';
				case BREAK.type: return 'break';
				default:
					throw new ArgumentError('Given argument is Unknown');
			}
		}

		public function get type() : int { return _type; }
	}
}
