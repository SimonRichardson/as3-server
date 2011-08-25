package org.osflash.net.httpserver.parser.parselets
{
	import org.osflash.net.httpserver.parser.IHTTPRequestParser;
	import org.osflash.net.httpserver.parser.expressions.HTTPRequestPrefixExpression;
	import org.osflash.net.httpserver.parser.expressions.IHTTPRequestExpression;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestToken;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestTokenType;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestPrefixOperatorParselet implements IHTTPRequestPrefixParselet
	{
		
		/**
		 * @private
		 */
		private var _operator : HTTPRequestTokenType;
		
		/**
		 * @private
		 */
		private var _precedence : int;

		public function HTTPRequestPrefixOperatorParselet(operator : HTTPRequestTokenType, precedence : int)
		{
			_operator = operator;
			_precedence = precedence;
		}
		
		/**
		 * @inheritDoc
		 */
		public function parse(parser : IHTTPRequestParser, token : HTTPRequestToken) : IHTTPRequestExpression
		{
			const right : IHTTPRequestExpression = parser.parseExpressionBy(_precedence);
			return new HTTPRequestPrefixExpression(_operator, right);
		}

		public function get precedence() : int { return _precedence; }
	}
}
