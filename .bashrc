#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

(cat ~/.cache/wal/sequences &)

#aliases
alias ls='ls --color=auto'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

PS1='[\u@\h \W]\$ '

export VISUAL="vim"

export PATH=$HOME/.npm-global:$HOME/.local/bin:$PATH
