# Working on this config

This is a personal Neovim config. Keep it lean, minimal, and fast.

- Keep Neovim focused on editing. Prefer external tools through tmux over IDE-style integrations.
- Prefer built-in features and existing plugins. Ask before adding plugins or dependencies, and consider their runtime and maintenance costs.
- Clarify ambiguous requirements before editing. Keep changes small and focused on the requested behavior, without unrelated cleanup or restructuring.
- Preserve personal workflows and platform-specific behavior unless asked.
- Do not modify the normal Neovim environment to test an experimental checkout; agree on isolation first.
- Parser setup is intended for local machines. Do not install `tree-sitter` or run `:TSInstallManaged` or `:TSUpdateManaged` in Amp orbs unless the user explicitly requests parser setup. Install only the required tools in orbs, not the entire Neovim mise tool set.
