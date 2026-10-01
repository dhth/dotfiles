# Keymaps

This guide covers shortcuts connecting Karabiner, tmux, and repository utilities, not an inventory of individual bindings. See [Karabiner Integration](karabiner.md) for generated configuration and Karabiner's environment.

## Shortcut chain

- `karabiner/karabiner.edn` owns simlayers, application conditions, and emitted keys.
- `tmux/.tmux.conf` owns key tables, popup presentation, and starting directories.
- `utils/exe` owns the commands and their behavior, available by name through `$HOME/.local/bin/utils`.

For example, holding `f` and pressing `n` runs `ppth`:

```text
f-mode + n → Ctrl+a → u → P → ppth → project-dirs → pth
```

Its Karabiner rule is `[:n [:tmux-prefix :tmux-popup-tools :!Sp] :termemul]`. The aliases are defined under `:tos`; `:!Sp` emits Shift+p (tmux's `P`). `:termemul` matches terminal applications, not whether tmux is running in them. Karabiner sends keys to the focused tmux client rather than launching tmux itself.

## Change conventions

- Check collisions in both the Karabiner simlayer and the target tmux table. Account for global and application-specific rules; specific rules should precede global fallbacks. Physical shortcuts need not match the emitted tmux letters.
- Keep rule comments and tmux `-N` descriptions meaningful. Inspect tool bindings with `tmux list-keys -N -T popup-tools`, or use that table's `?` help binding.
- Invoke executable utilities by name. Their tools and environment variables must be available in the tmux popup environment, not just Karabiner's environment.
- Use `display-popup -d '#{pane_current_path}'` for current-directory tools and `-E` to close the popup when the command exits. Size popups for their content; the file pickers use 80% height and 100% width for previews and pagers.
- Share discovery and behavior rather than copying them: `project-dirs` owns project roots, `project-files` owns file discovery.
