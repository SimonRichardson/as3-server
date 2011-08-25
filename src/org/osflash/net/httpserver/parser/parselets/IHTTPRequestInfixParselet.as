package org.osflash.net.httpserver.parser.parselets
{
	import org.osflash.net.httpserver.parser.IHTTPRequestParser;
	import org.osflash.net.httpserver.parser.expressions.IHTTPRequestExpression;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestToken;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPRequestInfixParselet
	{
		
		function parse(	parser : IHTTPRequestParser, 
						expression : IHTTPRequestExpression, 
						token : HTTPRequestToken
						) : IHTTPRequestExpression;

		function get precedence() : int;
	}
}
