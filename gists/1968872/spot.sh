#!/usr/bin/env bash

# search directory defaults to current
dir=.

# case sensitive search
sensitive=

# colors enabled by default in ttys
if [ -t 1 ]; then
  colors=1
else
  colors=
fi

# line numbers shown by default
linenums=1

# ansi colors
cyan=`echo -e '\033[36m'`
reset=`echo -e '\033[39m'`

# usage info
function usage {
  cat <<EOF

  Usage: spot [options] [directory] [term ...]

  Options:

    -s, --sensitive         Case sensitive search.
    -C, --no-colors         Force avoid colors.
    -L, --no-linenums       Hide line numbers.

EOF
}

# parse options
while [[ "$1" =~ "-" ]]; do
    case $1 in
        -s | --sensitive )
          sensitive=1
          ;;
        -C | --no-colors )
          colors=
          ;;
        -L | --no-linenums )
          linenums=
          ;;
        -h | --help )
          usage
          exit
          ;;
    esac
    shift
done

# grep default params
grepopt="-Z"

# add case insensitive search
if [ ! $sensitive ]; then
  grepopt="$grepopt --ignore-case"
fi

# add padding options
if [ $padding ]; then
  grepopt="$grepopt -A $padding -B $padding"
fi

# add line number options
if [ $linenums ]; then
  grepopt="$grepopt -n"
fi

# add force colors
if [ $colors ]; then
  grepopt="$grepopt --color=always"
fi

# check for directory as first parameter
if [[ "$1" =~ / ]]; then
  if [ -d "$1" ]; then
    dir=$1
    shift
  fi
fi

# check for empty search
if [[ "" = "$@" ]]; then
  echo "(no search term)"
  exit 1
fi

# run search
if [ $colors ]; then
  find . -type f ! -regex ".*[/]\.git[/].*" -print0 \
    | GREP_COLOR="1;30;43" xargs -0 grep $grepopt "$@" \
    | sed "s/^\([^:]*:\)\(.*\)/  \\
  $cyan\1$reset  \\
  \2 /"
else
  find . -type f ! -regex ".*[/]\.git[/].*" -print0 \
    | xargs -0 grep $grepopt "$@" \
    | sed "s/^\([^:]*:\)\(.*\)/  \\
  \1  \\
  \2 /"
fi

echo ""
