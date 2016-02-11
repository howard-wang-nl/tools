#!/bin/sh

if [ ! "$1" ]
then
  echo "Search full path file name which matches all the provided sub-strings for Javadoc jar file stored in ~/ivy2/cache and open the first matched one in Firefox browser.
Usage: $0 <case insensitive sub-string of the file name> ...
Suitable for MacOS only.
"
  exit 1
fi

DIR=~/.ivy2/cache
TMPF=/tmp/jdff-$$

find $DIR -iname '*-javadoc.jar' >$TMPF
for PAT in "$@"
do
  fgrep -i "$PAT" <$TMPF >$TMPF.1 && mv $TMPF.1 $TMPF
done

echo "javadoc.jar files matching \"$@\" found in ~/.ivy2/cache/
<ol>" > $TMPF.htm

cat $TMPF |
while read JAR
do
  cat >>$TMPF.htm <<EOF
<li><a href="jar:file://$JAR!/index.html">$JAR</a></li>
EOF
done

echo "</ol>" >> $TMPF.htm

osascript -e "tell application \"Firefox\"" -e "activate" -e "open location \"file://$TMPF.htm\"" -e "end tell"

# open -a Firefox --args "jar:file://$1!/index.html"
# This command is not stable.  Firefox is only able to open the URL at first time.
