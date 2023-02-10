autoload -Uz compinit
compinit

export PATH="${HOME}/.bin:${HOME}/bin:${KREW_ROOT:-$HOME/.krew}/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:${PATH}"
export KERL_CONFIGURE_OPTIONS="--enable-hipe --enable-smp-support --enable-threads --enable-kernel-poll --without-wx --without-javac --with-ssl=$(brew --prefix openssl@1.1) --with-odbc=$(brew --prefix unixodbc)"
# enable history in Erlang/Elixir REPL
export ERL_AFLAGS="-kernel shell_history enabled"

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 4) # blue
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 7; tput setab 4) # white on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

source ~/.zsh_aliases
unalias ll 2> /dev/null
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
OPENJDK_PATH="/usr/local/opt/openjdk/bin"
export PATH="${PYTHON3_USER_PATH}:${OPENJDK_PATH}:${PATH}"

# ASDF_DIR="$(brew --prefix asdf)/libexec"
# source "$ASDF_DIR/asdf.sh"
source /usr/local/opt/asdf/libexec/asdf.sh

# Use the fuck, an awesome command post-correction tool
eval $(thefuck --alias)
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"


eval "$(zoxide init zsh --no-aliases)"
unalias z 2> /dev/null
alias z=__zoxide_zi
function z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

export GPG_TTY=$(tty)

eval "$(sheldon source)"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
