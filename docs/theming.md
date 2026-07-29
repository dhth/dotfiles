# Theming Architecture

The theme switcher coordinates Ghostty, tmux, Neovim, and shell tools around a shared theme name. Theme names are application-neutral identifiers such as `gruvbox-dark-hard`; integrations translate them when an application uses a different name.

## Source of truth

The selected theme is stored outside the repository at `$HOME/.local/state/dotfiles/theme`. This keeps routine theme changes out of Git while allowing new processes to recover the current selection.

`utils/exe/theme` is the only writer of this state. It presents the known themes and coordinates updates to the running applications.

## Application boundaries

- **tmux** keeps semantic color palettes under `tmux/themes/` and applies them through the shared presentation in `tmux/theme.conf`. A loader resolves the selected palette at startup and during live switches, with Gruvbox Dark Hard as the fallback, then reapplies the shared presentation. Tmux themes also select the fzf colors and Delta feature inherited by new processes.
- **Lazygit** merges its base config with the matching file under `lazygit/themes/`. Tmux themes and shell color setup select that file through `LG_CONFIG_FILE`, so new Lazygit processes inherit the current theme.
- **Git** includes the Delta features under `git/themes/` and defaults to Gruvbox Dark Hard. Tmux themes and shell color setup select the active feature through `DELTA_FEATURES`.
- **Ghostty** keeps its active theme in the tracked `ghostty/config`. Changing themes intentionally creates a Git diff. The switcher maps the shared theme name to Ghostty's display name, but Ghostty is reloaded manually.
- **Neovim** instances running directly in tmux panes are updated during a live switch. Instances outside tmux are outside the scope of the switcher.
- **Shells** read the shared state through `zsh/colors.sh`. New shells apply the selected fzf, Lazygit, and Delta themes automatically; existing shells are refreshed by sourcing that file again.

## Design constraints

- The shared theme name, tmux filename, shell color case, and application mappings must stay aligned.
- Every tmux palette must define the complete set of options consumed by `tmux/theme.conf`, so live switches cannot retain colors from the previous theme.
- Application-specific theme files remain authoritative for their colors. There is no generated universal palette.
- Missing, invalid, or unavailable theme state falls back to Gruvbox Dark Hard where configuration must still load.
- Live updates are deliberately best-effort: Ghostty and existing shells retain their manual refresh steps.

## Adding a theme

Add the canonical name to the switcher, provide a complete tmux palette plus Lazygit and Delta themes, add the shell color mapping, and define any application-specific names or light/dark behavior. Keep the canonical identifier consistent across those integration points.
