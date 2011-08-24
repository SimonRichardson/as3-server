package org.osflash.net.httprouter.actions
{
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
			_xml = xml;
		}
		
		public function get xml() : XML { return _xml; }
		public function set xml(value : XML) : void { _xml = value; }
		
		override public function get content() : String { return _xml.toXMLString(); }
	}
}
