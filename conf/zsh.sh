
source ~/scripts/conf/alias
export POWI_ENV_PATH=/data/code/environments
export PATH=$PATH:$POWI_ENV_PATH/bin
export EDITOR=nvim
# Make 'less' exit when output is less than one screen, also handling colour codes correctly
export LESS="-FRX"
. ~/.secrets
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
