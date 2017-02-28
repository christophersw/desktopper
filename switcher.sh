
#!/bin/bash
#Usage: desktopper [FOLDER]

# This is needed to allow this to run from cron
PID=$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

FOLDER=$1

if [ -z "$1" ]
  then
    FOLDER=$(readlink -f $HOME/backgrounds)
fi

cd "$FOLDER"

# Pick ranadom image, set it as background.
PICTURE=$(find ./ -iregex '.*\.\(tga\|jpg\|gif\|png\|jpeg\)$' | shuf -n 1)
PICTURELINK=$(readlink -f "$PICTURE")
OUTPUT=$(gsettings set org.gnome.desktop.background picture-uri file://$PICTURELINK 2>&1) 

echo "Desktop background set to $PICTURE"
notify-send -u "low" "Desktopper" "Updated desktop to $PICTURE" -t 10000