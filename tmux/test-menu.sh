#!/usr/bin/env sh

# An example tmux menu command

# Bind it as:
# bind-key <whatever> run-shell "~/.config/tmux/test-menu"

tmux display-menu \
  'this is the first entry'  1 'run-shell "echo \"one\""' \
  'this is the second entry'  2 'run-shell "echo \"two\""' \
  'this is the third entry'  3 'run-shell "echo \"three\""'
