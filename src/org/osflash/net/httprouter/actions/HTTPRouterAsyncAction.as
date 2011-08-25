package org.osflash.net.httprouter.actions
{
	import org.osflash.net.http.HTTPStatusCode;
	import org.osflash.net.httprouter.types.HTTPRouterActionType;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRouterAsyncAction extends HTTPRouterAction implements IHTTPRouterAsyncAction
	{	
		
		/**
		 * @private
		 */
		private var _completeSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _errorSignal : ISignal;

		public function HTTPRouterAsyncAction()
		{
			super();
			
			_completeSignal = new Signal(IHTTPRouterAsyncAction, int);
			_errorSignal = new Signal(IHTTPRouterAsyncAction, int);
		}
				
		protected function dispatchComplete() : void
		{
			_completeSignal.dispatch(this, HTTPStatusCode.OK);
		}
		
		protected function dispatchError(statusCode : int) : void
		{
			statusCode = isNaN(statusCode) ? HTTPStatusCode.INTERNAL_SERVER_ERROR : statusCode;
			_errorSignal.dispatch(this, statusCode);
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
		public function get errorSignal() : ISignal { return _errorSignal; }

		/**
		 * @inheritDoc
		 */
		public function get completeSignal() : ISignal { return _completeSignal; }
	}
}
