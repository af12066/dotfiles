#!/usr/bin/env zsh

cd $(dirname "$0")

mkdir -p ~/.config/tmux
mkdir -p ~/.config/nvim
mkdir -p ~/.config/git

ln -sf ${PWD}/tmux.conf ~/.config/tmux/tmux.conf
ln -sf ${PWD}/gitignore ~/.config/git/ignore
ln -sf ${PWD}/init.vim ~/.config/nvim/init.vim
ln -sf ${PWD}/zshenv ~/.zshenv
ln -sf ${PWD}/zshrc ~/.zshrc
