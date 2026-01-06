
source ~/scripts/conf/alias
export POWI_ENV_PATH=/data/code/environments
export PATH=$PATH:$POWI_ENV_PATH/bin
export EDITOR=nvim
. ~/.secrets
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
