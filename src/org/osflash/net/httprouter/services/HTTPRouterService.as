package org.osflash.net.httprouter.services
{
	import org.osflash.net.httprouter.actions.IHTTPRouterAction;
	import org.osflash.net.httprouter.errors.HTTPRouterError;
	import org.osflash.net.httprouter.utils.getRegExpSource;
	import org.osflash.net.httpserver.headers.HTTPRequestHeaders;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRouterService implements IHTTPRouterService
	{
		
		/**
		 * @private
		 */
		private var _action : IHTTPRouterAction;
		
		/**
		 * @private
		 */
		private var _pattern : RegExp;
		
		/**
		 * @private
		 */
		private var _normalizedPattern : String;
		
		public function HTTPRouterService(pattern : RegExp, action : IHTTPRouterAction = null)
		{
			if(null == pattern) throw new ArgumentError('Pattern can not be null');
			
			_pattern = pattern;
			_normalizedPattern = getRegExpSource(pattern);
			
			_action = action;
		}
		
		/**
		 * @inheritDoc
		 */
		public function execute(headers : HTTPRequestHeaders) : void
		{
			if(null != action)
			{
				action.requestHeaders = headers;
				action.execute();
			}
			else throw new HTTPRouterError('Action not found');
		}
			
		/**
		 * @inheritDoc
		 */	
		public function get action() : IHTTPRouterAction { return _action; }
		public function set action(value : IHTTPRouterAction) : void { _action = value; }

		/**
		 * @inheritDoc
		 */
		public function get pattern() : RegExp { return pattern; }

		/**
		 * @inheritDoc
		 */
		public function get normalizedPattern() : String { return _normalizedPattern; }
	}
}
