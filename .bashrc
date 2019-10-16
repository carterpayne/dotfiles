#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#functions
source ~/.functions

#aliases
alias ls='ls -G'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

PS1='[\u@\h \W]\$ '

export VISUAL="vim"

