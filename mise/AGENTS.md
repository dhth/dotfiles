# Mise workflow

- Keep the machine tool catalog in `config.toml`. The repository-root
  `mise.toml` declares tools needed to maintain this repository.
- Environment profiles describe dotfile deployment, not separate tool catalogs.
  Use mise's self-managing configuration pattern to link the global mise config
  and the existing Git and Lazygit configuration directories to this checkout.
- `.agents/setup` bootstraps the orb from the repository root. Keep it small:
  install mise, apply the orb dotfiles profile, then install the required global
  tool subset and repository dependencies from their committed lockfiles.
- Select the orb profile explicitly during bootstrap rather than setting it
  machine-wide. Do not install the entire machine tool catalog in the orb.
- Reuse the existing Git configuration and preserve Amp's Git configuration.
  Let mise reject conflicting dotfiles rather than forcing replacement.
- Keep Mac bootstrap work separate until it is requested.
