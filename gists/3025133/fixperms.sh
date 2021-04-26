#!/bin/sh

T=/usr/local/mycompany/my-project
chown -R www-data:root $T
find $T -type d ! -perm 770                -print -exec chmod 770 {} \;
find $T -type f ! -perm 660 ! -name "*.sh" -print -exec chmod 660 {} \;
find $T -type f ! -perm 770   -name "*.sh" -print -exec chmod 770 {} \;

