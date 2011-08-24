package org.osflash.net.httprouter.actions
{
	import org.osflash.signals.Signal;
	import org.osflash.signals.ISignal;
	import org.osflash.net.httprouter.types.HTTPRouterActionType;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRouterAsyncAction extends HTTPRouterAction implements IHTTPRouterAsyncAction
	{	
		
		/**
		 * @private
		 */
		private var _resultSignal : ISignal;

		public function HTTPRouterAsyncAction()
		{
			super();
			
			_resultSignal = new Signal(String);
		}
		
		/**
		 * @inheritDoc
		 */
		public function execute() : void
		{
			throw new Error('Abstract Method Error');
		}

		/**
		 * @inheritDoc
		 */
		override public function get type() : HTTPRouterActionType
		{
			return HTTPRouterActionType.ASYNC;
		}

		/**
		 * @inheritDoc
		 */
		public function get resultSignal() : ISignal { return _resultSignal; }
	}
}
