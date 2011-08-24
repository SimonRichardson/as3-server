package org.osflash.net.httprouter.actions
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.natives.NativeSignal;

	import flash.events.Event;
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
		
		public function HTTPRouterFileAction(file : File, charset : String = null)
		{
			if(null == file) throw new ArgumentError('File can not be null');
			
			_file = file;
			_fileStream = new FileStream();
			_fileCharset = charset || File.systemCharset;
			
			_nativeCompleteSignal = new NativeSignal(_fileStream, Event.COMPLETE);
			_nativeCompleteSignal.add(handleCompleteSignal);
		}
		
		/**
		 * @inheritDoc
		 */	
		override public function execute() : void
		{
			_fileStream.openAsync(file, FileMode.READ);
		}
		
		/**
		 * @private
		 */
		private function handleCompleteSignal(event : Event) : void
		{
			const content : String = _fileStream.readMultiByte(file.size, _fileCharset);
			
			_fileStream.close();
			
			resultSignal.dispatch(content);
		}
		
		public function get file() : File { return _file; }
		public function set file(value : File) : void { _file = value; } 
	}
}
