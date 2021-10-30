source $HOME/.zsh_env_vars
source $HOME/.env_vars_secret.sh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# fpath+=$HOME/.zsh/pure
# autoload -U promptinit; promptinit
# prompt pure

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

black=$'\033[30m'
red=$'\033[31m'
GREEN=$'\033[32m'
yellow=$'\033[33m'
blue=$'\033[34m'
magenta=$'\033[35m'
cyan=$'\033[36m'
white=$'\033[37m'
NOCOLOR="\033[0m"

# https://github.com/junegunn/fzf/wiki/Color-schemes
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:#cbccc6,hl:#707a8c
 --color=fg+:#5fff87,hl+:#ffcc66
 --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
 --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff'
# highlighted line green, with entered word yellow

alias ls='ls -aG'
alias j='just --justfile ~/.global.justfile --working-directory .'
export JUST_SUPPRESS_DOTENV_LOAD_WARNING=1

export PIP_REQUIRE_VIRTUALENV=true

#alias ml='source activate ml'
# alias cat='bat'


alias jpn='jupyter notebook'

. $HOME/Soft/z/z.sh
alias yd='yarn develop'

# enter vim mode
bindkey -v

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias ..="cd .."


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias v="nvim"
alias vim="nvim"
alias tx="tmuxinator"

alias cvim="nvim ~/.config/nvim/init.vim"

alias gs="git status -sb"
alias ga="git add"
# alias gc="git commit"
alias gb="git branch"
alias gcd1="git clone --depth=1"
# alias gco="git checkout"

# alias t='python $HOME/Soft/t/t.py --task-dir ~/tasks --list tasks'
# function t(){
#     python $HOME/Soft/t/t.py --task-dir ~/tasks --list tasks "$@"
# }
function t(){
    last_num=$(tail -n 1 $POMODORO_TASK_LIST_FILE_LOC | cut -d':' -f1)
    new_num=`expr $last_num + 1`
    echo "$new_num: $@" >> $POMODORO_TASK_LIST_FILE_LOC
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export EDITOR="nvim"
export VISUAL="nvim"

export GOPATH="$HOME/go"

# Created by `userpath` on 2020-07-18 08:27:23
export PATH="$PATH:$HOME/.local/bin"

# default command for fzf
# -i is to ignore case
# -H includes hidden files/directories in search
# since .git is a hidden directory,
# ~/.fdignore includes .git to exclude it from search
export FZF_DEFAULT_COMMAND='fd -ipH -t f'
export FZF_CTRL_T_COMMAND='fd -ipH -t f'
# export FZF_DEFAULT_COMMAND='rg'

# Change iterm2 profile. Usage it2prof ProfileName (case sensitive)
it2prof() { echo -e "\033]50;SetProfile=$1\a" }

alias DT="it2prof gruvbox-morhetz-dark"
alias LT="it2prof gruvbox-morhetz-light"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ZSH AUTOCOMPLETIONS
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=208"
# `completes suggestions
bindkey '`' autosuggest-accept

alias colorscheme=~/colorscheme.sh 

VIRTUAL_ENV_DISABLE_PROMPT=1

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

eval "$(pyenv init -)"
export WORKON_HOME=~/.virtualenvs
mkdir -p $WORKON_HOME

# . ~/.pyenv/versions/3.9.4/bin/virtualenvwrapper.sh
source $HOMEBREW_DIR/virtualenvwrapper.sh

alias wthr=$HOME/weather.sh
alias weather=$HOME/weather.sh

alias tls="tmux ls"

alias e='exit'

alias theme='$DOT_FILES_DIR/set_theme.sh $($DOT_FILES_DIR/themes_list.sh | fzf)'

alias mks='mkdocs serve --dirtyreload'

alias cdw='cd ${WORKDIR}'

alias gcd1='git clone --depth=1'

# alias py='workon "$(workon|fzf)"'

alias icloud='cd $ICLOUD_DIR'

export BAT_CONFIG_PATH="$HOME/.config/bat/bat.conf"

alias ic2wiki='cp "$ICLOUD_DIR/export/$(ls $ICLOUD_DIR/export |fzf)" $(fd -t d -I assets '$WIKI_DIR' | fzf)'

alias cl='clear'

alias g='git'
alias gf='git fetch'

# select python environment using fzf
# https://seb.jambor.dev/posts/improving-shell-workflows-with-fzf/
function py() {
    local selected_env
    selected_env=$(workon | fzf --height=10 --layout=reverse)

    if [ -n "$selected_env" ]; then
        workon $selected_env
        echo "activated $selected_env"
    fi
}

# delete git branches using fzf
function delete-branches() {
    git branch |
        grep --invert-match '\*' |
        cut -c 3- |
        fzf --multi --preview="git log {}" |
        xargs git branch --delete --force
    }

# echo file in ~/Downloads using fzf
function dl() {
    local selected_file
    selected_file=$(ls ~/Downloads | fzf --height=10 --layout=reverse)

    if [ -n "$selected_file" ]; then
        echo ~/Downloads/$selected_file
    fi
}

# cd to project root in a git repo
# https://twitter.com/fatih/status/1381555413083168769
alias cdr='cd $(git rev-parse --show-toplevel)'

# cd to subdirectory using fzf
function c() {
    local selected_directory
    if (($# == 1))
    then
        selected_directory=$(fd -H -t d $1 | fzf --height=6 --layout=reverse)
    else
        selected_directory=$(fd -H -t d | fzf --height=6 --layout=reverse)
    fi

    if [ -n "$selected_directory" ]; then
        # echo "cd $selected_directory"
        cd $selected_directory
    fi
}

# ls subdirectory using fzf
function lss() {
    local selected_directory
    selected_directory=$(fd -H -t d | fzf --height=6 --layout=reverse)

    if [ -n "$selected_directory" ]; then
        # echo "ls -aG $selected_directory"
        command ls -aG $selected_directory
    fi
}

# docker exec /bin/bash using fzf
function dex() {
    local selected_container
    selected_container=$(docker ps --format "table {{ .ID }}\t{{.Names}}\t{{.Status}}" --last=5 | fzf --height=6 --layout=reverse)

    if [ -n "$selected_container" ]; then
        echo "docker exec -it $(echo $selected_container | head -n1| awk '{print$1;}') /bin/bash"
        docker exec -it $(echo $selected_container | head -n1| awk '{print$1;}') /bin/bash
    fi
}

# docker stop
function ds() {
    local selected_container
    selected_container=$(docker ps --format "table {{ .ID }}\t{{.Names}}\t{{.Status}}" --last=5 | fzf --height=6 --layout=reverse)

    if [ -n "$selected_container" ]; then
        echo "docker stop $(echo $selected_container | head -n1| awk '{print$1;}')"
        docker stop $(echo $selected_container | head -n1| awk '{print$1;}')
    fi
}

# git checkout using fzf
function gco() {
    local selected_branch
    selected_branch=$(git branch | fzf --height=6 --layout=reverse | xargs)

    if [ -n "$selected_branch" ]; then
        git checkout $selected_branch
    fi
}

# git log for all branches
alias gl='git log --all --color --graph --pretty=format:'"'"'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"'"' --abbrev-commit --since="1 month ago"'

# git log for current branch
alias glb='git log --color --graph --pretty=format:'"'"'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"'"' --abbrev-commit $(git branch --show-current) --since="1 month ago"'

alias b='buku --np'

alias :q='exit'
alias :qa='exit'
alias :Qa='exit'

alias dps='docker ps'
alias chime='python -c "import chime;chime.theme(\"mario\");chime.success()"'
alias chimeerror='python -c "import chime;chime.theme(\"mario\");chime.error()"'

alias tt='python -c "import time;print(int(time.time()))"'


alias jira='$JIRA_PYTHON $JIRA_MANAGER_DIR/main.py'


# alias n='nnn'
# alias ls='nnn -e'

function get_ip(){
    ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
}


function bback(){
    local backup_file="$BUKU_BACKUP_DIR/backup-$(date '+%Y-%m-%d').db"
    echo -e "backing up to ${GREEN}$backup_file...${NOCOLOR}"
    buku --np -e $backup_file
}

# git log for a specific branch
function glbo() {
    local selected_branch
    selected_branch=$(git branch | fzf --height=6 --layout=reverse | xargs)

    if [ -n "$selected_branch" ]; then
        git log --color --graph --pretty=format:'''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset''' --abbrev-commit $selected_branch
    fi
}

# git log commit difference
function glbd_() {
    local source_branch
    source_branch=$(git branch --all | fzf --height=6 --layout=reverse | xargs | sed 's|* ||')
    if [ -n "$source_branch" ]; then
        local target_branch
        target_branch=$(git branch --all | fzf --height=6 --layout=reverse | xargs | sed 's|* ||')
        if [ -n "$target_branch" ]; then
            echo -e "${GREEN}$source_branch..$target_branch${NOCOLOR}"
            echo -e "${GREEN}Commits in $target_branch that are not in $source_branch 👇${NOCOLOR}"
            git log --color --graph --pretty=format:'''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset''' --abbrev-commit --date=relative $source_branch..$target_branch
        fi
    fi
}

# git delete branch locally and on remote
function gdb() {
    local branches
    branches=$(git branch | fzf --height=10 --layout=reverse | xargs | sed 's|* ||')
    if [ -n "$branches" ]; then
        echo -e "About to delete ${GREEN}$branches${NOCOLOR}"
        local confirmation
        confirmation=$(echo "yes\nno" | fzf --height=2 --layout=reverse --prompt="You sure?" | xargs)
        if [ "$confirmation" = "yes" ]; then
            git branch -d "$branches"
            git branch --delete --remotes "origin/$branches"
        fi
    fi
}

# git log commit difference
function glbd() {
    local target_branch
    target_branch=$(git branch --all | fzf --height=6 --layout=reverse --prompt="commits that are in: " | xargs | sed 's|* ||')
    if [ -n "$target_branch" ]; then
        local source_branch
        source_branch=$(git branch --all | fzf --height=6 --layout=reverse --prompt="but not in: " | xargs | sed 's|* ||')
        if [ -n "$source_branch" ]; then
            echo -e "${GREEN}Commits that are in $target_branch, but not in $source_branch 👇${NOCOLOR}"
            git log --color --graph --pretty=format:'''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset''' --abbrev-commit --date=relative $source_branch..$target_branch
        fi
    fi
}

# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
}

_gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
  cut -c4- | sed 's/.* -> //'
}

_gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

_gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}"
}

_gs() {
  is_in_git_repo || return
  git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b h s
unset -f bind-git-helper

# docker helpers
function d() {
    docker_command=$(cat ~/docker_commands.txt | fzf --height=6 --layout=reverse)
    if [ -n "$docker_command" ]; then
        eval $docker_command
    fi
}

# utility function
function echo_array(){
    arr=("$@")
    for el in $arr
    do
        echo "$el"
    done
}

# quickly cd to important directories
function jj(){
    local selected_dir
    selected_dir=$(echo_array $IMPORTANT_DIRS | fzf --height=10 --layout=reverse | xargs)

    if [ -n "$selected_dir" ]; then
        cd $selected_dir
    fi
}

# quickly cd to important directories in $PROJECTS_DIR
function pp(){
    local selected_dir
    selected_dir=$(command ls $PROJECTS_DIR | fzf --height=15 --layout=reverse | xargs)

    if [ -n "$selected_dir" ]; then
        cd $PROJECTS_DIR/$selected_dir
    fi
}

# quickly change vim colors with fzf
function vc(){
    local selected_colorscheme
    local selected_background
    selected_colorscheme=$(echo_array $NVIM_COLORSCHEMES | fzf --height=5 --layout=reverse | xargs)
    selected_background=$(echo_array $NVIM_BACKGROUNDS | fzf --height=5 --layout=reverse | xargs)

    if [ -n "$selected_colorscheme" ] && [ -n "$selected_background" ]; then
        echo $selected_colorscheme
        echo $selected_background
        python $HOME/utils/change_vim_colors.py $selected_colorscheme $selected_background
    fi
}

# quickly run docker-compose exec
function dce(){
    local selected_service
    selected_service=$(docker-compose ps --services | fzf --height=5 --layout=reverse | xargs)

    if [ -n "$selected_service" ]; then
        read command_to_run
        if [ -n "$command_to_run" ]; then
            echo docker-compose exec $selected_service bash -c $command_to_run
            docker-compose exec $selected_service bash -c $command_to_run
        fi
    fi
}

function ff() {
    local selected_file
    selected_file=$(fd -H -t f | fzf --height=6 --layout=reverse)

    if [ -n "$selected_file" ]; then
        echo $selected_file
    fi
}

function ddd_old() {
    local selected_directory
    selected_directory=$(fd -H -t d | fzf --height=6 --layout=reverse)

    if [ -n "$selected_directory" ]; then
        echo $selected_directory
    fi
}

function _number_of_docker_compose_files(){
    echo $(ls | grep docker-compose | wc -l)
}

function dcm() {
    if (( $(_number_of_docker_compose_files) <= 1 )); then
        echo -e "${GREEN}docker-compose -f $(ls | grep docker-compose | xargs) "$@"${NOCOLOR}"
        docker-compose -f $(ls | grep docker-compose | xargs) "$@"
    else
        local selected_docker_compose_files
        selected_docker_compose_files=$(ls | grep docker-compose | fzf --height=6 --layout=reverse --multi | xargs)

        if [ -n "$selected_docker_compose_files" ]; then
            echo -e "${GREEN}docker-compose $(echo $selected_docker_compose_files | sed 's/[^ ]* */-f &/g') "$@"${NOCOLOR}"
            docker-compose $(echo $selected_docker_compose_files | sed 's/[^ ]* */-f &/g') "$@"
        fi
    fi
}

function dcme(){
    local selected_docker_compose_file
    if (( $(_number_of_docker_compose_files) <= 1 )); then
        selected_docker_compose_file=$(ls | grep docker-compose | xargs)
    else
        selected_docker_compose_file=$(ls | grep docker-compose | fzf --height=6 --layout=reverse)
    fi
    if [ -n "$selected_docker_compose_file" ]; then
        selected_service=$(docker-compose -f $selected_docker_compose_file ps --services | fzf --height=5 --layout=reverse | xargs)
        if [ -n "$selected_service" ]; then
            echo docker-compose -f $selected_docker_compose_file exec $selected_service bash -c \'"$@"\'
            docker-compose -f $selected_docker_compose_file exec $selected_service bash -c "$@"
        fi
    fi
}

function lzd() {
    if (( $(_number_of_docker_compose_files) <= 1 )); then
        lazydocker
    else
        local selected_docker_compose_file
        selected_docker_compose_file=$(fd --max-depth=1 -t f docker-compose | fzf --height=6 --layout=reverse)

        if [ -n "$selected_docker_compose_file" ]; then
            lazydocker -f $selected_docker_compose_file
        fi
    fi
}

function kk(){
    local selected_entry
    selected_entry=$( cat ~/clipboard.txt | fzf --height=6 --layout=reverse --preview 'echo {}| cut -d"|" -f3')

    if [ -n "$selected_entry" ]; then
        echo $selected_entry | cut -d'|' -f2 | xargs | pbcopy
    fi
}

function ws(){
    # wiki search
    local selected_entry
 selected_entry=$(rg --smart-case --type=md $1 $WIKI_DIR/docs | sed -e "s|$WIKI_DIR/docs/||" | sed -e "s|:fontawesome-.*: ||" | fzf --height=10 --layout=reverse)
    if [ -n "$selected_entry" ]; then
        local stripped
        stripped=$(echo $selected_entry | cut -d'.' -f1 | sed -e "s/\/index//" |xargs)
        open "http://127.0.0.1:8000/$stripped/"
    fi
}

function wf(){
    # wiki file
    local selected_entry
    if (($# == 1))
    then
         selected_entry=$(fd -p -t f --base-directory=$WIKI_DIR/docs $1 | fzf --height=10 --layout=reverse)
    else
         selected_entry=$(fd -p -t f --base-directory=$WIKI_DIR/docs | fzf --height=10 --layout=reverse)
    fi
    if [ -n "$selected_entry" ]; then
        local stripped
        stripped=$(echo $selected_entry | cut -d'.' -f1 | sed -e "s/\/index//" | xargs)
        open "http://127.0.0.1:8000/$stripped/"
    fi
}


function wws(){
    # work wiki search
    local selected_entry
 selected_entry=$(rg --smart-case $1 $WORK_WIKI_DIR/docs | sed -e "s|$WORK_WIKI_DIR/docs/||" | fzf --height=10 --layout=reverse)
    if [ -n "$selected_entry" ]; then
        local stripped
        stripped=$(echo $selected_entry | cut -d'.' -f1 | sed -e "s/\/index//" |xargs)
        open "http://127.0.0.1:8001/$stripped/"
    fi
}

function wwf(){
    # work wiki file
    local selected_entry
    if (($# == 1))
    then
         selected_entry=$(fd -p -t f --base-directory=$WORK_WIKI_DIR/docs $1 | fzf --height=10 --layout=reverse)
    else
         selected_entry=$(fd -p -t f --base-directory=$WORK_WIKI_DIR/docs | fzf --height=10 --layout=reverse)
    fi
    if [ -n "$selected_entry" ]; then
        local stripped
        stripped=$(echo $selected_entry | cut -d'.' -f1 | sed -e "s/\/index//" | xargs)
        open "http://127.0.0.1:8001/$stripped/"
    fi
}


function awscf(){
    # aws CF user guide search
    local selected_entry
 selected_entry=$(cat $ALFRED_DIR/aws/cloudformation_user_guide/aws_cloudformation_list.txt | fzf --height=8 --layout=reverse)
    if [ -n "$selected_entry" ]; then
        open "https://github.com/awsdocs/aws-cloudformation-user-guide/blob/main/doc_source/$selected_entry"
    fi
}


function gsd(){
    # git split diff helper
    local selected_from
 selected_from=$(git branch --all | fzf --height=8 --layout=reverse | xargs)
    if [ -n "$selected_from" ]; then
        local selected_to
        selected_to=$(git branch --all | fzf --height=8 --layout=reverse | xargs)
        if [ -n "$selected_from" ]; then
            # git diff $selected_from..$selected_to | git-split-diffs --color | less -RFX
            git diff $selected_from..$selected_to
        fi
    fi
}

function cdks(){
    # aws cdk search
    local selected_entry
 selected_entry=$(cat $AWS_HELPERS_DIR/cdk/api_reference/lists/cdk_api_reference.txt | fzf --height=8 --layout=reverse)
    if [ -n "$selected_entry" ]; then
        local url
        url=$(echo $selected_entry | cut -d',' -f2 | xargs)
        open "https://docs.aws.amazon.com$url"
    fi
}

function cdkps(){
    # aws cdk python library search
    local selected_entry
 selected_entry=$(cat $AWS_HELPERS_DIR/cdk/api_reference/lists/cdk_py_api_reference.txt | fzf --height=8 --layout=reverse)
    if [ -n "$selected_entry" ]; then
        local url
        url=$(echo $selected_entry | cut -d',' -f2 | xargs)
        open "https://docs.aws.amazon.com/cdk/api/latest/python/$url"
    fi
}


function lc(){
    # run local commands
    if [ -f local_commands.txt ]; then
        echo "exists"
        local selected_entry
     selected_entry=$(cat local_commands.txt | fzf --height=8 --layout=reverse)
        if [ -n "$selected_entry" ]; then
            echo "$selected_entry"
            eval "$selected_entry"
        fi
    fi
}


function txw(){
    # open tmuxinator in a specific work directory
    local selected_entry
    local selected_py_env
    selected_entry=$(fd . --max-depth=1 $PROJECTS_DIR $WORK_DIR| fzf --height=8 --layout=reverse --header="project?")
    if [ -n "$selected_entry" ]; then
        echo "export CHOSEN_WORK_DIR=$selected_entry" > ~/chosen_work_dir
        selected_py_env=$(workon | fzf --height=8 --layout=reverse --header="python?")
        if [ -n "$selected_py_env" ]; then
            echo "export CHOSEN_PYENV=$selected_py_env" >> ~/chosen_work_dir
            local num_sessions=$(tmux ls | grep work | wc -l | xargs)
            local new_session_num=`expr $num_sessions + 1`
            echo "tmuxinator work-$new_session_num $@"
            tmuxinator "work-$new_session_num" "$@"
        fi
    fi
}


function jw(){
    # open tmuxinator in a specific work directory
    local selected_entry
    selected_entry=$(fd . --max-depth=1 $WORK_DIR | fzf --height=8 --layout=reverse)
    if [ -n "$selected_entry" ]; then
        echo "cd $selected_entry"
        cd $selected_entry
    fi
}

function jd(){
    # open tmuxinator in a specific projects directory
    local selected_entry
    selected_entry=$(fd . --max-depth=1 $PROJECTS_DIR $WORK_DIR | fzf --height=8 --layout=reverse)
    if [ -n "$selected_entry" ]; then
        echo "cd $selected_entry"
        cd $selected_entry
    fi
}



function txd(){
    # open tmuxinator in a specific directory
    local selected_entry
    selected_entry=$(fd . --max-depth=1 $PROJECTS_DIR $WORK_DIR| fzf --height=8 --layout=reverse)
    if [ -n "$selected_entry" ]; then
        local session_name=$(echo $selected_entry | rev | cut -d'/' -f 1 | rev)
        tmux new-session -s $session_name "cd $selected_entry && nvim ."
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

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}


function books(){
    local selected_book
    selected_book=$(fd -t=f -e=pdf --max-depth=1 --base-directory=$BOOKS_DIR | fzf --height=8 --layout=reverse)
    if [ -n "$selected_book" ]; then
        open $BOOKS_DIR/$selected_book
    fi
}

export NNN_OPTS="H"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/dht93/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/dht93/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/dht93/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/dht93/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias luamake=/Users/dht93/Soft/lua-language-server/3rd/luamake/luamake
