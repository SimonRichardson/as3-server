package org.osflash.net.httprouter.utils
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getRegExpSource(pattern : RegExp) : String
	{
		return pattern.source.replace(/\\/, '');
	}
}
