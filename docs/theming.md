# Theming Architecture

The theme switcher coordinates Ghostty, tmux, Neovim, and shell tools around a shared theme name. Theme names are application-neutral identifiers such as `gruvbox-dark-hard`; integrations translate them when an application uses a different name.

## Source of truth

The selected theme is stored outside the repository at `$HOME/.local/state/dotfiles/theme`. This keeps routine theme changes out of Git while allowing new processes to recover the current selection.

`utils/exe/theme` is the only writer of this state. It presents the known themes and coordinates updates to the running applications.

## Application boundaries

- **tmux** uses complete, self-contained files under `tmux/themes/`. A loader resolves the selected theme at startup and during live switches, with Gruvbox Dark Hard as the fallback. Tmux themes also own the fzf colors inherited by popup commands.
- **Ghostty** keeps its active theme in the tracked `ghostty/config`. Changing themes intentionally creates a Git diff. The switcher maps the shared theme name to Ghostty's display name, but Ghostty is reloaded manually.
- **Neovim** instances running directly in tmux panes are updated during a live switch. Instances outside tmux are outside the scope of the switcher.
- **Shells** read the shared state through `zsh/colors.sh`. New shells apply the selected colors automatically; existing shells are refreshed by sourcing that file again.

## Design constraints

- The shared theme name, tmux filename, shell color case, and application mappings must stay aligned.
- Application-specific theme files remain authoritative for their colors. There is no generated universal palette.
- Missing, invalid, or unavailable theme state falls back to Gruvbox Dark Hard where configuration must still load.
- Live updates are deliberately best-effort: Ghostty and existing shells retain their manual refresh steps.

## Adding a theme

Add the canonical name to the switcher, provide a complete tmux theme, add the shell color mapping, and define any application-specific names or light/dark behavior. Keep the canonical identifier consistent across those integration points.
