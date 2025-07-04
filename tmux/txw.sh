#!/usr/bin/env sh

export PROJECTS_DIR="$HOME/projects"
export WIKI_DIR="$HOME/projects/knowledge"
export CONFIG_DIR="$HOME/.config"
export GENERAL_PYTHON_ENV_NAME="general"

function txwpy() {
	# open tmuxinator in a specific work directory
    local selected_entry
    local selected_py_env

    if [ -n "$1" ]; then
        selected_py_env="$1"
    else
        selected_py_env=$(fd -t d --max-depth 1 --base-directory /Users/dhruvthakur/.virtualenvs | awk -F "/" '// {print $1}' | fzf --height=12 --layout=reverse --header="which python?")
    fi

    if [ -n "$selected_py_env" ]; then
        selected_entry=$(fd . --max-depth=1 $PROJECTS_DIR $WORK_DIR $WORK_DIR_2 $CONFIG_DIR $MAC_CONFIG_DIR | fzf --multi --height=20 --layout=reverse --header="project?")
        if [ -n "$selected_entry" ]; then
            printf "%s\n" "$selected_entry" | while IFS= read -r project; do
            tmuxinator two-windows $project $selected_py_env
        done
        fi
    fi
}

function txw() {
	# open tmuxinator in a specific work directory
	local selected_entry
        local selected_py_env

        local project_type
	project_type=$(echo "scala\npy" | fzf --height=8 --layout=reverse --header="type?")

	if [ -n "$project_type" ]; then
		if [[ "$project_type" == "py" ]]; then
			selected_py_env=$(fd -t d --max-depth 1 --base-directory /Users/dhruvthakur/.virtualenvs | awk -F "/" '// {print $1}' | fzf --height=8 --layout=reverse --header="python env?")
			if [ -n "$selected_py_env" ]; then
				selected_entry=$(fd . --max-depth=1 $PROJECTS_DIR $WORK_DIR $WORK_DIR_2 $CONFIG_DIR | fzf --multi --height=20 --layout=reverse --header="project?")
				if [ -n "$selected_entry" ]; then
					printf "%s\n" "$selected_entry" | while IFS= read -r project; do
						tmuxinator two-windows $project $selected_py_env
					done
				fi
			fi
		elif [[ "$project_type" == "scala" ]]; then
			selected_entry=$(fd . --max-depth=1 $PROJECTS_DIR $WORK_DIR $WORK_DIR_2 $CONFIG_DIR | fzf --multi --height=20 --layout=reverse --header="project?")
			if [ -n "$selected_entry" ]; then
				printf "%s\n" "$selected_entry" | while IFS= read -r project; do
					tmuxinator scala-proj $project $GENERAL_PYTHON_ENV_NAME sbt
				done
			fi
		fi
	fi
}

txwpy "$@"
