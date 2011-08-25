package org.osflash.net.httpserver.parser.parselets
{
	import org.osflash.net.httpserver.parser.IHTTPRequestParser;
	import org.osflash.net.httpserver.parser.expressions.HTTPRequestPostfixExpression;
	import org.osflash.net.httpserver.parser.expressions.IHTTPRequestExpression;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestToken;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestTokenType;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestPostfixOperatorParselet implements IHTTPRequestInfixParselet
	{

		/**
		 * @private
		 */
		private var _operator : HTTPRequestTokenType;
		
		/**
		 * @private
		 */
		private var _precedence : int;

		public function HTTPRequestPostfixOperatorParselet(	operator : HTTPRequestTokenType, 
														precedence : int
														)
		{
			_operator = operator;
			_precedence = precedence;
		}
		
		/**
		 * @inheritDoc
		 */
		public function parse(	parser : IHTTPRequestParser, 
								expression : IHTTPRequestExpression, 
								token : HTTPRequestToken
								) : IHTTPRequestExpression
		{
			return new HTTPRequestPostfixExpression(expression, _operator);
		}

		/**
		 * @inheritDoc
		 */
		public function get precedence() : int { return _precedence; }
	}
}
