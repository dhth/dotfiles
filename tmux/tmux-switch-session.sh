function txs() {
    local selected_entry

    selected_entry=$(tmux list-sessions -F "#{session_last_attached} #{session_name}" | sort -nr | awk '{print $2}' | fzf --height=20 --layout=reverse --header="session?")

    if [ -n "$selected_entry" ]; then
        tmux switch-client -t $selected_entry
    fi
}

txs
