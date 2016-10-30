-- Copyright 2016 Simon Sickle <simon@simonsickle.com>, under AGPLv3.0
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
