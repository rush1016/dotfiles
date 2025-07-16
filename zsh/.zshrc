# Local user scripts
export PATH="$HOME/.local/bin:$PATH"

export DEFAULT_NODE_VERSION="v16.13.2"
export NODE_VERSION="v16.13.2"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

alias ls='ls -F --color=auto'
alias la='ls -A'
alias lla='la -l'

# Fuzzy Finder
source <(fzf --zsh)
bindkey "ç" fzf-cd-widget

# Prompt
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/git:(\1) /p'
}

function get_home_dir() {
    local path=$PWD
    local stripped_path="${path// /}"
    local length=${#stripped_path}

    if [[ $PWD == $HOME ]]; then
        echo "~ ";
    elif [[ $length -le 40 ]]; then
        echo "%~ "
    else
        echo "%1d ";
    fi
}

COLOR_DEF=$'%f'
COLOR_USR=$'%F{243}'
COLOR_DIR=$'%F{197}'
COLOR_GIT=$'%F{39}'
COLOR_MODIFIER=$'%F{049}'
NEWLINE=$'\n'
setopt PROMPT_SUBST
export PROMPT='${COLOR_MODIFIER}➜ ${COLOR_DIR}$(get_home_dir)${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}'

# Neovim
export MYNVIMRC="$HOME/.config/nvim/init.lua"
export COLORTERM=truecolor
# alias vi=nvim
alias vim=nvim

# Suggestions and Completions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^I' autosuggest-accept

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

bindkey -s '^F' '~/.local/bin/tmux-sessionizer\n'

. "$(brew --prefix asdf)/libexec/asdf.sh"
export PATH=$PATH:$(go env GOPATH)/bin

# work aliases
alias dps="docker ps --format \"table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}\""
alias dc="docker compose"
alias dcr="~/.dotfiles/scripts/docker-compose-restart.sh"
alias tinker="dc exec php php artisan tinker"
alias artisan="dc exec php php artisan"
alias db="dc exec mysql mysql -u root -p "
alias coredb="dc exec mysql mysql -u root -p customizer_core"

