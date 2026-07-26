# Sets shell color environment variables from the shared theme state.
# Missing or unknown state falls back to Gruvbox Dark Hard. Source this file
# again to update an existing shell after changing themes.

_dotfiles_apply_colors() {
    local state_file="$HOME/.local/state/dotfiles/theme"
    local theme=""

    if [[ -r $state_file ]]; then
        theme=$(<"$state_file")
    fi

    case $theme in
    gruvbox-light-hard)
        export FZF_DEFAULT_OPTS="--color=light,bg:#f9f5d7,bg+:#d5c4a1,fg:#3c3836,fg+:#3c3836,hl:#b57614,hl+:#af3a03,info:#076678,prompt:#af3a03,pointer:#9d0006,marker:#427b58,spinner:#076678,header:#928374,border:#d5c4a1 --bind=ctrl-a:select-all"
        ;;
    *)
        export FZF_DEFAULT_OPTS="--color=dark,bg:#1d2021,bg+:#504945,fg:#ebdbb2,fg+:#ebdbb2,hl:#fabd2f,hl+:#fe8019,info:#83a598,prompt:#fe8019,pointer:#fb4934,marker:#8ec07c,spinner:#83a598,header:#928374,border:#504945 --bind=ctrl-a:select-all"
        ;;
    esac
}

_dotfiles_apply_colors
unset -f _dotfiles_apply_colors
