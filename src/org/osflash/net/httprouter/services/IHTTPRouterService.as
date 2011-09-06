package org.osflash.net.httprouter.services
{
	import org.osflash.net.httprouter.actions.IHTTPRouterAction;
	import org.osflash.net.httprouter.types.HTTPRouterActionType;
	import org.osflash.net.httpserver.headers.request.HTTPRequestHeaders;
	import org.osflash.signals.ISignal;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPRouterService
	{
		
		function execute(headers : HTTPRequestHeaders) : void;
		
		function get content() : String;
		
		function get action() : IHTTPRouterAction;
		function set action(value : IHTTPRouterAction) : void;
		
		function get pattern() : RegExp;
		
		function get normalizedPattern() : String;
		
		function get actionType() : HTTPRouterActionType;
		
		function get actionCompleteSignal() : ISignal;
	}
}
