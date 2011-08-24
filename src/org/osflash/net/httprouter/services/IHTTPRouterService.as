package org.osflash.net.httprouter.services
{
	import org.osflash.net.httprouter.actions.IHTTPRouterAction;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPRouterService
	{
		
		function get action() : IHTTPRouterAction;
		
		function get pattern() : RegExp;
		
		function get normalizedPattern() : String;
	}
}
