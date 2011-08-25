package org.osflash.net.httpserver.parser
{
	import org.osflash.net.httpserver.parser.expressions.IHTTPRequestExpression;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestToken;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestTokenType;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPRequestParser
	{
		
		function parseExpression() : IHTTPRequestExpression;
		
		function parseExpressionBy(precedence : int) : IHTTPRequestExpression;
		
		function match(expected : HTTPRequestTokenType) : Boolean;
		
		function consume() : HTTPRequestToken;
		
		function consumeToken(expected : HTTPRequestTokenType) : HTTPRequestToken;
	}
}
