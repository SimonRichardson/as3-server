package org.osflash.net.httpserver.parser.expressions
{
	import org.osflash.stream.IStreamOutput;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRequestBreakExpression extends HTTPRequestExpression
	{
		
		
		/**
		 * @private
		 */
		private var _left : IHTTPRequestExpression;
		
		/**
		 * @private
		 */
		private var _right : Vector.<IHTTPRequestExpression>;
		
		public function HTTPRequestBreakExpression(	left : IHTTPRequestExpression, 
													right : Vector.<IHTTPRequestExpression> = null
													)
		{
			if(null == left) throw new ArgumentError('Given left can not be null');
			
			_left = left;
			_right = right;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function describe(stream : IStreamOutput) : void
		{
			_left.describe(stream);
			
			if(null != right)
			{
				const total : int = _right.length;
				for(var i : int = 0; i < total; i++)
				{				
					_right[i].describe(stream);
					stream.writeUTF(":");
				}
			}			
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get type() : HTTPRequestExpressionType
		{
			return HTTPRequestExpressionType.BREAK;
		}

		public function get left() : IHTTPRequestExpression
		{
			return _left;
		}

		public function get right() : Vector.<IHTTPRequestExpression>
		{
			return _right;
		}
	}
}
