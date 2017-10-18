#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#aliases
alias ls='ls -G'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

PS1='[\u@\h \W]\$ '
