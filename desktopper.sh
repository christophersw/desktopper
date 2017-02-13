#!/bin/bash
#Usage: desktopper [FOLDER] [SUBREDDIT] [DAYSTOKEEP] [REDDITUSERNAME]

FOLDER=$1
SUBREDDIT=$2
DAYSTOKEEP=$3
REDDITUSERNAME=$4


if [ -z "$1" ]
  then
    FOLDER=$(readlink -f $HOME/backgrounds)
fi

if [ -z "$2" ]
  then
    SUBREDDIT='earthporn'
fi

if [ -z "$3" ]
  then
    DAYSTOKEEP=20
fi

if [ -z "$3" ]
  then
    DAYSTOKEEP=20
fi

if [ -z "$4" ]
  then
    REDDITUSERNAME='christophersw'
fi

cd "$FOLDER"

#Clean up folder, removing old files.
echo "nuking files $DAYSTOKEEP days old and older."
find "$FOLDER" -mtime +"$DAYSTOKEEP" -type f -delete

# Download the front page images of a /r/
OLD=$(ls -1 | wc -l)
curl -A "Desktop downloader by /u/$REDDITUSERNAME" https://www.reddit.com/r/$SUBREDDIT.json | jshon -e data -e children -a -e data -e url -u | grep '.\(jpe\|jp\|pn\)g$' | xargs -n 1 curl -O
NEW=$(ls -1 | wc -l)

echo "Reddit Desktopper Downloaded $(( NEW - OLD)) new images from Reddit /r/$SUBREDDIT."

# Pick ranadom image, set it as background.
PICTURE=$(find ./ -iregex '.*\.\(tga\|jpg\|gif\|png\|jpeg\)$' | shuf -n 1)
PICTURELINK=$(readlink -f "$PICTURE")
OUTPUT=$(gsettings set org.gnome.desktop.background picture-uri file://$PICTURELINK 2>&1) 

echo "Desktop background set to $PICTURE"
notify-send "Reddit Desktopper" "Downloaded $(( NEW - OLD)) new images from Reddit /r/$SUBREDDIT and desktop updated to $PICTURE" -t 10000