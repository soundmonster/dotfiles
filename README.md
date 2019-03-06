# dotfiles

First, do this:

```sh
pip install dotfiles
brew install autoconf automake cask cmake colordiff coreutils csvkit ctags ctop dep diff-so-fancy dos2unix dwdiff editorconfig findutils fontconfig fzf gawk gcc gd git gnu-sed gnu-time gnupg gnutls gpg-agent graphviz grep htop httpie hub jq kerl macvim mitmproxy nmap openssl optipng p7zip pandoc pipenv pngcrush powerline pstree pv pwgen rbenv reattach-to-user-namespace rlwrap rubber ruby ruby-build s3cmd shared-mime-info shellcheck sloccount stern tcping telnet terminal-notifier texinfo the_platinum_searcher the_silver_searcher thefuck tig tmux tree unrar upx v vim watch wget wine winetricks wxmac xz yamllint zsh pyenv zlib neovim
# Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Tmux theme pack
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack

# setup pyenv
LDFLAGS="-L/usr/local/opt/zlib/lib" CPPFLAGS="-I/usr/local/opt/zlib/include" PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig" pyenv install 2.7.14
LDFLAGS="-L/usr/local/opt/zlib/lib" CPPFLAGS="-I/usr/local/opt/zlib/include" PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig" pyenv install 3.6.5
pyenv virtualenv 2.7.14 neovim2
pyenv virtualenv 3.6.5 neovim3

# 2.7
pyenv activate neovim2
pip install neovim
deactivate

# 3.6
pyenv activate neovim3
pip install neovim
deactivate

# python paths for neovim are already configured in .config/nvim/init.vim
```
