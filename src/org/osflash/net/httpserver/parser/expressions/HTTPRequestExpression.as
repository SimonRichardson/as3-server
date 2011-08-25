package org.osflash.net.httpserver.parser.expressions
{
	import org.osflash.net.httpserver.parser.errors.HTTPRequestError;
	import org.osflash.stream.IStreamOutput;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestExpression implements IHTTPRequestExpression
	{

		public function HTTPRequestExpression()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function describe(stream : IStreamOutput) : void
		{
			HTTPRequestError.throwError(HTTPRequestError.ABSTRACT_METHOD);
			
			stream;
		}

		/**
		 * @inheritDoc
		 */
		public function get type() : HTTPRequestExpressionType
		{
			HTTPRequestError.throwError(HTTPRequestError.ABSTRACT_METHOD);

			return null;
		}
	}
}
