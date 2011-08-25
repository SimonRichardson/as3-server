package org.osflash.net.httpserver.backend
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPServerOutput
	{
		
		function connect() : void;
		
		function close() : void;
		
		function get address() : String;
		
		function get port() : int;
		
		function get listening() : Boolean;
		
		function get supported() : Boolean;
	}
}
