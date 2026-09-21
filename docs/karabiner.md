# Karabiner Integration

## Source and generated configuration

`karabiner/karabiner.edn` is the tracked Goku source of truth. Goku translates
it into Karabiner's generated `karabiner.json`; generated output is not portable
configuration and should not become the source of truth.

## Environment boundary

Karabiner runs `shell_command` actions through `/bin/sh` in its console-user
server. These commands inherit Karabiner's process environment, not interactive
Zsh initialization, so mise activation does not make globally configured tools
available to them.

Karabiner loads machine-local environment overrides from:

```text
/Library/Application Support/org.pqrs/config/karabiner_environment
```

This file accepts environment assignments and expands existing variables such
as `$HOME` and `$PATH`. It is not a shell script and cannot run commands or
perform command substitution. Karabiner reads it when its console-user server
starts, rather than before every mapping invocation.

## Command paths

Tmux-related mappings do not launch `tmux` through Karabiner shell commands.
Karabiner sends prefix and key-table sequences into the focused terminal, and
the focused tmux client executes the corresponding bindings. This preserves the
client, pane, session, and working-directory context of the visible terminal.

Other mappings invoke repository utilities by command name.
`$HOME/.local/bin/utils` is a symlink to `utils/exe` in this repository.
Karabiner's `PATH` includes that stable entry rather than the repository's clone
path.

The repository owns the complete environment file and updates its managed
environment with:

```sh
mise run karabiner:update-environment
```

The environment includes the stable utilities directory. Tmux key-sequence
mappings do not require the tmux executable in Karabiner's `PATH`. The task
replaces the file, so additional Karabiner environment settings must be added to
the task rather than edited only on one machine. After running it, restart
Karabiner-Elements from its menu-bar menu so the console-user server loads the
new environment.

See Karabiner's
[environment-variable documentation](https://karabiner-elements.pqrs.org/docs/help/advanced-topics/set-environment-variables/)
for the file format and restart behavior.
