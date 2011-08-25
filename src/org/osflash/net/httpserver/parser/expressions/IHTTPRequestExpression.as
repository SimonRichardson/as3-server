package org.osflash.net.httpserver.parser.expressions
{
	import org.osflash.stream.IStreamOutput;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IHTTPRequestExpression
	{
		
		function describe(stream : IStreamOutput) : void;
		
		function get type() : HTTPRequestExpressionType;
	}
}
