package org.osflash.net.httprouter.actions
{
	import org.osflash.net.httprouter.types.HTTPRouterActionType;
	import org.osflash.net.httpserver.headers.request.HTTPRequestHeaders;
	import org.osflash.stream.IStreamInput;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPRouterAction
	{
		
		function execute() : void;
		
		function get stream() : IStreamInput;
				
		function get type() : HTTPRouterActionType;
		
		function get requestHeaders() : HTTPRequestHeaders;
		function set requestHeaders(value : HTTPRequestHeaders) : void;
	}
}
