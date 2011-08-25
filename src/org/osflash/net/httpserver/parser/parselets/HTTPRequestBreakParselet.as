package org.osflash.net.httpserver.parser.parselets
{
	import org.osflash.net.httpserver.parser.HTTPRequestPrecedence;
	import org.osflash.net.httpserver.parser.IHTTPRequestParser;
	import org.osflash.net.httpserver.parser.errors.HTTPRequestError;
	import org.osflash.net.httpserver.parser.expressions.HTTPRequestBreakExpression;
	import org.osflash.net.httpserver.parser.expressions.HTTPRequestNameExpression;
	import org.osflash.net.httpserver.parser.expressions.IHTTPRequestExpression;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestToken;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestTokenType;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestBreakParselet implements IHTTPRequestInfixParselet
	{
		
		/**
		 * @inheritDoc
		 */
		public function parse(	parser : IHTTPRequestParser, 
								expression : IHTTPRequestExpression, 
								token : HTTPRequestToken
								) : IHTTPRequestExpression
		{		
			const name : HTTPRequestNameExpression = expression as HTTPRequestNameExpression;
			if(null == name)
				HTTPRequestError.throwError(HTTPRequestError.INVALID_LEFT_SIDE_EQUALITY);
			
			const params : Vector.<IHTTPRequestExpression> = new Vector.<IHTTPRequestExpression>();
			if(parser.match(HTTPRequestTokenType.COLON))
			{
				do
				{
					params.push(parser.parseExpression());
				}
				while(parser.match(HTTPRequestTokenType.COLON));
			}
			
			parser.consumeToken(HTTPRequestTokenType.BREAK);
			
			return new HTTPRequestBreakExpression(name, params);
		}
		
		/**
		 * @inheritDoc
		 */
		public function get precedence() : int { return HTTPRequestPrecedence.EQUALITY; }
	}
}
