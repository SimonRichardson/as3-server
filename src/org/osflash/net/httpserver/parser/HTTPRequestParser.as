package org.osflash.net.httpserver.parser
{
	import org.osflash.net.httpserver.parser.parselets.HTTPRequestBreakParselet;
	import org.osflash.net.httpserver.parser.errors.HTTPRequestError;
	import org.osflash.net.httpserver.parser.expressions.IHTTPRequestExpression;
	import org.osflash.net.httpserver.parser.parselets.HTTPRequestColonParselet;
	import org.osflash.net.httpserver.parser.parselets.HTTPRequestNameParselet;
	import org.osflash.net.httpserver.parser.parselets.HTTPRequestPostfixOperatorParselet;
	import org.osflash.net.httpserver.parser.parselets.HTTPRequestPrefixOperatorParselet;
	import org.osflash.net.httpserver.parser.parselets.IHTTPRequestInfixParselet;
	import org.osflash.net.httpserver.parser.parselets.IHTTPRequestPrefixParselet;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestToken;
	import org.osflash.net.httpserver.parser.tokens.HTTPRequestTokenType;

	import flash.utils.Dictionary;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestParser implements IHTTPRequestParser
	{
		
		/**
		 * @private
		 */
		private var _tokens : IHTTPRequestTokenIterator;
		
		/**
		 * @private
		 */
		private var _stream : Vector.<HTTPRequestToken>;
		
		/**
		 * @private
		 */
		private var _prefix : Dictionary;
		
		/**
		 * @private
		 */
		private var _infix : Dictionary;
		
		/**
		 * Constructor for the HTTPRequestParser, which requires a iterator to iterate through.
		 * 
		 * @param iterator IHTTPRequestTokenIterator
		 */
		public function HTTPRequestParser(iterator : IHTTPRequestTokenIterator)
		{
			_tokens = iterator;
			
			_stream = new Vector.<HTTPRequestToken>();
			
			_prefix = new Dictionary();
			_infix = new Dictionary();
			
			registerPrefix(HTTPRequestTokenType.STRING, new HTTPRequestNameParselet());
			registerPrefix(HTTPRequestTokenType.COLON, new HTTPRequestColonParselet());
			
			registerInfix(HTTPRequestTokenType.BREAK, new HTTPRequestBreakParselet());
		}
		
		/**
		 * Register a token according to a prefix parselet. 
		 */
		public function registerPrefix(	token : HTTPRequestTokenType, 
										parselet : IHTTPRequestPrefixParselet
										) : void
		{
			if(null == token) throw new ArgumentError('Given token can not be null');
			if(null == parselet) throw new ArgumentError('Given parselet can not be null');
			
			if(null != _prefix[token]) 
				HTTPRequestError.throwError(HTTPRequestError.TOKEN_ASSIGNED_ALREADY);
			
			_prefix[token] = parselet;	
		}
		
		/**
		 * Register a token according to a infix parselet. 
		 */
		public function registerInfix(	token : HTTPRequestTokenType, 
										parselet : IHTTPRequestInfixParselet
										) : void
		{
			if(null == token) throw new ArgumentError('Given token can not be null');
			if(null == parselet) throw new ArgumentError('Given parselet can not be null');
			
			if(null != _infix[token]) 
				HTTPRequestError.throwError(HTTPRequestError.TOKEN_ASSIGNED_ALREADY);
			
			_infix[token] = parselet;	
		}
				
		/**
		 * Parse an expression
		 * 
		 * @return IHTTPRequestExpression
		 */
		public function parseExpression() : IHTTPRequestExpression
		{
			return parseExpressionBy(0);
		}
		
		/**
		 * Parse an expression by the precedence of a parslet.
		 * 
		 * @return IHTTPRequestExpression
		 */
		public function parseExpressionBy(precedence : int) : IHTTPRequestExpression
		{
			var token : HTTPRequestToken = consume();
			if(null == token) HTTPRequestError.throwError(HTTPRequestError.TOKEN_IS_NULL);
			
			const prefix : IHTTPRequestPrefixParselet = _prefix[token.type];
			if(null == prefix) HTTPRequestError.throwError(HTTPRequestError.PARSER_ERROR);
			
			var expression : IHTTPRequestExpression = prefix.parse(this, token);
			while(precedence < nextTokenPrecedence)
			{
				token = consume();
				
				const infix : IHTTPRequestInfixParselet = _infix[token.type];
				if(null == infix) HTTPRequestError.throwError(HTTPRequestError.PARSER_ERROR);
				
				expression = infix.parse(this, expression, token); 
			}
						
			return expression;
		}
				
		/**
		 * @inheritDoc
		 */
		public function match(expected : HTTPRequestTokenType) : Boolean
		{
			const token : HTTPRequestToken = advance(0);
			if(token.type != expected) return false;
			
			consume();
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function consume() : HTTPRequestToken
		{
			advance(0);
			
			if(_stream.length == 0) HTTPRequestError.throwError(HTTPRequestError.BUFFER_UNDERFLOW);
			return _stream.shift();
		}
		
		/**
		 * @inheritDoc
		 */
		public function consumeToken(expected : HTTPRequestTokenType) : HTTPRequestToken
		{
			const token : HTTPRequestToken = advance(0);
			if(token.type != expected) 
				HTTPRequestError.throwError(HTTPRequestError.UNEXPECTED_TOKEN);
			
			return consume();
		}
		
		/**
		 * @inheritDoc
		 */
		public function advance(distance : int) : HTTPRequestToken
		{
			if(distance < 0) throw new RangeError('Given value can not be less than 0');
			
			while(distance >= _stream.length)
			{
				_stream.push(_tokens.next);
			}
			
			if(distance >= _stream.length) throw new RangeError('Given value can not be greater ' + 
													' than stream length (distance=' + distance + 
													', length=' + _stream.length + ')');
			return _stream[distance];
		}
		
		
		/**
		 * Registers a prefix unary operator parselet for the given token and
		 * precedence.
		 * 
		 * @private
		 */
		protected function prefix(token : HTTPRequestTokenType, precedence : int) : void
		{
			registerPrefix(token, new HTTPRequestPrefixOperatorParselet(token, precedence));
		}
		
		/**
		 * Registers a postfix unary operator parselet for the given token and
		 * precedence.
		 * 
		 * @private
		 */
		protected function postfix(token : HTTPRequestTokenType, precedence : int) : void
		{
			registerInfix(token, new HTTPRequestPostfixOperatorParselet(token, precedence));
		}
		
		/**
		 * @inheritDoc
		 */
		protected function get nextTokenPrecedence() : int
		{
			const token : HTTPRequestToken = advance(0);
			if(null == token) HTTPRequestError.throwError(HTTPRequestError.TOKEN_IS_NULL);
			
			const tokenType : HTTPRequestTokenType = token.type;
			const parselet : IHTTPRequestInfixParselet = _infix[tokenType];
			return (null != parselet) ? parselet.precedence : 0;
		}
	}
}
