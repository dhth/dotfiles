#!/usr/bin/env bash

# Loads the tmux theme named in shared state, falling back to Gruvbox Dark Hard.
# Theme names must use lowercase letters, numbers, and hyphens, and match a file
# under ~/.config/tmux/themes.

default_theme="gruvbox-dark-hard"
state_file="$HOME/.local/state/dotfiles/theme"
theme="$default_theme"

if [[ -r $state_file ]]; then
    theme=$(<"$state_file")
fi

if [[ ! $theme =~ ^[a-z0-9-]+$ ]]; then
    theme="$default_theme"
fi

theme_file="$HOME/.config/tmux/themes/$theme.conf"

if [[ ! -r $theme_file ]]; then
    theme_file="$HOME/.config/tmux/themes/$default_theme.conf"
fi

tmux source-file "$theme_file"
