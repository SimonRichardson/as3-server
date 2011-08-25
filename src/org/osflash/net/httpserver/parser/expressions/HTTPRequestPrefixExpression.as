package org.osflash.net.httpserver.parser.expressions
{
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestTokenType;
	import org.osflash.stream.IStreamOutput;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestPrefixExpression extends HTTPRequestExpression
	{

		/**
		 * @private
		 */
		private var _operator : HTTPRequestTokenType;
		
		/**
		 * @private
		 */
		private var _right : IHTTPRequestExpression;

		public function HTTPRequestPrefixExpression(	operator : HTTPRequestTokenType, 
													right : IHTTPRequestExpression
													)
		{
			_operator = operator;
			_right = right;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function describe(stream : IStreamOutput) : void
		{
			stream.writeUTF("(");
			stream.writeUTF(_operator.name);
			
			_right.describe(stream);
			
			stream.writeUTF(")");
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get type() : HTTPRequestExpressionType { return null; }
	}
}
