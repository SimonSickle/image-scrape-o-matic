#!/bin/bash
# Copyright 2016 Simon Sickle <simon@simonsickle.com>, under AGPLv3.0
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

osascript toPhotos.applescript
