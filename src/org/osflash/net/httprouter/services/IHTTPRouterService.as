package org.osflash.net.httprouter.services
{
	import org.osflash.net.httprouter.actions.IHTTPRouterAction;
	import org.osflash.net.httpserver.headers.request.HTTPRequestHeaders;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPRouterService
	{
		
		function execute(headers : HTTPRequestHeaders) : void;
		
		function get action() : IHTTPRouterAction;
		
		function get pattern() : RegExp;
		
		function get normalizedPattern() : String;
	}
}
