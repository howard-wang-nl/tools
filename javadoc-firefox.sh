#!/bin/sh

if [ ! "$1" ]
then
  echo "Search full path file name which matches all the provided sub-strings for Javadoc jar file stored in ~/.ivy2/{cache,local} and open a clickable list in Firefox.
Usage: $0 <case insensitive sub-string of the file name> ...
Suitable for MacOS only.
"
  exit 1
fi

DIR=(~/.ivy2/cache ~/.ivy2/local ~/.m2/repository)
TMPD=/tmp/jdff
mkdir -p "${DIR[@]}"
mkdir -p $TMPD
TMPF=$TMPD/$$
NOT_FOUND=0

find "${DIR[@]}" -iname '*-javadoc.jar' >$TMPF
for PAT in "$@"
do
  fgrep -i "$PAT" <$TMPF >$TMPF.1 && mv $TMPF.1 $TMPF
  if [ $? -ne 0 ]; then NOT_FOUND=1; fi
done

if [ $NOT_FOUND -eq 1 ]
then
  echo "javadoc.jar files matching \"$@\" <font color="red">NOT</font> found in ${DIR[@]}.  Partial matching or all javadoc.jar files are shown instead:"
else
  echo "javadoc.jar files matching \"$@\" found in ${DIR[@]}:"
fi > $TMPF.htm

echo "<ol>" >> $TMPF.htm

cat $TMPF |
while read JAR
do
  # remove folder prefixes
  JAR_D=${JAR##*/.ivy2/cache/}
  JAR_D=${JAR_D##*/.ivy2/local/}
  JAR_D=${JAR_D##*/.m2/repository/}

  # output html index
  cat >>$TMPF.htm <<EOF
<li><a href="jar:file://$JAR!/index.html">$JAR_D</a></li>
EOF
done

echo "</ol>" >> $TMPF.htm

osascript -e "tell application \"Firefox\"" -e "activate" -e "open location \"file://$TMPF.htm\"" -e "end tell"

# open -a Firefox --args "jar:file://$1!/index.html"
# This command is not stable.  Firefox is only able to open the URL at first time.

# clean up old temp files not accessed recently
find $TMPD -mindepth 1 -atime +1h -delete

