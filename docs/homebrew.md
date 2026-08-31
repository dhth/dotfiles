# Homebrew and mise

Homebrew and mise have separate responsibilities in this setup:

- mise manages portable command-line tools, language runtimes, and tools from
  language package ecosystems;
- Homebrew manages native macOS applications, macOS integrations, and packages
  without a suitable mise installation path.

Mise may orchestrate Homebrew installation and `brew bundle`, but Homebrew is
not installed as a mise tool and Homebrew packages are not declared through
mise's `brew:` backend. Homebrew packages remain explicitly declared in the
Brewfile.

## Ruby ownership

Homebrew and mise each use their own Ruby installation for a different purpose.

Homebrew maintains a private portable Ruby inside its installation:

```text
/opt/homebrew/Library/Homebrew/vendor/portable-ruby/<version>/
```

This Ruby is a Homebrew implementation detail. Homebrew invokes it directly to
run Homebrew itself. It is not a normal `ruby` formula, is not ordinarily added
to the interactive shell's `PATH`, and must not be used as the runtime for user
gems or projects.

Mise independently installs the Ruby declared in the global mise configuration:

```toml
ruby = "4.0.6"
"gem:tmuxinator" = { version = "3.4.1", depends = "ruby" }
```

That Ruby lives under mise's data directory, normally:

```text
~/.local/share/mise/installs/ruby/4.0.6/
```

Mise uses it to install and run RubyGems tools such as Tmuxinator. The explicit
dependency ensures Ruby is installed before the gem backend installs
Tmuxinator.

The resulting ownership is:

```text
Homebrew
└── private portable Ruby
    └── runs Homebrew

mise
├── selected Ruby runtime
└── Tmuxinator installed through RubyGems
```

These installations may happen to use the same Ruby version, but they have
independent locations and lifecycles. Homebrew may change its internal Ruby
without changing the mise-managed runtime, and changing the mise Ruby does not
change the runtime Homebrew uses.

## Shell environment

Mise activation should select the mise-managed Ruby and Tmuxinator for normal
interactive use. Homebrew does not rely on whichever `ruby` appears first in
the interactive `PATH`, so this does not interfere with Homebrew.

Avoid globally hardcoding Ruby environment variables such as:

```text
GEM_HOME
GEM_PATH
RUBYLIB
RUBYOPT
```

Values tied to Homebrew, the macOS system Ruby, or another Ruby installation
can leak across ownership boundaries and interfere with mise-managed Ruby and
gems. Let mise establish the appropriate runtime environment instead.

The separation can be inspected with:

```sh
brew config
command -v ruby
ruby --version
command -v tmuxinator
tmuxinator --version
```

Expected ownership is:

```text
Homebrew Ruby: /opt/homebrew/Library/Homebrew/vendor/portable-ruby/...
ruby:           ~/.local/share/mise/installs/ruby/4.0.6/bin/ruby
tmuxinator:     ~/.local/share/mise/installs/gem-tmuxinator/3.4.1/bin/tmuxinator
```

Homebrew's private Ruby should never be added to `PATH` or referenced by the
dotfiles. Mise's Ruby remains the user-facing runtime for Tmuxinator and other
deliberately managed Ruby tools.
