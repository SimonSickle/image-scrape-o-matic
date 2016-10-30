--    This is an apple script to import all photos you just scraped into an album
--    Copyright (C) 2016  Simon Sickle <simon@simonsickle.com>
--
--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU Affero General Public License as
--    published by the Free Software Foundation, either version 3 of the
--    License, or (at your option) any later version.
--
--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU Affero General Public License for more details.
--
--    You should have received a copy of the GNU Affero General Public License
--    along with this program.  If not, see <http://www.gnu.org/licenses/>.

on run
	set folderList to (choose folder without multiple selections allowed)
	display dialog "What album to import to" default answer "Backgrounds"
	set albumName to text returned of the result
	
	tell application "Photos"
		delay 2
		activate
		delay 2
		set theEvents to get every album
		repeat with aEvent in theEvents
			log (get name of aEvent)
		end repeat
	end tell
	
	import(folderList, albumName)
end run

on import(aFolder, albumName)
	set imageList to getImageList(aFolder)
	if imageList is {} then return
	
	tell application "Photos"
		import imageList into (get album named albumName) skip check duplicates no
	end tell
end import

on getImageList(aFolder)
	tell application "Finder" to set theFiles to files of the aFolder as alias list
	theFiles
end getImageList
