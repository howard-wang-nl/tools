#!/bin/sh

if [ ! "$1" ]
then
  echo "Open Javadoc jar file in Firefox browser.
Usage: $0 <jar file>"
  exit 1
fi

osascript -e "tell application \"Firefox\"" -e "activate" -e "open location \"jar:file://$1!/index.html\"" -e "end tell"

# open -a Firefox --args "jar:file://$1!/index.html"
# This command is not stable.  Firefox is only able to open the URL at first time.
