rm -rf ~/.local/bin
ln -s `pwd`/bin ~/.local/bin
rm -f ~/.config/tmux-powerline/config.sh
rm -f ~/.config/tmux-powerline/themes/theme.sh
mkdir -p ~/.config/tmux-powerline/themes
ln -s `pwd`/conf/tmux-powerline-config.sh ~/.config/tmux-powerline/config.sh
ln -s `pwd`/conf/tmux-powerline-theme.sh ~/.config/tmux-powerline/themes/theme.sh

