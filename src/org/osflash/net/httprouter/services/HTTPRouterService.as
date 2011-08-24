package org.osflash.net.httprouter.services
{
	import org.osflash.net.httprouter.actions.IHTTPRouterAction;
	import org.osflash.net.httprouter.utils.getRegExpSource;
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
		
		public function get action() : IHTTPRouterAction { return _action; }
		public function set action(value : IHTTPRouterAction) : void { _action = value; }

		public function get pattern() : RegExp { return pattern; }

		public function get normalizedPattern() : String { return _normalizedPattern; }
	}
}
