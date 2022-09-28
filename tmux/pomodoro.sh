#!/bin/sh

min_remaining="$($GOPATH/bin/openpomodoro-cli status -f '%R')"

if [[ "$min_remaining" == "1" ]]; then
    # osascript -e 'display notification "1 min remaining!" with title "🍅"'
    osascript -e 'tell application "Alfred 5" to run trigger "show_pomodoro_end_notification" in workflow "dhth.pomodoro"'
    echo "$($GOPATH/bin/openpomodoro-cli status -f ' break! (%c) ')"
elif [[ "$min_remaining" == "0" ]]; then
    echo "$($GOPATH/bin/openpomodoro-cli status -f ' break! (%c) ')"
else
    echo "$($GOPATH/bin/openpomodoro-cli status -f ' %!Rm ')"
fi
