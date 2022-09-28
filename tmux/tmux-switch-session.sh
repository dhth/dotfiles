function txs(){
    local selected_entry

    selected_entry=$(tmux list-sessions -F '#S' | fzf --height=12 --layout=reverse --header="session?")

    if [ -n "$selected_entry" ]; then
        tmux switch-client -t $selected_entry
    fi
}

txs
