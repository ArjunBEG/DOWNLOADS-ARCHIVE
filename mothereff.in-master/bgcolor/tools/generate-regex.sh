#!/usr/bin/env bash

# http://code.google.com/p/esprima/issues/detail?id=110#c1

# Allow running this script from another directory
cd "$(dirname "$0")"

# The latest version of UnicodeData.txt can be found at:
# http://unicode.org/Public/UNIDATA/UnicodeData.txt
# Static, versioned copies have URLs similar to:
# http://www.unicode.org/Public/6.2.0/ucd/UnicodeData.txt
#curl -# http://www.unicode.org/Public/6.2.0/ucd/UnicodeData.txt > UnicodeData-6.2.0.txt

# Generate the regular expressions
python parse.py UnicodeData-6.2.0.txt