#!/bin/sh

# https://blog.meain.io/2020/tmux-flating-scratch-terminal/

current_session_name="$(tmux display-message -p -F "#{session_name}")"
current_pane_path="$(tmux display-message -p -F "#{pane_current_path}")"
session_name="scratch"

if [ "$current_session_name" = "$session_name" ]; then
    tmux detach-client
else
    if ! tmux has-session -t "$session_name" 2>/dev/null; then
        window_id="$(tmux new-session -d -P -F '#{window_id}' -s "$session_name" -n "$current_session_name" -c "$current_pane_path")"
        tmux set-option -t "$session_name" status off
        tmux send-keys -t "$window_id" clear Enter
    else
        window_id="$(
            tmux list-windows -t "$session_name" -F '#{window_id} #{window_name}' |
                while IFS= read -r window; do
                    if [ "${window#* }" = "$current_session_name" ]; then
                        printf '%s\n' "${window%% *}"
                        break
                    fi
                done
        )"
    fi

    if [ -z "$window_id" ]; then
        window_id="$(tmux new-window -P -F '#{window_id}' -t "$session_name" -n "$current_session_name" -c "$current_pane_path")"
    fi

    tmux display-popup \
        -h 80% -w 100% \
        -y 100% \
        -E \
        "tmux attach-session -t '$window_id'"
fi
