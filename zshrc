PROFILE_STARTUP=false

if [[ "$PROFILE_STARTUP" == true ]]; then
  zmodload zsh/zprof
  PS4=$'%D{%M%S%.} %N:%i> '
  exec 3>&2 2>$HOME/startlog.$$
  setopt xtrace prompt_subst
fi

case $(uname -m) in
  "arm64")
    homebrew_prefix=/opt/homebrew
    ;;
  "x86_64")
    homebrew_prefix=/usr/local
    ;;
  *)
    homebrew_prefix=$(brew --prefix)
    ;;
esac

FPATH="$homebrew_prefix/share/zsh/site-functions:${FPATH}"
zmodload zsh/complist
autoload -Uz compinit
compinit

# export PATH="${HOME}/.bin:${HOME}/bin:${KREW_ROOT:-$HOME/.krew}/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:${PATH}"
path=( 
  $HOME/.bin
  $HOME/bin
  # Created by `pipx` on 2024-06-04 08:47:56
  $HOME/.local/bin
  ${KREW_ROOT:-$HOME/.krew}/bin
  $homebrew_prefix/bin
  $homebrew_prefix/sbin
  $homebrew_prefix/opt/python/libexec/bin
  $homebrew_prefix/opt/openjdk/bin
  $path
)
export KERL_BUILD_DOCS="yes"
export KERL_DOC_TARGETS="chunks"
export KERL_CONFIGURE_OPTIONS="--enable-hipe --enable-smp-support --enable-threads --enable-kernel-poll --without-javac --with-ssl=$(brew --prefix openssl@1.1) --with-odbc=$(brew --prefix unixodbc) --with-wx"
# enable history in Erlang/Elixir REPL
export ERL_AFLAGS="-kernel shell_history enabled"

export EDITOR=nvim

source ~/.zsh_aliases
unalias ll 2> /dev/null
export EZA_CONFIG_DIR="$HOME/dotfiles/config/eza"
alias vim='nvim'
alias ls='eza --icons=auto'
alias ll='eza --long --header --git --group --icons=auto'
alias lsa='eza --long --header --git --group --all --icons=auto'
alias dft='git dft'

# Not doing this anymore, keep it around for reference
# PYTHON3_UNVERSIONED_BIN_PATH="$(brew --prefix python)/libexec/bin"
# PYTHON3_USER_PATH="$(python3 -m site --user-base)/bin"
# PYTHON3_USER_PATH="${HOME}/Library/Python/3.9/bin"
# OPENJDK_PATH="$(brew --prefix openjdk)/bin"
# # OPENJDK_PATH="/opt/homebrew/opt/openjdk/bin"
# export PATH="${PYTHON3_USER_PATH}:${PYTHON3_UNVERSIONED_BIN_PATH}:${OPENJDK_PATH}:${PATH}"

source <(fzf --zsh)
eval "$(mise activate zsh)"
eval "$(thefuck --alias)"
eval "$(direnv hook zsh)"


eval "$(zoxide init zsh)"

# eval "$(zoxide init zsh --no-aliases)"
# unalias z 2> /dev/null
# alias z=__zoxide_zi
# function z() {
#   [ $# -gt 0 ] && _z "$*" && return
#   cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
# }

export GPG_TTY=$(tty)

## Atuin for history
eval "$(atuin init zsh)"

## History file configuration (deprecated, use atuin)
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 100000 ] && HISTSIZE=100000
[ "$SAVEHIST" -lt 100000 ] && SAVEHIST=100000

## Edit command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

setopt autocd                 # cd into folders without cd

## completion
# zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select

zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
# fuzzy completion on any part of the word
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# prefer options over folders
zstyle ':completion:*' complete-options true

# configure xterm title
ZSH_TAB_TITLE_ADDITIONAL_TERMS='wezterm|kitty|tmux|ghostty'
ZSH_TAB_TITLE_CONCAT_FOLDER_PROCESS=true
ZSH_TAB_TITLE_ONLY_FOLDER=true
eval "$(sheldon source)"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

if [[ "$PROFILE_STARTUP" == true ]]; then
  zmodload zsh/zprof
  PS4=$'%D{%M%S%.} %N:%i> '
  exec 3>&2 2>$HOME/startlog.$$
  setopt xtrace prompt_subst
fi
