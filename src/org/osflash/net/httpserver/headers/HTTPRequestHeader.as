package org.osflash.net.httpserver.headers
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestHeader
	{

		/**
		 * @private
		 */
		private var _name : String;
		
		/**
		 * @private
		 */
		private var _value : String;
		
		public function HTTPRequestHeader(name : String, value : String)
		{
			if(null == name) throw new ArgumentError('Name can not be null');
			if(name.length == 0) throw new ArgumentError('Name can not be empty');
			
			_name = name;
			_value = value;
		}

		public function get name() : String { return _name; }
		
		public function get value() : String { return _value; }
	}
}
