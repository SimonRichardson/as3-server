package org.osflash.net.httpserver.utils
{
	import flash.filesystem.File;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public function getFileFromURL(url : String, folder : String = '') : File
	{
		if(null == url) throw new ArgumentError('URL can not be null');
		
		// Cache the separator
		const separator : String = File.separator;
		const path : String = getURLAsPath(url, folder);
		
		// Query all the known locations and si if it exits
		try
		{
			var file : File = new File(File.applicationDirectory.nativePath + separator + path);
			if(file.exists) return file;
			else
			{
				file = new File(File.applicationStorageDirectory.nativePath + separator + path);
				if(file.exists) return file;
				else
				{
					file = new File(File.desktopDirectory.nativePath + separator + path);
					if(file.exists) return file;
					else
					{
						file = new File(File.documentsDirectory.nativePath + separator + path);
						if(file.exists) return file;
						else
						{
							file = new File(File.userDirectory.nativePath + separator + path);
							if(file.exists) return file;
							else return null;
						}
					}
				}
			}
		}
		catch(error : Error)
		{
			return null;
		}
	}
}
