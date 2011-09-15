package org.osflash.net.httprouter
{
	import org.osflash.net.httprouter.services.IHTTPRouterService;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPRouter
	{
		
		function add(service : IHTTPRouterService) : IHTTPRouterService
		
		function remove(service : IHTTPRouterService) : IHTTPRouterService;
		
		function removeByPattern(pattern : RegExp) : IHTTPRouterService;
		
		function contains(pattern : RegExp) : Boolean;
		
		function getAt(index : int) : IHTTPRouterService;
		
		function getByPattern(pattern : RegExp) : IHTTPRouterService;
		
		function get length() : int;
	}
}
