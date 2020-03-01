# Specify your defaults in this environment variable
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi


export PS1=":\w$ "
export CLICOLOR=1

source $HOME/.bashrc

alias m="mvn"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

if [ -f ~/.maven-completion.bash ]; then
  . ~/.maven-completion.bash
fi
__git_complete g _git


export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local//opt/libexec/gnubin:$PATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/youri/.sdkman"
[[ -s "/Users/youri/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/youri/.sdkman/bin/sdkman-init.sh"
