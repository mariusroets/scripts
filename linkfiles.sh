#!/bin/bash

for dir in `pwd`/conf/*/; do
    config=$(basename $dir)
    echo "Copying config for: $config"
    rm -rf ~/.config/$config
    ln -s $dir ~/.config
done
rm -rf ~/.local/bin
ln -s `pwd`/bin ~/.local/bin
rm -f ~/.tmux.conf
ln -s `pwd`/conf/.tmux.conf ~/.tmux.conf

