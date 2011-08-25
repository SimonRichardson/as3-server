package org.osflash.net.httpserver.parser.expressions
{
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestTokenType;
	import org.osflash.stream.IStreamOutput;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestPostfixExpression extends HTTPRequestExpression
	{
		
		/**
		 * @private
		 */
		private var _left : IHTTPRequestExpression;
		
		/**
		 * @private
		 */
		private var _operator : HTTPRequestTokenType;

		public function HTTPRequestPostfixExpression(	left : IHTTPRequestExpression, 
														operator : HTTPRequestTokenType
														)
		{
			_left = left;
			_operator = operator;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function describe(stream : IStreamOutput) : void
		{
			stream.writeUTF("(");
			
			_left.describe(stream);
			
			stream.writeUTF(_operator.name);
			stream.writeUTF(")");
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get type() : HTTPRequestExpressionType { return null; }
	}
}
