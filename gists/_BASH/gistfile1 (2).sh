# my ~/.profile
# somewhat mac-specific, lots of git aliases

# functionName () { do something $@<-arguments ; } 
function ls    { command ls -1AGp "$@"; } 
       # 'command ls' to prevent loop; -A for .file, -F for dir/ link@, 
       # -h for 5k 3m 1g, -o for printing flags (uchg)... 
function l     { ls -lhog "$@"; } # -l to list in long format... 
function ll    { ls -lF "$@" | less -XF ; } # pipe into 'more' 

# http://pastie.caboo.se/pastes/165446
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local      YELLOW="\[\033[0;33m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local        NONE="\[\033[0m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac
  
  # time: $BLUE[$RED\$(date +%H:%M)$BLUE]\
  # user: $YELLOW\u$WHITE@
  PS1="${TITLEBAR}$NONE[$GREEN\w$NONE]$RED\$(parse_git_branch)$YELLOW\$$NONE "
  PS2='> '
  PS4='+ '
}
proml

# Aliases frequently used... 
alias ..='cd ..;l'
alias cd..='cd ..'
alias which='type' # 'which' in (t)csh is same(?) as 'type' in bash... 
alias quit='exit'
alias q='quit' # and 'q' is even shorter! :-D 
alias v='vim'
alias rehash='. ~/.profile;' # source ~/.profile after I edit it 
alias pg='ps -afe|grep -v grep|grep'
alias md='mkdir -p'
alias wad='tar -czvf'
alias unwad='tar -xzvf'

# svn
alias ss='svn st --ignore-externals'
alias sup='svn up --ignore-externals'

# git
alias g='git'
alias gap='git add -p'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git pull'
alias gp='git push'
alias gs='git status'
alias go='git checkout'
alias gob='git checkout -b'

# http://www.caliban.org/bash/
export CDPATH=".:~" # add more paths, colon-delimited
export HISTIGNORE="&:l:l[ls]:g[ds]:.."

# http://blog.macromates.com/2008/working-with-history-in-bash/
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

# http://twitter.com/sorbits/statuses/845782451
export MAKEFLAGS='-j4'

export PATH="$HOME/bin:/usr/local/bin:$PATH"
