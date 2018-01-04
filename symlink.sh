#!/bin/bash

set -eu

DIR="$(dirname $0)"
cd "${DIR}"
ln -sf "$(pwd)/.zshrc" ~/.zshrc
ln -sf "$(pwd)/.zshenv" ~/.zshenv
ln -sf "$(pwd)/.vimrc" ~/.vimrc
ln -sf "$(pwd)/.vim" ~/.vim
ln -sf "$(pwd)/.tmux.conf" ~/.tmux.conf
ln -sf "$(pwd)/dircolors.256dark" ~/.dircolors
ln -sf "$(pwd)/.latexmkrc" ~/.latexmkrc
ln -sf "$(pwd)/.key_list" ~/.key_list
