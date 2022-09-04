#!/bin/sh

min_remaining="$($GOPATH/bin/openpomodoro-cli status -f '%R')"

if [[ "$min_remaining" == "1" ]]; then
    osascript -e 'display notification "1 min remaining!" with title "🍅"'
fi

if [[ "$min_remaining" == "0" ]]; then
    echo "$($GOPATH/bin/openpomodoro-cli status -f ' b %c ')"
else
    echo "$($GOPATH/bin/openpomodoro-cli status -f ' %!R (%c) ')"
fi
