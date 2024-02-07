#!/bin/bash

show_help() {
    echo "Usage: $(basename "$0") <pane_command> <command_to_run>"
    echo "  pane_command: the command running in the panes to target"
    echo "  command_to_run: the command to run in the targeted panes"
    echo "  -h, --help: Show this help message"
}

if [ "$#" -eq 1 ] && { [ "$1" == "-h" ] || [ "$1" == "--help" ]; }; then
    show_help
    exit 0
fi

if [ "$#" -ne 2 ]; then
    echo "Error: Invalid number of arguments."
    echo ""
    show_help
    exit 1
fi

pane_command=$1
command_to_run=$2

nvim_panes=$(tmux list-panes -a -F "#{session_name}:#{window_name}.#{pane_id} #{pane_current_command}" | awk '$2=='"\"$pane_command\""' {print $1}')

for pane in $nvim_panes; do
    if [ "$command_to_run" = "C-c" ]; then
        echo "tmux send-keys -t $pane '$command_to_run'"
        tmux send-keys -t "$pane" "$command_to_run"
    else
        echo "tmux send-keys -t \"$pane\" \"$command_to_run\" Enter"
        tmux send-keys -t "$pane" "$command_to_run" Enter
        fi
done
