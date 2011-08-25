package org.osflash.net.httprouter.actions.async
{
	import org.osflash.net.http.HTTPStatusCode;
	import org.osflash.net.httprouter.actions.HTTPRouterAsyncAction;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.natives.NativeSignal;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class HTTPRouterFileAction extends HTTPRouterAsyncAction
	{
		
		/**
		 * @private
		 */
		private var _file : File;
		
		/**
		 * @private
		 */
		private var _fileStream : FileStream;
		
		/**
		 * @private
		 */
		private var _fileCharset : String;
				
		/**
		 * @private
		 */
		private var _nativeCompleteSignal : ISignal;
		
		/**
		 * @private
		 */
		private var _nativeIOErrorSignal : ISignal;
		 
		public function HTTPRouterFileAction(file : File, charset : String = null)
		{
			super();
			
			if(null == file) throw new ArgumentError('File can not be null');
			
			_file = file;
			_fileStream = new FileStream();
			_fileCharset = charset || File.systemCharset;
			
			_nativeCompleteSignal = new NativeSignal(_fileStream, Event.COMPLETE);
			_nativeCompleteSignal.add(handleCompleteSignal);
			
			_nativeIOErrorSignal = new NativeSignal(_fileStream, IOErrorEvent.IO_ERROR, IOErrorEvent);
			_nativeIOErrorSignal.add(handleIOErrorSignal);
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function execute() : void
		{
			if(file.exists)
			{
				try
				{
					_fileStream.openAsync(file, FileMode.READ);
				}
				catch(error : Error)
				{
					dispatchError(HTTPStatusCode.INTERNAL_SERVER_ERROR);
				}
			}
			else dispatchError(HTTPStatusCode.NOT_FOUND);
		}
		
		/**
		 * @private
		 */
		private function handleCompleteSignal(event : Event) : void
		{
			ioStream.position = 0;
			ioStream.writeUTF(_fileStream.readMultiByte(file.size, _fileCharset));
			
			_fileStream.close();
			
			dispatchComplete();
		}
		
		/**
		 * @private
		 */
		private function handleIOErrorSignal(event : IOErrorEvent) : void
		{
			dispatchError(HTTPStatusCode.INTERNAL_SERVER_ERROR);
		}
				
		public function get file() : File { return _file; }
		public function set file(value : File) : void 
		{ 
			if(null == file) throw new ArgumentError('File can not be null');
			
			_file = value; 
		} 
	}
}
