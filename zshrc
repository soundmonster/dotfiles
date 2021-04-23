# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

DEFAULT_USER=$(whoami)
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="powerline"
ZSH_THEME="agnoster"
# ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git history-substring-search brew brew-cask bundler rake-fast rails colored-man-pages docker docker-compose osx pip rbenv)
plugins=(
		# asdf
		brew
		git
		terraform
		docker
		docker-compose
		tmux
		history-substring-search
		mix
		kube-ps1
		kubectl
		zsh-syntax-highlighting
	)

# User configuration

export PATH="${HOME}/.bin:${HOME}/bin:${KREW_ROOT:-$HOME/.krew}/bin:/Library/TeX/texbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$(python -m site --user-base)/bin:${PATH}"

export VISUAL=$(which nvim)
export EDITOR="$VISUAL"

# enable history in Erlang/Elixir REPL

source $ZSH/oh-my-zsh.sh

source ~/.profile
source ~/.zsh_profile
source ~/.zsh_aliases
alias ll='exa --long --header --git'
source <(stern --completion=zsh)
# source "`brew --prefix`/etc/grc.bashrc"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# source ${HOME}/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
# source /usr/local/Cellar/powerline/2.3/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=magenta,fg=white,bold'

# source /usr/local/opt/kube-ps1/share/kube-ps1.sh
export KUBE_PS1_ENABLED=false
PROMPT='$(kube_ps1)'$PROMPT

# Use the fuck, an awesome command post-correction tool
eval $(thefuck --alias)

unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

# fh - repeat history
unalias fh 2> /dev/null
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | gsed -r 's/ *[0-9]*\*? *//' | gsed -r 's/\\/\\\\/g')
}

export KERL_CONFIGURE_OPTIONS="--enable-hipe --enable-smp-support --enable-threads --enable-kernel-poll --with-wx --with-ssl=/usr/local/opt/openssl --with-odbc=/usr/local/opt/unixodbc"
export ERL_AFLAGS="-kernel shell_history enabled"

# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

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

eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
. $(brew --prefix asdf)/asdf.sh

