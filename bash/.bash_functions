#!/usr/bin/env bash

# Reason: function - Mother always told you to be tidy and organize your toys
# Author: Andrew Kuttor
# E-mail: andrew.kuttor@gmail.com

#------------------------------------------------------------------------------
# Functions
#------------------------------------------------------------------------------

# hops into new dir
mcd() {
    mkdir -p $1 && cd $1
}

# better dig
dug() {
    dig +nocmd $1 any +multiline +noall +answer
}

# backup file
backup(){
    cp -p $@{,.backup$(date '+%Y%m%dx')}
}

# highlighted cat
dog(){
    pygmentize -o style=monokai -f console256 -g $1
}

# better ls
lx(){
    tree -L 1 -Ccfhau --du --dirsfirst $@
}

# ll(){ l -l 2 $@; }

# send to trash
trash() {
    mv $@ "$HOME/.Trash"
}

# Eazy-E's SED
zed() {
    sed -i -e "s/$1/$2/g" $3
}

# multi-format unarchiver
extract() {
    if [ -f $1 ]; then 
        case $1 in
          *.tar.bz2)   tar xjf $1     ;;
          *.tar.gz)    tar xzf $1     ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar e $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xf $1      ;;
          *.tbz2)      tar xjf $1     ;;
          *.tgz)       tar xzf $1     ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "$1 " ;;
      esac
  else
      echo "Incompatible archive: $1"
  fi
}
