#!/usr/bin/env bash

# TODO:
#  - DRY relevant parts

singlequotes=`find -type f \( -iname \*.js -o -iname \*.ts \) -not -path '*node_modules/*' -exec cat \{\} \; | tr -cd \' | wc -c`
doublequotes=`find -type f \( -iname \*.js -o -iname \*.ts \) -not -path '*node_modules/*' -exec cat \{\} \; | tr -cd '"' | wc -c`

total=$(($singlequotes + $doublequotes))

singlequotespercentage=`node -pe "Math.round($singlequotes / $total * 100)"`
doublequotespercentage=`node -pe "Math.round($doublequotes / $total * 100)"`

basename `pwd`

if [ $singlequotes -gt $doublequotes ] ; then
	echo "Single quotes (') are more dominant: $singlequotespercentage %"
else
	echo "Double quotes (\") are more dominant: $doublequotespercentage %"
fi

