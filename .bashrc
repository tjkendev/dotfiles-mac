# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

export TERM=xterm-256color

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
  xterm-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[4m\]\[\033[1;32m\]\u@\h\[\033[00m\]:\[\033[1;33m\]\w\[\033[00m\] \$ '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;42m\]\u@\h\[\033[00m\]:\[\033[1;33m\]\w\[\033[00m\] \$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dir_colors && eval "$(dircolors -b ~/.dir_colors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ls alias
alias ll='ls -alFG'
alias la='ls -AG'
alias l='ls -CFG'

# brew's bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# wine
#WINENOPULSE=1
#function WineTo32() {
#  local WINEARCH='win32'
#  local WINEPREFIX='~/.wine32'
#  local WFCOM=`which ${1}`
#  WINEARCH=${WINEARCH} WINEPREFIX=${WINEPREFIX} $WFCOM $@
#}
# wine32
alias wine32='WINEARCH=win32 WINEPREFIX=~/.wine32 wine'
alias winebuild32='WINEARCH=win32 WINEPREFIX=~/.wine32 winebuild'
alias winecfg32='WINEARCH=win32 WINEPREFIX=~/.wine32 winecfg'
alias wineconsole32='WINEARCH=win32 WINEPREFIX=~/.wine32 wineconsole'
alias winecpp32='WINEARCH=win32 WINEPREFIX=~/.wine32 winecpp'
alias winedbg32='WINEARCH=win32 WINEPREFIX=~/.wine32 winedbg'
alias winedump32='WINEARCH=win32 WINEPREFIX=~/.wine32 winedump'
alias winefile32='WINEARCH=win32 WINEPREFIX=~/.wine32 winefile'
alias winegcc32='WINEARCH=win32 WINEPREFIX=~/.wine32 winegcc'
alias wineg++32='WINEARCH=win32 WINEPREFIX=~/.wine32 wineg++'
alias winepath32='WINEARCH=win32 WINEPREFIX=~/.wine32 winepath'

alias winetricks32='WINEARCH=win32 WINEPREFIX=~/.wine32 winetricks'
alias winetricks64='WINEARCH=win64 WINEPREFIX=~/.wine winetricks'

# Java
#JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
#export JAVA_HOME
#PATH=$PATH:$JAVA_HOME/bin
#export PATH

export PATH="~/usr/bin:$PATH"

# Windowsの"a --> a.exe"みたいな感じ
alias a='./a.out'

# history
alias h='history'

# nvm
if [ -d ~/.nvm ]; then
  source ~/.nvm/nvm.sh
fi

# npm
if which npm &>/dev/null; then
  export NODE_PATH=$(npm root -g)
fi

# rbenv
if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# pbcopy
alias pbcopy='xsel --clipboard --input'

# mysql
export PATH=/usr/local/mysql/bin:$PATH
