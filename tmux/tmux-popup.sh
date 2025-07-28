# https://blog.meain.io/2020/tmux-flating-scratch-terminal/

POPUP_BORDER_COLOR=#928374 # gruvbox gray darker

current_session_name="$(tmux display-message -p -F "#{session_name}")"
session_name="popup"

if [ "$current_session_name" = "$session_name" ]; then
    tmux detach-client
else
    if ! tmux has-session -t "$session_name" 2>/dev/null; then
        tmux new-session -d -s "$session_name" -n "$current_session_name" -c "$(pwd)"
        tmux send-keys -t "$session_name" 'tmux set-option status off' Enter
        tmux send-keys -t "$session_name" 'clear' Enter
    fi

    if ! tmux list-windows -t "$session_name" | grep -q "$current_session_name"; then
        tmux new-window -t "$session_name" -n "$current_session_name" -c "$(pwd)"
    fi
    command="tmux attach -t \"$session_name:$current_session_name\""

    tmux display-popup \
        -h 80% -w 100% \
        -y 100% \
        -S fg=$POPUP_BORDER_COLOR \
        -E \
        -T "persistent" \
        "$command"
fi
