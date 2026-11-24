# Configurations

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

| Package | Files | Target |
|---------|-------|--------|
| `bash` | `.bashrc` | `~` |
| `bash-extra` | `.bashrc-extra` | `~` |
| `tmux` | `.tmux.conf` | `~` |
| `vim` | `.vimrc` | `~` |
| `cosmic` | `.config/cosmic/` | `~` |
| `nvim` | `.config/nvim/` | `~` |
| `claude` | `.claude/settings.json`, `.claude/CLAUDE.md` | `~` |
| `glzr` | `.glzr/glazewm/config.yaml` | (`glzr` is for Windows only. Do not use stow `glzr`.) |

## Setup on a new machine

```bash
git clone https://github.com/dbrandonk/bk-configs.git
cd bk-configs
stow --target="$HOME" bash bash-extra tmux vim cosmic nvim claude
```

That's it, stow creates symlinks from `~` back into `bk-configs`.

## Common commands

```bash
# Add a new package
stow <package>

# Remove a package's symlinks
stow -D <package>

# Restow after moving files around
stow -R <package>
```

## Adding a new config

1. Create a package directory: `mkdir <package>`
2. Mirror the target path inside it (e.g. for `~/.config/foo`, use `<package>/.config/foo`)
3. Move your config files in
4. Run `stow <package>`
