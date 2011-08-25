package org.osflash.net.httpserver.parser
{
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestToken;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPRequestTokenIterator
	{
		
		function get hasNext() : Boolean;
		
		function get next() : HTTPRequestToken;
	}
}
