package org.osflash.net.httprouter.actions
{
	import org.osflash.net.httprouter.types.HTTPRouterActionType;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPRouterAction
	{
		
		function get content() : String;
		
		function get type() : HTTPRouterActionType;
	}
}
