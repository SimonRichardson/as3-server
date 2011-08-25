package org.osflash.net.httpserver.parser.expressions
{
	import org.osflash.stream.IStreamOutput;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public final class HTTPRequestNameExpression extends HTTPRequestExpression
	{
		
		/**
		 * @private
		 */
		private var _name : String;
		
		public function HTTPRequestNameExpression(name : String)
		{
			if(null == name) throw new ArgumentError('Given name can not be null');
			
			_name = name;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function describe(stream : IStreamOutput) : void
		{
			stream.writeUTF(_name);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get type() : HTTPRequestExpressionType
		{
			return HTTPRequestExpressionType.NAME;
		}

		public function get name() : String { return _name; }
	}
}
