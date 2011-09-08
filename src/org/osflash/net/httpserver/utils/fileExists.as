package org.osflash.net.httpserver.utils
{
	import flash.filesystem.File;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public function fileExists(url : String, folder : String = '') : Boolean
	{
		if(null == url) throw new ArgumentError('URL can not be null');
		
		// Cache the separator
		const separator : String = File.separator;
		// Replace the length with the separator
		const uri : String = url.replace('/', separator);
		const length : int = uri.length;
		
		// Work out if the url has a trailing separator
		var trailing : Boolean = false;
		
		var offset : int = length;
		var index : int = length;
		while(--index > -1)
		{
			if(uri.charAt(index) == separator)
			{
				trailing = true;
				offset = index;
			}
			else break;
		}
		
		// Get the trimmed separator
		const trimed : String = trailing ? uri.substr(0, offset) : uri;
		const path : String = folder == '' ? trimed : folder + separator + trimed;
		
		// Query all the known locations and si if it exits
		try
		{
			if(	new File(File.applicationDirectory.nativePath + separator + path).exists ||
				new File(File.applicationStorageDirectory.nativePath + separator + path).exists ||
				new File(File.desktopDirectory.nativePath + separator + path).exists ||
				new File(File.documentsDirectory.nativePath + separator + path).exists ||
				new File(File.userDirectory.nativePath + separator + path).exists
				)
				return true;
			else return false;
		}
		catch(error : Error)
		{
			return false;
		}
	}
}
