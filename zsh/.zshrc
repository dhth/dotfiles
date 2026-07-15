if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/.zsh_env_vars
source $HOME/.env_vars_secret.sh
export ZSH="$HOME/.oh-my-zsh"

plugins=(zsh-lazyload zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

black=$'\033[30m'
red=$'\033[31m'
GREEN=$'\033[32m'
yellow=$'\033[33m'
blue=$'\033[34m'
magenta=$'\033[35m'
cyan=$'\033[36m'
white=$'\033[37m'
NOCOLOR="\033[0m"

alias :q='exit'
alias :qa='exit'
alias ..='cd ..'
alias a='atls'
alias b='btop'
alias calrefresh='bash $DOT_FILES_DIR/utils/calendar_refresh.sh'
alias cdr='cd $(git rev-parse --show-toplevel)'
alias cl='clear'
alias clar='clear'
alias cpl='copilot'
alias crt='crumbs tui'
alias cts='commits'
alias dev='assume ai-dev && unset AWS_PROFILE'
alias d='just --justfile "$PROJECTS_DIR/dotfiles/just/docker" --choose'
alias dps='docker ps'
alias e='exit'
alias g='git'
alias gcb='git checkout -b'
alias gcd1='git clone --depth=1'
alias gf='git fetch'
alias gp='git pull'
alias gs='git status -sb'
alias icloud='cd $ICLOUD_DIR'
alias j='just'
alias jc='just --choose'
alias jp='cd $PROJECTS_DIR'
alias k='kubectl'
alias lc='fc -ln -1 | pbcopy'
alias lg='lazygit'
alias ls='ls -aG'
alias luamake=/Users/dht93/Soft/lua-language-server/3rd/luamake/luamake
alias lzd='lazydocker'
alias oc='opencode'
alias ommw='omm --config-path=~/.config/omm/omm-w.toml'
alias ommc='omm --db-path=.local/omm.db'
alias po='punchout'
alias prod='assume ai-prod && unset AWS_PROFILE'
alias sprint='jira sprint list --current -a $(jira me)'
alias t='ting p $?'
alias ta='tmux attach'
alias ticks='jira sprint list --current -q "sprint in openSprints() AND assignee = currentUser()"'
alias tx='tmuxinator'
alias v='nvim --cmd "let g:lsp=v:false"'
alias vv='nvim'
alias wl='hours -d "~/.local/share/hours/work.db" -t gruvbox-dark'

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# https://github.com/junegunn/fzf/wiki/Color-schemes
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:#cbccc6,hl:#707a8c
 --color=fg+:#5fff87,hl+:#ffcc66
 --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
 --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff
 --bind ctrl-a:select-all'

export JUST_SUPPRESS_DOTENV_LOAD_WARNING=1

export DELTA_PAGER='less -R' # so short diffs don't quit

# enter vim mode
bindkey -v

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

export NVM_DIR="$HOME/.nvm"
function loadnode() {
    source $NVM_DIR/nvm.sh  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

export EDITOR="nvim"
export VISUAL="nvim"
export GOPATH="$HOME/go"

# default command for fzf
# -i is to ignore case
# -H includes hidden files/directories in search
# since .git is a hidden directory,
# ~/.fdignore includes .git to exclude it from search
export FZF_DEFAULT_COMMAND='fd -ipH -t f'
export FZF_CTRL_T_COMMAND='fd -ipH -t f'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=208"
bindkey '`' autosuggest-accept

VIRTUAL_ENV_DISABLE_PROMPT=1

export BAT_CONFIG_PATH="$HOME/.config/bat/bat.conf"

# docker exec /bin/bash using fzf
function dex() {
    local selected_container
    selected_container=$(docker ps --format "table {{ .ID }}\t{{.Names}}\t{{.Status}}" --last=5 | fzf --height=6 --layout=reverse)

    if [ -n "$selected_container" ]; then
        echo "docker exec -it $(echo $selected_container | head -n1| awk '{print$1;}') /usr/bin/env sh"
        docker exec -it $(echo $selected_container | head -n1| awk '{print$1;}') /usr/bin/env sh
    fi
}

# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
}

# https://github.com/junegunn/fzf#custom-fuzzy-completion

_fzf_complete_doge() {
  _fzf_complete --multi --reverse --prompt="doge> " -- "$@" < <(
    echo very
    echo wow
    echo such
    echo doge
  )
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

# quickly cd to important directories
function jj(){
    local selected_dir
    local -a search_dirs

    search_dirs=("${(@s/:/)DIRS_TO_SEARCH}")
    selected_dir=$(fd . --max-depth=1 "${search_dirs[@]}" | fzf --height=10 --layout=reverse | xargs)

    if [ -n "$selected_dir" ]; then
        cd $selected_dir
    fi
}

function c() {
    if ! isgitrepo; then
        echo "not in a git repo"
        return
    fi

    local selected_directory
    local base_directory=$(git rev-parse --show-toplevel)
    if (($# == 1)); then
        selected_directory=$(fd --base-directory=$base_directory -H -t d $1 | fzf --height=12 --layout=reverse)
    else
        selected_directory=$(fd --base-directory=$base_directory -H -t d | fzf --height=12 --layout=reverse)
    fi

    if [ -n "$selected_directory" ]; then
        cd $(git rev-parse --show-toplevel)
        cd $selected_directory
    fi
}

function ww() {
    work_command=$(cat ~/projects/utils/work_commands.txt | grep '^[^#]' | fzf --height=15 --layout=reverse)
    if [ -n "$work_command" ]; then
        print -s $work_command
        eval $work_command
    fi
}

# https://github.com/jarun/nnn/wiki/Basic-use-cases#configure-cd-on-quit
function n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    VISUAL='vim' nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

export NNN_OPTS="H"
export BMM_EDITOR="vi"

# col -b   : removes ^H characters
# nvim -R  : Read-only mode
# nvim -M  : Resets the 'write' and 'modifiable' options, to disable file and buffer modifications.
# export MANPAGER="col -b | nvim -MR -c 'set syntax=man' - "
# https://github.com/sharkdp/bat?tab=readme-ov-file#man
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

autoload -U +X bashcompinit && bashcompinit

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

function _insert_drs() {
  local selection
  local -a search_dirs

  search_dirs=("${(@s/:/)DIRS_TO_SEARCH}")
  selection="$(fd . --max-depth=1 "${search_dirs[@]}" | fzf --height=10 --layout=reverse | xargs)"

  if [[ -n "$selection" ]]; then
    LBUFFER+="$selection"
  fi
  zle reset-prompt
  zle autosuggest-clear
}
zle -N _insert_drs
bindkey '^p' _insert_drs

export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^e' atuin-search
bindkey -s '^N' 'n\n'
bindkey -s '^f' 'j\n'
export HOURS_THEME=monokai-classic

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOPATH/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PROJECTS_DIR/utils/exe:$DOT_FILES_DIR/utils/exe:/opt/homebrew/bin:$PATH"
