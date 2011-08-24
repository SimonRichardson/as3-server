package org.osflash.net.httprouter
{
	import org.osflash.net.http.errors.HTTPError;
	import org.osflash.net.httprouter.services.IHTTPRouterService;
	import org.osflash.net.httprouter.utils.getRegExpSource;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRouter implements IHTTPRouter
	{
		
		/**
		 * @private
		 */
		private var _services : Vector.<IHTTPRouterService>;
		
		public function HTTPRouter()
		{
			_services = new Vector.<IHTTPRouterService>();
		}

		/**
		 * @inheritDoc
		 */
		public function add(service : IHTTPRouterService) : IHTTPRouterService
		{
			if(null == service) throw new ArgumentError('Service can not be null');
			
			if(_services.indexOf(service) == -1) _services.push(service);
			else throw new HTTPError('Service already exists');
			
			return service;
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove(service : IHTTPRouterService) : IHTTPRouterService
		{
			if(null == service) throw new ArgumentError('Service can not be null');
			
			const index : int = _services.indexOf(service);
			if(index >= 0) _services.splice(index, 1);
			else throw new HTTPError('Service does not exist');
			
			return service;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeByPattern(pattern : RegExp) : IHTTPRouterService
		{
			const source : String = getRegExpSource(pattern);
			
			var index : int = length;
			while(--index > -1)
			{
				const service : IHTTPRouterService = _services[index];
				if(service.normalizedPattern == source) return remove(service);
			}
			
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getAt(index : int) : IHTTPRouterService
		{
			if(index < 0 || index >= length) throw new RangeError();
			
			return _services[index];
		}

		/**
		 * @inheritDoc
		 */
		public function contains(pattern : RegExp) : Boolean
		{
			const source : String = getRegExpSource(pattern);
			
			var index : int = length;
			while(--index > -1)
			{
				const service : IHTTPRouterService = _services[index];
				if(service.normalizedPattern == source) return true;
			}
			
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get length() : int { return _services.length; }
	}
}
