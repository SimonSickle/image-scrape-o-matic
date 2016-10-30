#!/bin/bash
#    This is a image scraper for all website pages
#    Copyright (C) 2016  Simon Sickle <simon@simonsickle.com>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


# $1 is the site name w/ subdirectory (eg simonsickle.com/blog/post1/) to scrape

COUNTER=0
urls=$(curl $1 | grep .jpg)
baseURL=$(echo $1 | cut -d'/' -f3)

# Clear images out
rm -rf images/
mkdir images/

# Download all the images
for i in $urls; do
   file=$(basename $i)
   echo "Downloading $file..."
   curl --referer "$baseURL" "$i" -o "images/$file"
   let COUNTER=COUNTER+1
done

echo "Downloaded $COUNTER files"

# Import script if macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    osascript toPhotos.applescript
fi
