export PROJECTS_DIR="$HOME/projects"
export WIKI_DIR="$HOME/projects/knowledge"
export CONFIG_DIR="$HOME/.config"
export GENERAL_PYTHON_ENV_NAME="general"

function txw(){
    # open tmuxinator in a specific work directory
    local selected_entry
    local selected_py_env

    local project_type
    project_type=$(echo "scala\npy" | fzf --height=8 --layout=reverse --header="type?")

    if [ -n "$project_type" ]; then
        if [[ "$project_type" == "py" ]]; then
            selected_py_env=$(fd -t d --max-depth 1 --base-directory /Users/dhruvthakur/.virtualenvs | awk -F  "/" '// {print $1}' | fzf --height=8 --layout=reverse --header="python env?")
            if [ -n "$selected_py_env" ]; then
                selected_entry=$(fd . --max-depth=1 $PROJECTS_DIR $WORK_DIR $CONFIG_DIR | fzf --height=8 --layout=reverse --header="project?")
                if [ -n "$selected_entry" ]; then
                    tmuxinator two-windows $selected_entry $selected_py_env
                fi
            fi
        elif [[ "$project_type" == "scala" ]]; then
            selected_entry=$(fd . --max-depth=1 $PROJECTS_DIR $WORK_DIR $CONFIG_DIR | fzf --height=8 --layout=reverse --header="project?")
            if [ -n "$selected_entry" ]; then
                tmuxinator scala-proj $selected_entry $GENERAL_PYTHON_ENV_NAME sbt
            fi
        fi
    fi
}

txw
