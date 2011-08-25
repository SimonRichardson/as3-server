package org.osflash.net.httpserver.parser.expressions
{
	import org.osflash.stream.IStreamOutput;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestColonExpression extends HTTPRequestExpression
	{
		
		public function HTTPRequestColonExpression()
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override public function describe(stream : IStreamOutput) : void
		{
			stream.writeUTF(name);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get type() : HTTPRequestExpressionType
		{
			return HTTPRequestExpressionType.COLON;
		}

		public function get name() : String { return ':'; }
	}
}
