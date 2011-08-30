package org.osflash.net.httpserver.backend
{
	import org.osflash.signals.ISignal;

	import flash.net.Socket;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPServerOutput
	{
		
		function connect() : void;
		
		function close() : void;
		
		function get address() : String;
		
		function get port() : int;
		
		function get socket() : Socket;
		
		function get listening() : Boolean;
		
		function get supported() : Boolean;
		
		function get dataSignal() : ISignal;
		
		function get errorSignal() : ISignal;
		
		function get closeSignal() : ISignal;
		
		function get connectSignal() : ISignal;
	}
}
