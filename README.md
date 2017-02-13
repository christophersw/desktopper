# Reddit Wallpaper Toolsh

Usage:
``` bash
$ desktopper [FOLDER] [SUBREDDIT] [DAYSTOKEEP] [REDDITUSERNAME]
```

You can run this with crontab by

```
$ crontab -e

// Example Add the folling (runs every ten minutes)
*/10 * * * * desktopper.sh $HOME/backgrounds earthporn 20 christophersw

```