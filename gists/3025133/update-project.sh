#!/bin/sh

D=`pwd`
cd /usr/local/mycompany/my-project
/usr/bin/git checkout master
/usr/bin/git fetch origin
/usr/bin/git reset --hard origin/master
npm install --unsafe-perm
~/fixperms.sh
restart my-project
cd $D
echo "Updated."
