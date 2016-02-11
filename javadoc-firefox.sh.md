Browse Javadoc jar file content
===============================

### Problem

Shift+F1 to view external javadoc doesn't work in IntelliJ even though the javadoc.jar files are verified downloaded in .ivy2 cache and configured automatically in IntelliJ project library Javadoc path. Once I found it worked before, but now the view external documentation button is grayed thus disabled.

### Solution

Dash[1] is good but to select and download required docset of correct version is tedious.

An alternative is to locate the javadoc.jar file and open them in Firefox with `jar:file:///path/javadoc.jar!/` , to save effort to search online docs with the correct version.

Simple script for MacOS to open Javadoc jar documentations in Firefox easily:

1. Save this script and name it as `/usr/local/bin/jdff` and `chmod +x`.
2. Search for Spark MLLib Javadoc in `~/.ivy2/cache` and open clickable list in Firefox:
   ```jdff spark mllib```

### Related articles

1. Dash for OS X - API Documentation Browser, Snippet Manager https://kapeli.com/dash
2. Zeal is an offline documentation browser inspired by Dash, available for Linux and Windows https://zealdocs.org/
3. Velocity - The Documentation and Docset Viewer for Windows https://velocity.silverlakesoftware.com/

