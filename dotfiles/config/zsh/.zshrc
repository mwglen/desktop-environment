unsetopt BEEP
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
unsetopt HIST_EXPIRE_DUPS_FIRST
unsetopt EXTENDED_HISTORY
HISTSIZE="10000"
SAVEHIST="10000"
HISTFILE="$XDG_STATE_HOME/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

zstyle :compinstall filename '$XDG_CONFIG_HOME/zsh/.zshrc'
autoload -Uz compinit; compinit
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey -v
bindkey "^?" backward-delete-char # Fix backspace

# Search forward and backward through history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

autoload -Uz promptinit; promptinit
zstyle :prompt:pure:prompt:success color green
zstyle :prompt:pure:prompt:error color red
zstyle :prompt:pure:prompt:continuation color white
zstyle :prompt:pure:virtualenv color white
zstyle :prompt:pure:execution_time color white
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:git:stash color white
zstyle :prompt:pure:git:arrow color white
zstyle :prompt:pure:git:action color white
zstyle :prompt:pure:git:dirty color white
zstyle :prompt:pure:git:branch color white
zstyle :prompt:pure:git:branch:cached color red
zstyle :prompt:pure:path color white
zstyle :prompt:pure:host color white
zstyle :prompt:pure:user color white
zstyle :prompt:pure:user:root color magenta
prompt pure

alias vi=nvim
alias vim=nvim
export EDITOR=nvim

playerctld daemon &> /dev/null

vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

export DOTDROP_DIR="$HOME/Repositories/desktop-environment"
alias dotdrop="dotdrop --cfg=$DOTDROP_DIR/config.yaml"

alias ls="ls --color=auto --group-directories"
alias ll="ls -alh"
alias la="ls -A"
alias df="df -h"
alias free="free -h"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias services="systemctl list-unit-files --state=enabled"
alias ip="ip -color=auto"
alias du="du -sh"
alias v="nvim"
#alias -s {md,org,txt,sh,rs,xml,txt\'}=nvim
#alias -s {png}=nsxiv
#alias -s {pdf}=firefox

alias rm="rmtrash"
alias rmdir="rmdirtrash"
alias sudo="sudo "

alias spotify="spotify --force-device-scale-factor=2"

alias emacs="devour emacs"
alias emacsclient="devour emacsclient"
alias nsxiv="devour nsxiv -ab -s f"
export VISUAL="devour emacsclient -c"

# Use pywal colorscheme
(cat $HOME/.config/wpg/sequences &)

# Use pywal colorscheme for TTYs
#source ~/.cache/wal/colors-tty.sh
