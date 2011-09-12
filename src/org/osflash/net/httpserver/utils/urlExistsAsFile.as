package org.osflash.net.httpserver.utils
{
	import flash.filesystem.File;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public function urlExistsAsFile(url : String, folder : String = '') : Boolean
	{
		if(null == url) throw new ArgumentError('URL can not be null');
		
		// Cache the separator
		const separator : String = File.separator;
		const path : String = getURLAsPath(url, folder);
		
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
