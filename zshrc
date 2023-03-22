FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
zmodload zsh/complist
autoload -Uz compinit
compinit

export PATH="${HOME}/.bin:${HOME}/bin:${KREW_ROOT:-$HOME/.krew}/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:${PATH}"
export KERL_CONFIGURE_OPTIONS="--enable-hipe --enable-smp-support --enable-threads --enable-kernel-poll --without-wx --without-javac --with-ssl=$(brew --prefix openssl@1.1) --with-odbc=$(brew --prefix unixodbc)"
# enable history in Erlang/Elixir REPL
export ERL_AFLAGS="-kernel shell_history enabled"

export EDITOR=nvim

source ~/.zsh_aliases
unalias ll 2> /dev/null
alias ls='exa'
alias ll='exa --long --header --git --group'
alias lsa='exa --long --header --git --group --all'
alias gbr="git branch | fzf | xargs git checkout"

# fh - repeat history
unalias fh 2> /dev/null
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf --tac | gsed -r 's/ *[0-9]*\*? *//' | gsed -r 's/\\/\\\\/g')
}

# PYTHON3_USER_PATH="$(python3 -m site --user-base)/bin"
PYTHON3_USER_PATH="/Users/leonid/Library/Python/3.9/bin"
# OPENJDK_PATH="$(brew --prefix openjdk)/bin"
OPENJDK_PATH="/opt/homebrew/opt/openjdk/bin"
export PATH="${PYTHON3_USER_PATH}:${OPENJDK_PATH}:${PATH}"

# ASDF_DIR="$(brew --prefix asdf)/libexec"
# source "$ASDF_DIR/asdf.sh"
asdf_dir="/opt/homebrew/opt/asdf/libexec"
source /opt/homebrew/opt/asdf/libexec/asdf.sh

# Use the fuck, an awesome command post-correction tool
eval $(thefuck --alias)
eval "$(direnv hook zsh)"
# eval "$(starship init zsh)"


eval "$(zoxide init zsh --no-aliases)"
unalias z 2> /dev/null
alias z=__zoxide_zi
function z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

export GPG_TTY=$(tty)

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

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
ZSH_TAB_TITLE_ADDITIONAL_TERMS=wezterm
ZSH_TAB_TITLE_CONCAT_FOLDER_PROCESS=true
ZSH_TAB_TITLE_ONLY_FOLDER=true
eval "$(sheldon source)"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
