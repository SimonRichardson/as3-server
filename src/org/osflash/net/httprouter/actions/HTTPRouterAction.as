package org.osflash.net.httprouter.actions
{
	import org.osflash.net.httprouter.types.HTTPRouterActionType;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRouterAction implements IHTTPRouterAction
	{

		public function HTTPRouterAction()
		{
			
		}

		/**
		 * @inheritDoc
		 */
		public function get content() : String { throw new Error('Abstract Error'); }

		/**
		 * @inheritDoc
		 */
		public function get type() : HTTPRouterActionType { return HTTPRouterActionType.SYNC; }
	}
}
