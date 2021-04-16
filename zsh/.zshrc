source $HOME/.zsh_env_vars.sh
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
plugins=(zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

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

alias dcm='docker-compose'

# docker compose with dev config
alias dcmd='dcm -f docker-compose.dev.yml'
alias ls='ls -aG'

#alias ml='source activate ml'
alias cat='bat'


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
alias tx="tmuxinator"

alias cvim="nvim ~/.config/nvim/init.vim"

alias gs="git status"
alias ga="git add"
# alias gc="git commit"
alias gb="git branch"
# alias gco="git checkout"

alias opa="cat $HOME/Desktop/mas.txt | pbcopy"
#
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export EDITOR="nvim"


# Created by `userpath` on 2020-07-18 08:27:23
export PATH="$PATH:$HOME/.local/bin"

# default command for fzf
# -i is to ignore case
# -H includes hidden files/directories in search
# since .git is a hidden directory,
# ~/.fdignore includes .git to exclude it from search
export FZF_DEFAULT_COMMAND='fd -ipH -t f'
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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export WORKON_HOME=~/.virtualenvs
mkdir -p $WORKON_HOME
. ~/.pyenv/versions/3.8.5/bin/virtualenvwrapper.sh

alias wthr=$HOME/weather.sh
alias weather=$HOME/weather.sh

alias t="tmux"
alias tls="tmux ls"

alias e='exit'

alias theme='$DOT_FILES_DIR/set_theme.sh $($DOT_FILES_DIR/themes_list.sh | fzf)'

alias ff='cd $(echo $DOT_FILES_DIR\\n$NVIM_DIR\\n$PROJECTS_DIR | fzf)'

alias mks='mkdocs serve --dirtyreload'

alias cdw='cd ${WORKDIR}'

alias gcd1='git clone --depth=1'

# alias py='workon "$(workon|fzf)"'

export ICLOUD_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

alias ic2wiki='cp "$ICLOUD_DIR/export/$(ls $ICLOUD_DIR/export |fzf)" $(fd -t d -I assets '$WIKI_DIR' | fzf)'

alias opa="cat $HOME/opa.txt | pbcopy"

alias cl='clear'

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
  selected_directory=$(fd -t d | fzf --height=6 --layout=reverse)

  if [ -n "$selected_directory" ]; then
    # echo "cd $selected_directory"
    cd $selected_directory
  fi
}

# ls subdirectory using fzf
function lss() {
  local selected_directory
  selected_directory=$(fd -t d | fzf --height=6 --layout=reverse)

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

# git checkout using fzf
function gco() {
  local selected_branch
  selected_branch=$(git branch | fzf --height=6 --layout=reverse | xargs)

  if [ -n "$selected_branch" ]; then
      git checkout $selected_branch
  fi
}

# git log for all branches
alias gl='git log --all --color --graph --pretty=format:'"'"'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"'"' --abbrev-commit'

# git log for current branch
alias glb='git log --color --graph --pretty=format:'"'"'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"'"' --abbrev-commit staging..$(git branch --show-current)'

# git log for a specific branch
function glbo() {
  local selected_branch
  selected_branch=$(git branch | fzf --height=6 --layout=reverse | xargs)

  if [ -n "$selected_branch" ]; then
      git log --color --graph --pretty=format:'''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset''' --abbrev-commit staging..$selected_branch
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
  selected_dir=$(echo_array $IMPORTANT_DIRS | fzf --height=6 --layout=reverse | xargs)

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
