package org.osflash.net.httprouter.actions
{
	import org.osflash.signals.ISignal;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPRouterAsyncAction extends IHTTPRouterAction
	{
		
		function get completeSignal() : ISignal;
		
		function get errorSignal() : ISignal;
	}
}
