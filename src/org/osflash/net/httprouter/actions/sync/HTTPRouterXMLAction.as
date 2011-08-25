package org.osflash.net.httprouter.actions.sync
{
	import org.osflash.net.httprouter.actions.HTTPRouterAction;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRouterXMLAction extends HTTPRouterAction
	{
		
		/**
		 * @private
		 */
		private var _xml : XML;
		
		public function HTTPRouterXMLAction(xml : XML)
		{
			super();
			
			_xml = xml;
			
			ioStream.position = 0;
			ioStream.writeUTF(_xml.toXMLString());
		}
		
		public function get xml() : XML { return _xml; }
		public function set xml(value : XML) : void { _xml = value; }
	}
}
