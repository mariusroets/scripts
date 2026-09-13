
#
source ~/scripts/conf/alias
export POWI_ENV_PATH=/data/code/platform/environments
export PATH=$PATH:$POWI_ENV_PATH/bin
export EDITOR=nvim
. ~/.secrets

# Custom usql wrapper function
u() {
    local target="$1"

    case "$target" in
        *prod*|*PROD*)
            # RED prompt for production targets
            usql -v PROMPT1='%[%033[1;31m%][PROD] %n@%m %#%[%033[0m%] ' "$@"
            ;;
        *)
            # GREEN prompt for non-production targets
            usql -v PROMPT1='%[%033[1;32m%][DEV] %n@%m %#%[%033[0m%] ' "$@"
            ;;
    esac
}
