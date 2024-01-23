# https://blog.meain.io/2020/tmux-flating-scratch-terminal/

POPUP_BORDER_COLOR=#928374 # gruvbox gray darker

if [ "$(tmux display-message -p -F "#{session_name}")" = "popup" ];then
    tmux detach-client
else
    tmux display-popup \
        -h 60% -w 100% \
        -y 40% \
        -S fg=$POPUP_BORDER_COLOR \
        -E \
        -T "persistent" \
        "tmux attach -t popup || tmux new -A -s popup\; set status off"
fi
