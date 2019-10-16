export PATH="${PATH}:$HOME/Library/Python/3.7/bin"
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/carterpayne/.sdkman"
[[ -s "/Users/carterpayne/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/carterpayne/.sdkman/bin/sdkman-init.sh"
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export VISUAL="vim"

#functions
source ~/.functions

#aliases
source ~/.aliases
