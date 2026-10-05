- Keep the machine tool catalog in `config.toml`. The repository-root `mise.toml` declares tools needed to maintain this repository.
- Environment profiles describe dotfile deployment, not separate tool catalogs. Use mise's self-managing configuration pattern to link the global mise config, shared Git preferences file, and orb Lazygit configuration directory to this checkout.

## Workflow for Amp orbs

- `.agents/setup` bootstraps an amp orb from the repository root. Keep it small: install mise, apply the orb dotfiles profile, then install the required global tool subset and repository dependencies from their committed lockfiles.
- Select the orb profile explicitly during bootstrap rather than setting it machine-wide. Do not install the entire machine tool catalog in the orb.
- Share `git/preferences` between local and orb Git configuration. Symlink only `~/.config/git/preferences` and register its include without replacing Amp's Git configuration, identity, credentials, or signing settings. Keep personal settings in `git/config` out of orbs.
