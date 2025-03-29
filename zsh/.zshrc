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

alias luamake=/Users/dht93/Soft/lua-language-server/3rd/luamake/luamake
alias tf='terraform'
alias jr='jira'
alias ta='tmux attach'
alias tm='python -c "import time;print(int(time.time()))"'
alias dps='docker ps'
alias :Qa='exit'
alias :qa='exit'
alias :q='exit'
alias b='buku --np'
alias cdr='cd $(git rev-parse --show-toplevel)'
alias week='hours report week -ia'
alias ccc='commits -ignore-pattern="^\[NO-CI\]"'
alias gsdd='git-split-diffs --color | less -RFX'
alias gsl='git stash list'
alias gp='git pull'
alias gf='git fetch'
alias g='git'
alias ic2wiki='cp "$ICLOUD_DIR/export/$(ls $ICLOUD_DIR/export |fzf)" $(fd -t d -I assets '$WIKI_DIR' | fzf)'
alias wu='cat $BRAIN_URLS_WORK'
alias pu='cat $BRAIN_URLS_PERS'
alias owu='cat $BRAIN_URLS_WORK | oo'
alias opu='cat $BRAIN_URLS_PERS | oo'
alias swu='opentabs > $BRAIN_URLS_WORK'
alias spu='opentabs > $BRAIN_URLS_PERS'
alias oo='$DOT_FILES_DIR/utils/open_multi.sh'
alias icloud='cd $ICLOUD_DIR'
alias gcd1='git clone --depth=1'
alias cdw='cd ${WORKDIR}'
alias mks='mkdocs serve --dirtyreload'
alias theme='$DOT_FILES_DIR/set_theme.sh $($DOT_FILES_DIR/themes_list.sh | fzf)'
alias eee='exit'
alias ee='exit'
alias e='exit'
alias tls="tmux ls"
alias weather=$HOME/weather.sh
alias wthr=$HOME/weather.sh
alias colorscheme=~/colorscheme.sh 
alias LT="it2prof gruvbox-morhetz-light"
alias DT="it2prof gruvbox-morhetz-dark"
alias po='punchout'
alias chash="git show --oneline | head -1 | awk '{ print \$1 }' | pbcopy"
alias sprint='jira sprint list --current -a $(jira me)'
alias gcb='git checkout -b'
alias gcd1="git clone --depth=1"
alias gb="git branch --all | fzf | sed 's/remotes\///' | xargs | pbcopy"
alias ga="git add"
alias gs="git status -sb"
alias cvim="nvim ~/.config/nvim/init.vim"
alias tx="tmuxinator"
alias v="nvim"
alias vnolsp='nvim --cmd "let g:lsp=v:false"'
alias calrefresh='bash $DOT_FILES_DIR/utils/calendar_refresh.sh'
alias ..="cd .."
alias mm='mult -i -s'
alias yd='yarn develop'
alias jpn='jupyter notebook'
alias jp="cd $PROJECTS_DIR"
alias j='just'
alias ls='ls -aG'
alias tv='tnew ~/.config/nvim'

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# https://github.com/junegunn/fzf/wiki/Color-schemes
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:#cbccc6,hl:#707a8c
 --color=fg+:#5fff87,hl+:#ffcc66
 --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
 --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff
 --bind ctrl-a:select-all'
# highlighted line green, with entered word yellow

# alias j='just --justfile ~/.global.justfile --working-directory .'
export JUST_SUPPRESS_DOTENV_LOAD_WARNING=1

export PIP_REQUIRE_VIRTUALENV=false

export DELTA_PAGER='less -R' # so short diffs don't quit

#alias ml='source activate ml'

# . $HOME/Soft/z/z.sh

# enter vim mode
bindkey -v

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
function loadnode() {
    source $NVM_DIR/nvm.sh  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}


function crl(){
    response=$(curl -s $1)
    echo $response | jq
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ZSH AUTOCOMPLETIONS
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=208"
# `completes suggestions
bindkey '`' autosuggest-accept

VIRTUAL_ENV_DISABLE_PROMPT=1

# alias py='workon "$(workon|fzf)"'

export BAT_CONFIG_PATH="$HOME/.config/bat/bat.conf"

# alias c='clear'
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

function down(){
    selected_file=$(ls -a ~/Downloads | fzf --height=15 --layout=reverse )
    if [ -n "$selected_file" ]; then
        open ~/Downloads/$selected_file
    fi
}

# cd to project root in a git repo
# https://twitter.com/fatih/status/1381555413083168769

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
        echo "docker exec -it $(echo $selected_container | head -n1| awk '{print$1;}') /usr/bin/env sh"
        docker exec -it $(echo $selected_container | head -n1| awk '{print$1;}') /usr/bin/env sh
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
    selected_branch=$(git branch | fzf --height=12 --layout=reverse | xargs)

    if [ -n "$selected_branch" ]; then
        git checkout $selected_branch
    fi
}

# inspiration from:
# https://waylonwalker.com/tmux-fzf-session-jump/
# https://qmacro.org/autodidactics/2021/08/06/tmux-output-formatting/
function tt(){
    tmux list-windows -a -F '#S:#W' | fzf --height=10 --layout=reverse | xargs tmux switch -t
}

# alias n='nnn'
# alias ls='nnn -e'

source $DOT_FILES_DIR/utils/open_encoded_url.sh

function nvimclose(){
    tmuxpanes "nvim" | $DOT_FILES_DIR/tmux/tmuxsendcmd ':qa!'
}

function nvimdark(){
    tmuxpanes "nvim" | $DOT_FILES_DIR/tmux/tmuxsendcmd ':set background=dark'
}

function nvimlight(){
    tmuxpanes "nvim" | $DOT_FILES_DIR/tmux/tmuxsendcmd ':set background=light'
}

function sbtclose(){
    tmuxpanes "java" | $DOT_FILES_DIR/tmux/tmuxsendcmd 'exit'
}

function bashclose(){
    tmuxpanes "bash" | $DOT_FILES_DIR/tmux/tmuxsendcmd 'C-c'
}

function get_ip(){
    ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
}

# open urls from txt file
function openurls() {
    if [ $# -ne 1 ]
    then
        echo "Usage: openurls <FILE_PATH>"
        return
    fi
    local selected_urls
    selected_urls=$(cat $1 | fzf --layout=reverse  --multi --prompt="which ones?")

    if [ -n "$selected_urls" ]; then
        echo $selected_urls | xargs open
    fi
}

# git log for a branch filtered by author(s)
function glba() {
    local selected_authors
    selected_authors=$(git shortlog -s | cut -c8- | fzf --height=10 --layout=reverse --multi --prompt="Author?" | /usr/bin/python3 -c "import fileinput;lines=[f'--author=\'{line.strip()}\'' for line in fileinput.input()];print(' '.join(lines))")
    # selected_authors=$(git log --pretty="%ae" | sort | uniq | fzf --height=10 --layout=reverse --multi --prompt="Author?" | awk '{print "--author "$0""}' | xargs )

    if [ -n "$selected_authors" ]; then
        print -s "glb $selected_authors"
        eval "glb $selected_authors"
        # git log --color --graph --pretty=format:'"'"'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"'"' --abbrev-commit --since='1 month ago' $selected_authors $(git branch --show-current) 
        # echo git log --color --graph --pretty=format:'"'"'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"'"' --abbrev-commit --since="1 month ago" $selected_authors $(git branch --show-current) 
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

# git checkout branch with prefix
function gcbw() {
    is_in_git_repo || return
    echo "branch name?"
    read branch_name
    if [ -n "$branch_name" ]; then
        local branch_prefix="WEBENG-"
        local branch_name_formatted=$(echo $branch_name | tr '[:upper:]' '[:lower:]' | sed "s/ /-/g" | sed "s/_/-/g")
        print -s "git checkout -b $branch_prefix$branch_name_formatted"
        git checkout -b $branch_prefix$branch_name_formatted
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

# https://github.com/junegunn/fzf#custom-fuzzy-completion

_fzf_complete_doge() {
  _fzf_complete --multi --reverse --prompt="doge> " -- "$@" < <(
    echo very
    echo wow
    echo such
    echo doge
  )
}

# create a PR from HEAD with the commit message as the PR title
prr() {
    is_in_git_repo || return
    local base_branch
    local label
    base_branches=$(echo "develop\nmaster"| fzf --height=6 --layout=reverse --multi --prompt="base branch?" | xargs )
    local commit_message=$(git log --format=%B -n 1 HEAD | head -n 1)
    # local current_branch=$(git rev-parse --abbrev-ref HEAD | xargs)
    if [ -n "$base_branches" ]; then
        for base_branch in $(echo $base_branches); do
        labels=$(cat ~/.github_labels | fzf --height=10 --layout=reverse --multi --prompt="labels for $base_branch" | sed -e 's/\(.*\)/--label \\""\1"\\"/g' | xargs )
        reviewers=$(cat ~/.github_handles | fzf --height=10 --layout=reverse --multi --prompt="reviewers for $base_branch" | paste -sd "," -)
        git log -n 1 HEAD | tail -n 5 | pbcopy
        if [ -n "$reviewers" ]; then
            print -s gh pr create --title \""$commit_message"\" --base "$base_branch" $labels --reviewer \""$reviewers"\"
            # gh pr create --title "$commit_message" --base "$base_branch" $labels --reviewer \""$reviewers"\"
        else
            print -s gh pr create --title \""$commit_message"\" --base "$base_branch" $labels
            # gh pr create --title "$commit_message" --base "$base_branch" $labels
        fi
        done
    fi
}


prl() {
    is_in_git_repo || return
    local author=$(cat ~/.github_handles | fzf --height=10 --layout=reverse --multi --prompt="author?")
    if [ -n "$author" ]; then
        print -s "gh pr list --author $author --state=closed --limit=300 | fzf --height=15 --layout=reverse | awk -F  ' ' '// {print \$1}' | xargs"
        local pr_chosen=$(gh pr list --author $author --state=closed --limit=300 | fzf --height=20 --layout=reverse | awk -F  ' ' '// {print $1}' | xargs)
        echo $pr_chosen
        if [ -n "$pr_chosen" ]; then
            gh pr view $pr_chosen --web
        fi
    fi
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
    docker_command=$(cat $PROJECTS_DIR/dotfiles/utils/docker_commands.txt | fzf --height=10 --layout=reverse)
    if [ -n "$docker_command" ]; then
        print -s $docker_command
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
    selected_dir=$(fd . --max-depth=1 $(echo_array $DIRS_TO_SEARCH) | fzf --height=10 --layout=reverse | xargs)

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

# work commands
function ww() {
    work_command=$(cat ~/projects/utils/work_commands.txt | grep '^[^#]' | fzf --height=15 --layout=reverse)
    if [ -n "$work_command" ]; then
        print -s $work_command
        eval $work_command
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
        echo -e "${GREEN}docker compose -f $(ls | grep docker-compose | xargs) "$@"${NOCOLOR}"
        docker compose -f $(ls | grep docker-compose | xargs) "$@"
    else
        local selected_docker_compose_files
        selected_docker_compose_files=$(ls | grep docker-compose | fzf --height=10 --layout=reverse --multi | xargs)

        if [ -n "$selected_docker_compose_files" ]; then
            echo -e "${GREEN}docker compose $(echo $selected_docker_compose_files | sed 's/[^ ]* */-f &/g') "$@"${NOCOLOR}"
            print -s "docker compose $(echo $selected_docker_compose_files | sed 's/[^ ]* */-f &/g') "$@""
            docker compose $(echo $selected_docker_compose_files | sed 's/[^ ]* */-f &/g') "$@"
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

function prdiff(){
    local selected_pr_number
    selected_pr_number=$(gh pr list | fzf --height=10 --layout=reverse | awk -F  " " '// {print $1}')
    if [ -n "$selected_pr_number" ]; then
        gh pr diff $selected_pr_number | git-split-diffs --color | less -RFX
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


function gitinit() {
    is_in_git_repo || git init
}


function jw(){
    local selected_entry
    selected_entry=$(fd . --max-depth=1 $WORK_DIR | fzf --height=8 --layout=reverse)
    if [ -n "$selected_entry" ]; then
        echo "cd $selected_entry"
        cd $selected_entry
    fi
}

function jd(){
    local selected_entry
    selected_entry=$(fd . --max-depth=1 $PROJECTS_DIR $WORK_DIR | fzf --height=8 --layout=reverse)
    if [ -n "$selected_entry" ]; then
        echo "cd $selected_entry"
        cd $selected_entry
    fi
}



function txd(){
    local selected_entry
    selected_entry=$(fd . --max-depth=1 $PROJECTS_DIR $WORK_DIR| fzf --height=8 --layout=reverse)
    if [ -n "$selected_entry" ]; then
        local session_name=$(echo $selected_entry | rev | cut -d'/' -f 1 | rev)
        tmux new-session -s $session_name "cd $selected_entry && nvim ."
    fi
}

function work(){
     osascript -e 'tell application "Keyboard Maestro Engine"' \
         -e 'do script "open: setup_work"' \
        -e 'end tell'
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

function loadpy() {
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init --path)"
    fi
    . ~/.pyenv/versions/3.10.4/bin/virtualenvwrapper.sh
    workon general
}


function books(){
    local selected_book
    selected_book=$(fd -t=f -e=pdf --max-depth=1 --base-directory=$BOOKS_DIR | fzf --height=8 --layout=reverse)
    if [ -n "$selected_book" ]; then
        open $BOOKS_DIR/$selected_book
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


# export PATH=/Users/dht93/.pyenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/dht93/.rvm/bin:/Users/dht93/.local/bin:/opt/homebrew/bin
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/dht93/.local/bin:$GOPATH/bin:$HOME/.cargo/bin:/opt/homebrew/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init --path)"
# fi

export WORKON_HOME=~/.virtualenvs

mkdir -p $WORKON_HOME
#
# . ~/.pyenv/versions/3.10.4/bin/virtualenvwrapper.sh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="$PATH:/Users/dhruvthakur/.spicetify:$DOT_FILES_DIR/utils/exe:$PROJECTS_DIR/utils/exe:$PROJECTS_DIR/utils/compexe:$HOME/cbins"
# workon general
# eval "$(starship init zsh)"

autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /opt/homebrew/bin/terraform terraform

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# . "$HOME/.grit/bin/env"

export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^e' atuin-search
bindkey -s '^N' 'n\n'
export HOURS_THEME=monokai
