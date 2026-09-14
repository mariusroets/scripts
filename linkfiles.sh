#!/bin/bash

CONF_DIR=~/.config

confirm_action() {
    read -p "$1 (y/N): " response
    [[ "$response" =~ ^[Yy]$ ]]
}
copy_dir() {
    if [[ -d $CONF_DIR/$1 ]]; then
        timestamp=$(date +%Y%m%d%H%M)
        mv $CONF_DIR/$1 $CONF_DIR/$1.$timestamp
    fi
    ln -s $1 $CONF_DIR
}

if confirm_action "Install NeoVim config?"; then
    copy_dir nvim
else
    echo "Skipped..."
fi
if confirm_action "Install Lazygit config?"; then
    copy_dir lazygit
else
    echo "Skipped..."
fi
if confirm_action "Install tmux config?"; then
    copy_dir tmux
else
    echo "Skipped..."
fi
for f in bin/*; do

    if confirm_action "Install $f"; then
        ln -s bin/$f ~/.local/bin/$f
    fi
done


