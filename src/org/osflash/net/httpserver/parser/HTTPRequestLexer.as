package org.osflash.net.httpserver.parser
{
	import org.osflash.net.httpserver.parser.errors.HTTPRequestError;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestToken;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestTokenType;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestLexer implements IHTTPRequestTokenIterator
	{
		
		/**
		 * @private
		 */
		private var _index : int;
		
		/**
		 * @private
		 */
		private var _source : String;
				
		/**
		 * Constructor for creating a HTTPRequestLexer which will be used to analyse the source of a
		 * string and create tokens from the resulting code.
		 * 
		 * @param source String containing a valid syntax to be analysed.
		 */
		public function HTTPRequestLexer(source : String)
		{
			if(null == source || source.length < 1) throw new ArgumentError('Given value can not ' + 
																						'be null');
			_index = 0;
			_source = source;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get hasNext() : Boolean
		{
			return _index < _source.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get next() : HTTPRequestToken
		{
			while(hasNext)
			{	
				var char : String = _source.charAt(_index++);
				var charCode : int = char.charCodeAt(0);
				
				// Try and grab the number or integer
				var buffer : String = '';
								
				if(	(charCode >= 33 && charCode < 58) ||  
					(charCode > 58 && charCode <= 126)
					)
				{
					// we're a name here
					if(buffer != '') HTTPRequestError.throwError(HTTPRequestError.BUFFER_OVERFLOW);
					
					buffer += char;
					
					while(hasNext)
					{
						char = _source.charAt(_index++);
						charCode = char.charCodeAt(0);
						
						if(charCode == 58 || charCode == 10 || charCode == 13)
						{
							// we've gone to far, roll back 1.
							_index--;
							
							break;
						}
						
						buffer += char;
					}
					
					return new HTTPRequestToken(HTTPRequestTokenType.STRING, buffer);
				}
				else if(charCode == 58)
				{
					return new HTTPRequestToken(HTTPRequestTokenType.COLON, buffer);
				}
				else if(charCode == 10 || charCode == 13)
				{
					return new HTTPRequestToken(HTTPRequestTokenType.BREAK, buffer);
				}
				else if(	charCode <= 9 || 
							charCode == 11 || 
							charCode == 12 || 
							(charCode > 13 && charCode <= 32)
							)
				{
					// This is effectively white space
					continue;
				}
				else
				{
					HTTPRequestError.throwError(HTTPRequestError.UNEXPECTED_CHAR);
				}
			}
			
			return new HTTPRequestToken(HTTPRequestTokenType.EOF, "");
		}
	}
}
