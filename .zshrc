# ZINIT Plugin Manager
# ----------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
# ----------------------------------------------------------
#  Plugins without turbo mode
# ----------------------------------------------------------
zinit light Aloxaf/fzf-tab
zinit load jeffreytse/zsh-vi-mode
# ----------------------------------------------------------
# Zinit settings for speed (turbo mode)
# ----------------------------------------------------------
zinit ice wait'!0' lucid
# ----------------------------------------------------------
# Plugins with turbo mode
# ----------------------------------------------------------
zinit light MichaelAquilina/zsh-you-should-use
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light agkozak/zsh-z
zinit light zsh-users/zsh-completions
# ----------------------------------------------------------

# zsh-history-substring-search configuration
# bindkey '^[[A' history-substring-search-up # or '\eOA'
# bindkey '^[[B' history-substring-search-down # or '\eOB'
# HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit load 'zsh-users/zsh-history-substring-search'
zinit ice wait atload'_history_substring_search_config'
 # Unbind default keybindings
# bindkey -r '^P'
# bindkey -r '^N'
# Bind Ctrl + P and Ctrl + N to history-substring-search functions
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down


# Optimize prompt rendering
zinit wait lucid for \
    OMZ::lib/compfix.zsh \
    OMZ::lib/completion.zsh \
    OMZ::lib/directories.zsh \
    OMZ::lib/functions.zsh \
    OMZ::lib/history.zsh \
    OMZ::lib/key-bindings.zsh \
    OMZ::lib/termsupport.zsh

setopt histignorealldups sharehistory

# Set up environment variables
export EDITOR='nvim'
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export COLORTERM="truecolor"

# Zsh options for history
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_REDUCE_BLANKS

# Zsh options for shell behavior
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt CORRECT
setopt CORRECT_ALL
setopt NO_CASE_GLOB
setopt COMPLETE_IN_WORD

# Key bindings
# bindkey -v        # Vi mode
bindkey '^R' history-incremental-search-backward

# Aliases
# ----------------------------------------------------------
alias alibabacloud="ssh -i .ssh/alibabacloud.pem enricoserver@147.139.171.149"
alias gvim='goneovim'
alias vim='nvim'
alias nano='vim'                       # Alias for nano to vim
alias transid='trans :id'              # Alias for trans shell translate to indonesia
alias transhell='trans -shell'
alias transhid='trans -shell :id'
alias npm='pnpm'
alias logout='swaymsg exit'
alias lock='swaylock'
alias sleep='systemctl suspend -i'     # Sleep the pc
alias restart='systemctl reboot -i'    # Restart the pc
alias shutdown='systemctl poweroff -i' # Shutdown the pc
alias hibernate='systemctl hibernate -i' # Hibernate the pc
alias reload='exec zsh'                # Reload zsh
alias editvim='vim ~/.config/nvim/init.vim'
alias luaformat='vim $XDG_CONFIG_HOME/luaformatter/config.yaml'
alias luamake=/home/enricofadly/lsp/lua-language-server/3rd/luamake/luamake
alias ezsh='vim ~/.zshrc'
alias packernvim='vim ~/.config/nvim/lua/plugins.lua'
alias f='floaterm'
alias calendar='khal calendar'
alias cht='cht.sh'
alias yay='yay --noconfirm --sudoloop' #Install without asking permission and autoconfirm
alias brightlow='brightnessctl set 2'
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# ----------------------------------------------------------


# Init sources for third party tools/apps
# ----------------------------------------------------------
# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
    COMP_CWORD=$(( cword-1 )) \
    PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
  }
compctl -K _pip_completion pip

# Brew init
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

# asdf init
. $HOME/.asdf/asdf.sh
export PATH="$HOME/.asdf/shims:$PATH"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
#-----------------------------------------------------------


# Source, export, variable, set, etc configs
# Set environment variables
# ----------------------------------------------------------

# bemenu color
export BEMENU_OPTS="--tb '#6272a4'\
 --tf '#f8f8f2'\
 --fb '#282a36'\
 --ff '#f8f8f2'\
 --nb '#282a36'\
 --nf '#6272a4'\
 --hb '#44475a'\
 --hf '#50fa7b'\
 --sb '#44475a'\
 --sf '#50fa7b'\
 --scb '#282a36'\
 --scf '#ff79c6'"

# export BROWSER=google-chrome-stable

# QT apps
# export QT_QPA_PLATFORMTHEME=qt5ct

# Autostart the gnome-keyring
# if [ -n "$DESKTOP_SESSION" ];then
#     eval $(gnome-keyring-daemon --start)
#     export SSH_AUTH_SOCK
# fi

# Wayland specific environment variable
# export MOZ_ENABLE_WAYLAND=1
# export XDG_CURRENT_DESKTOP=sway
# export XDG_SESSION_TYPE=wayland
# export WLR_NO_HARDWARE_CURSORS=1

# Cht.sh completion
fpath=(~/.zsh.d/ $fpath)

# Set $EDITOR and $VISUAL to nvim
export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"

# Bat themes
export BAT_THEME="Dracula"

# export node global path
# export PATH=./node_modules/.bin:$PATH

# export config path
export XDG_CONFIG_HOME="$HOME/.config"

# Thefuck
eval $(thefuck --alias)

# Make Custom executable directory
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin/:$PATH"

# cs50 libraries for c
CC="clang"
CFLAGS="-fsanitize=signed-integer-overflow -fsanitize=undefined -ggdb3 -O0 -std=c11 -Wall -Werror -Wextra -Wno-sign-compare -Wno-unused-parameter -Wno-unused-variable -Wshadow"
LDLIBS="-lcrypt -lcs50 -lm"
# ----------------------------------------------------------

# Zsh vi mode configuration
# ----------------------------------------------------------
set -o vi
# To fix the compability with zsh vi mode
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
# keep using the default keybindings `^[` in other modes
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
# Change to Zsh's default readkey engine
# ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE

# ALL FZFs configuration
# ----------------------------------------------------------
# Fzf colorschemes dracula theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'

# For postponing loading `fzf`
zinit ice lucid wait
zinit snippet OMZP::fzf
# FZF key bindings and fuzzy completion
zinit light junegunn/fzf
zinit light junegunn/fzf-bin

if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

# Load custom scripts
# for script in ~/.zsh_custom/*.zsh; do
#   source $script
# done

alias fd="fd --hidden --follow --exclude .git"
alias rg="rg --files --hidden --follow --glob '!.git'"                 # ripgrep to search through hidden file
alias fzf="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias batgrep="rg"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'" # Fzf using rg
#export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude .git"        # Alt t Shortcut to search file
export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude .git"          # Alt t Shortcut to search file
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || bat --style=numbers --color=always --line-range :500 {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_ALT_C_COMMAND="fd -t d --hidden --follow --exclude .git"      # Alt c Shortcut to cd
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# Fzf-tab custom configuration to incude dotfiles in completion
setopt glob_dots
zstyle ':completion:*' special dirs true
zstyle ':completion:*' format '[%d]'
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# Generated from zsh wizard
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
# ----------------------------------------------------------

# completions
if [ -d $HOME/.zsh/comp ]; then
  export FPATH="$HOME/.zsh/comp:$FPATH"
fi

# Keep these configurations in bottom
# ----------------------------------------------------------

eval "$(starship init zsh)"
function set_win_title(){
      echo -ne "\033]0; $(basename "$PWD") \007"
}
starship_precmd_user_func="set_win_title"

# nerdfetch

export PNPM_HOME="/home/enricofadly/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# pnpm
export PNPM_HOME="/home/enricofadly/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

# Docker completion
fpath=(~/.docker/completions \\$fpath)

# Performance optimization for completion system
autoload -Uz compinit
# zstyle ':completion:*' rehash true

# Initialize compinit with caching
if [[ -z "$ZSH_COMPDUMP" ]]; then
  export ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
fi
compinit -d "$ZSH_COMPDUMP" -C -i

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
fpath=(~/.zsh.d/ $fpath)
