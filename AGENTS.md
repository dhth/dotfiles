## Key Conventions

- Read `docs/theming.md` before changing Ghostty, tmux, shell, fzf, or Neovim theme integration.
- Read `docs/karabiner.md` before changing Karabiner configuration or its environment.
- Read `docs/keymaps.md` before changing shortcuts that connect Karabiner, tmux, and repository utilities.

## Tool installation in orbs

- Install global tools with `mise run global-tools:install <tool-1> <tool-2>`. Install repository tools with `mise install --locked <tool>` from the repository root.
- Do not run unlocked `mise install` unless lockfile changes are intended. It can rewrite unrelated entries and dependency sidecar paths even when installing a single tool.
