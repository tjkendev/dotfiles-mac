
export EDITOR=vim
export LANG=ja_JP.UTF-8
export KCODE=u

# key bind = vim
bindkey -v

setopt no_beep            # beep音なし
setopt auto_cd            # ディレクトリ入力で移動
setopt magic_equal_subst  # =以降の保管
setopt notify             # bg jobの状態変化通知
setopt equals             # '=command' => 'which command'

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

autoload -U compinit; compinit # 補完機能有効
setopt auto_list               # 補完候補一覧表示
setopt auto_menu               # 補完キーで補完候補を順に表示
setopt list_packed             # 補完候補を詰めて表示
setopt list_types              # 補完候補にファイルの種類表示

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt bang_hist          # '!'
setopt extended_history   # ヒストリに実行時間も保存
setopt hist_ignore_dups   # 直前の同じコマンドは保存しない
setopt share_history      # 他のシェルのヒストリを共有
setopt hist_reduce_blanks # 余分なスペース削除


export CLICOLOR=true # lsコマンド色付き


autoload -U colors; colors # プロンプト色付き
# 通常
tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# root
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

# alias
alias l='ls'
alias la='ls -a'
alias ll='ll -la'

alias h='history'

alias a='./a.out'

# nvm
source ~/.nvm/nvm.sh

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

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
