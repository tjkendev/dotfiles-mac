export PATH=/usr/local:$PATH

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# history
export HISTSIZE=1000
export HISTIGNORE="pwd:history*:ls*:which*:fg*:hg*"
export HISTTIMEFORMAT="[%Y%m%d %H:%M:%S] "

export HISTCONTROL=ignoreboth:ignorespace

# jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# node
export NODE_PATH='/usr/local/lib/node_modules'

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
