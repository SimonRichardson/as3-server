package org.osflash.net.httpserver.parser.parselets
{
	import org.osflash.net.httpserver.parser.IHTTPRequestParser;
	import org.osflash.net.httpserver.parser.expressions.HTTPRequestColonExpression;
	import org.osflash.net.httpserver.parser.expressions.IHTTPRequestExpression;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestToken;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestColonParselet implements IHTTPRequestPrefixParselet
	{

		/**
		 * @inheritDoc
		 */
		public function parse(	parser : IHTTPRequestParser, 
								token : HTTPRequestToken
								) : IHTTPRequestExpression
		{
			return new HTTPRequestColonExpression();
		}
	}
}
