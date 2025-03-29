#!/usr/bin/env bash

show_help() {
    echo "Usage: $(basename "$0") <session_name>"
    echo "  -h, --help: Show this help message"
}

if [ "$#" -ne 1 ]; then
    show_help
    exit 0
fi

session_name="$1"

colors="#d3869b #b8bb26 #83a598 #a89984 #8ec07c #fe8019 #fabd2f"
ascii_value=$(printf "%d" "'$arg")
index=$(expr $ascii_value % $(echo "$colors" | wc -w))
selected_color=$(echo "$colors" | cut -d ' ' -f $((index + 1)))

tmux set -t ${session_name} status-left "#[fg=#282828,bg=${selected_color}] #S "
