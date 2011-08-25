package org.osflash.net.httprouter.actions
{
	import org.osflash.net.httpserver.headers.HTTPRequestHeaders;
	import org.osflash.net.httprouter.types.HTTPRouterActionType;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPRouterAction
	{
		
		function execute() : void;
		
		function get content() : String;
		
		function get type() : HTTPRouterActionType;
		
		function get requestHeaders() : HTTPRequestHeaders;
		function set requestHeaders(value : HTTPRequestHeaders) : void;
	}
}
