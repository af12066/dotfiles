#!/bin/bash

set -eu

DIR="$(dirname $0)"
cd "${DIR}"
ln -sf "${PWD}/.zshrc" ~/.zshrc
ln -sf "${PWD}/.zshenv" ~/.zshenv
ln -sf "${PWD}/.vimrc" ~/.vimrc
ln -sf "${PWD}/.vim" ~/.vim
ln -sf "${PWD}/.tmux.conf" ~/.tmux.conf
ln -sf "${PWD}/dircolors.256dark" ~/.dircolors
ln -sf "${PWD}/.latexmkrc" ~/.latexmkrc
ln -sf "${PWD}/.key_list" ~/.key_list
ln -sf "${PWD}/.gitconfig.global" ~/.gitconfig
if [[ -d ~/.config/git ]]; then
  :
else
  mkdir -p ~/.config/git
fi
ln -sf "${PWD}/.gitignore.global" ~/.config/git/ignore
