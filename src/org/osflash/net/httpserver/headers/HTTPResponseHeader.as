package org.osflash.net.httpserver.headers
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPResponseHeader
	{
		
		/**
		 * @private
		 */
		private var _name : String;
		
		/**
		 * @private
		 */
		private var _value : String;
		
		public function HTTPResponseHeader(name : String, value : String)
		{
			if(null == name) throw new ArgumentError('Name can not be null');
			if(name.length == 0) throw new ArgumentError('Name can not be empty');
			
			_name = name;
			_value = value;
		}

		public function get name() : String { return _name; }
		
		public function get value() : String { return _value; }
		public function set value(arg : String) : void { _value = arg; }
	}
}
