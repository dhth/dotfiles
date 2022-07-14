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
            selected_entry=$(fd . --max-depth=1 $PROJECTS_DIR $WORK_DIR $CONFIG_DIR | fzf --height=8 --layout=reverse --header="project?")
            if [ -n "$selected_entry" ]; then
                tmuxinator two-windows $selected_entry $GENERAL_PYTHON_ENV_NAME
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
