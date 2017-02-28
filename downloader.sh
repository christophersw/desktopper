#!/bin/bash
#Usage: desktopper [FOLDER] [SUBREDDIT] [DAYSTOKEEP] [REDDITUSERNAME]

# This is needed to allow this to run from cron
PID=$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

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
notify-send "Reddit Desktopper" "Downloaded $(( NEW - OLD)) new images from Reddit /r/$SUBREDDIT" -t 10000