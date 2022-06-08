# dotfiles

First, do this:

```sh
pip install dotfiles
brew install adns autoconf automake avr-binutils avr-gcc@8 avrdude avro-c aws-es-proxy aws-iam-authenticator awscli cabextract cask clang-format cmake colordiff coreutils cscope csvkit ctags dark-mode dep dfu-programmer dfu-util diff-so-fancy direnv dive dos2unix drone-cli dwdiff editorconfig emacs exa fd findutils fluxctl fontconfig freetype fswatch fzf fzy gawk gcc gcc-arm-none-eabi gd gdbm gettext gh ghostscript git git-crypt glib gmp gnu-sed gnu-time gnupg gnutls go goreleaser graphviz grep gts heroku heroku-node htop httpie hub icdiff icu4c ilmbase imagemagick isl jansson jasper jemalloc jpeg jq jsonpp kafkacat kerl kube-ps1 kubectx kubernetes-cli leiningen libassuan libde265 libelf libevent libffi libftdi0 libgcrypt libgpg-error libheif libhid libidn2 libksba libmpc libomp libpng librdkafka libserdes libtasn1 libtermkey libtiff libtool libunistring libusb libusb-compat libuv libvterm libxml2 libxslt libyaml little-cms2 lua luajit lz4 lzlib md5sha1sum mitmproxy mpfr msgpack ncurses neovim netpbm nettle nmap node node@8 npth oniguruma openblas openexr openjpeg openssl openssl@1.1 optipng p11-kit p7zip pandoc pcre pcre2 perl pinentry pipenv pkg-config pngcrush postgresql protobuf pstree pv pwgen pyenv pyenv-virtualenv python python@2 python@3.8 r rbenv readline reattach-to-user-namespace redis ripgrep rlwrap ruby ruby-build s3cmd sbjson shared-mime-info shellcheck sloccount snappy sphinx-doc sqlite stern swagger-codegen tcping telnet terminal-notifier terraform terraform_landscape texinfo the_platinum_searcher the_silver_searcher thefuck tig tmux tree typescript ucl unbound unibilium unixodbc unrar upx v vim watch wdiff webp websocat wego wget wine winetricks wxmac x265 xz yajl yamllint zlib zsh zstd

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Tmux theme pack
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack

# setup pyenv
pyenv install 2.7.18
pyenv install 3.10.4
pyenv virtualenv 2.7.18 neovim2
pyenv virtualenv 3.10.4 neovim3

# 2.7
pyenv activate neovim2
pip install neovim
deactivate

# 3.6
pyenv activate neovim3
pip install neovim
source deactivate

# python paths for neovim are already configured in .config/nvim/init.vim
```
