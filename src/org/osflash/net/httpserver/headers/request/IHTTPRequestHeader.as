package org.osflash.net.httpserver.headers.request
{
	import org.osflash.net.httpserver.types.HTTPRequestHeaderType;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface IHTTPRequestHeader
	{
		
		function get name() : String;
		
		function get type() : HTTPRequestHeaderType;
	}
}
