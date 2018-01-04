#!/bin/bash
# Homebrew でコマンドラインツールを一括インストールするやつ

set -eu

brew update && brew upgrade

# GNU Coreutils を有効にするには PATH で /usr/local/opt/coreutils/libexec/gnubin を優先させる
brew install coreutils
# sed, grep, diff, gzip も GNU/Linux 版に置き換え
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install grep --with-default-names
brew install diffutils
brew install gzip

# GitHub に GPG 署名を加える
# gpg-agent は PATH に /usr/local/opt/gpg-agent/bin を含める
brew cask install osxfuse
brew install gnupg --with-encfs --with-gpg-zip --with-gpgsplit --with-readline --with-large-secmem
brew install gpg-agent pinentry-mac

# Git とオプションの依存ソフトウエアをインストール
brew install openssl
brew install curl --with-openssl
brew install git --with-curl --with-gettext --with-openssl --with-pcre2

# MacVim を上書きインストール
brew install macvim --with-lua --with-luajit --with-override-system-vim --with-python3

# Zsh 周辺ツール
brew install zsh
brew install zsh-completions
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

# 開発ツール各種
brew install pyenv
brew install rbenv ruby-build
brew install goenv
brew install ndenv node-build
brew install plenv
brew install r --with-java --with-openblas
brew install peco
brew install reattach-to-user-namespace
brew install tmux
brew install awscli
brew install jq
brew install tree
brew install colordiff

# 変換ツール
brew install ghostscript
brew install imagemagick --with-webp --with-fontconfig --with-ghostscript
brew install optipng
brew install guetzli
brew install nkf
brew install pandoc pandoc-crossref pandoc-citeproc

# 過去のバージョンを削除
brew cleanup
