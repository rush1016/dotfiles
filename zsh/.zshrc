export NVM_DIR="/Users/qip-innovation/Library/Application Support/Herd/config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export DEFAULT_NODE_VERSION="v16.13.2"

[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"

# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/qip-innovation/Library/Application Support/Herd/config/php/83/"


# Herd injected PHP binary.
export PATH="/Users/qip-innovation/Library/Application Support/Herd/bin/":$PATH


# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/qip-innovation/Library/Application Support/Herd/config/php/84/"


# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="/Users/qip-innovation/Library/Application Support/Herd/config/php/82/"


# Herd injected PHP 8.1 configuration.
export HERD_PHP_81_INI_SCAN_DIR="/Users/qip-innovation/Library/Application Support/Herd/config/php/81/"


# Herd injected PHP 8.0 configuration.
export HERD_PHP_80_INI_SCAN_DIR="/Users/qip-innovation/Library/Application Support/Herd/config/php/80/"

export XDG_CONFIG_HOME="$HOME/.config"

# Fuzzy Finder
source <(fzf --zsh)
bindkey "ç" fzf-cd-widget

# Prompt
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

function get_home_dir() {
    local path=$PWD
    local stripped_path="${path// /}"
    local length=${#stripped_path}

    if [[ $PWD == $HOME ]]; then
        echo "~";
    elif [[ $length -le 40 ]]; then
        echo "%~"
    else
        echo "%1d";
    fi
}

function get_node_version() {
    if [[ -d node_modules ]];
        then echo "$(node -v) ";
    fi
}

COLOR_DEF=$'%f'
COLOR_USR=$'%F{243}'
COLOR_DIR=$'%F{197}'
COLOR_GIT=$'%F{39}'
COLOR_MODIFIER=$'%F{049}'
NEWLINE=$'\n'
setopt PROMPT_SUBST
export PROMPT='${COLOR_DIR}$(get_home_dir) ${COLOR_GIT}$(parse_git_branch) ${COLOR_MODIFIER}$(get_node_version)${NEWLINE}${COLOR_MODIFIER}$ ${COLOR_DEF}'

# Neovim
export MYNVIMRC="$HOME/.config/nvim/init.lua"
export COLORTERM=truecolor
alias vi=nvim
alias vim=nvim

# Suggestions and Completions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^I' autosuggest-accept

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi
