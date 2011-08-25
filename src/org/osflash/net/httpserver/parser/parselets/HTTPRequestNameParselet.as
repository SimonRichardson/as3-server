package org.osflash.net.httpserver.parser.parselets
{
	import org.osflash.net.httpserver.parser.IHTTPRequestParser;
	import org.osflash.net.httpserver.parser.expressions.HTTPRequestNameExpression;
	import org.osflash.net.httpserver.parser.expressions.IHTTPRequestExpression;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestToken;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestNameParselet implements IHTTPRequestPrefixParselet
	{

		/**
		 * @inheritDoc
		 */
		public function parse(	parser : IHTTPRequestParser, 
								token : HTTPRequestToken
								) : IHTTPRequestExpression
		{
			return new HTTPRequestNameExpression(token.buffer);
		}
	}
}
