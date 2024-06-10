#!/bin/bash

rm -rf ~/.local/bin
ln -s `pwd`/bin ~/.local/bin
rm -f ~/.tmux.conf
rm -f ~/.config/tmux-powerline/config.sh
rm -f ~/.config/tmux-powerline/themes/theme.sh
ln -s `pwd`/conf/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config/tmux-powerline/themes
ln -s `pwd`/conf/tmux-powerline-config.sh ~/.config/tmux-powerline/config.sh
ln -s `pwd`/conf/tmux-powerline-theme.sh ~/.config/tmux-powerline/themes/theme.sh
rm -f ~/.config/nvim
ln -s `pwd`/conf/nvim ~/.config/nvim

