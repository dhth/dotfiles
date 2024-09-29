#!/bin/bash

# https://gist.github.com/NoahCardoza/fa060f434a7eda2fc040619a25a8f136

# args: browser
# example: ./get_open_tabs.sh "Brave Browser"
# credits:
#  https://gist.github.com/samyk/65c12468686707b388ec43710430a421

# TODO:
#  validate args
#  don't open app if not already open

browser="${1:-"Brave Browser"}"

osascript <<EOF
# build the output with this variable
set titleString to ""
# Apple Script must be able to compile tell statments
# which mean's they can't be variable in Apple Script its self
# but not Bash ;)
tell application "$browser"
        set window_list to every window # get the windows
        repeat with the_window in window_list # for every window
                set tab_list to every tab in the_window # get the tabs
                repeat with the_tab in tab_list # for every tab
                        set the_url to the URL of the_tab # grab the URL
                        set titleString to titleString & the_url & "\n"
                end repeat
        end repeat
        return titleString
end tell
EOF
