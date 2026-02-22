# Dotfiles

Personal dotfiles managed with [dotbot](https://github.com/anishathalye/dotbot).

## Prerequisites

- Git
- Zsh
- [Oh My Zsh](https://ohmyz.sh/) (optional, but recommended)

### Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Installation

```bash
git clone <repo-url> ~/dotfile
cd ~/dotfile
./install
```

This will create symlinks:
- `~/.config/nvim` → `neovim/`
- `~/.zshrc` → `zshrc`
- `~/.zshenv` → `zshenv`
- `~/.gitconfig` → `gitconfig`

## Configuration

### Adding New Configs

1. Copy config to this repo
2. Add symlink to `install.conf.yaml`

Example:
```yaml
- link:
    ~/.config/your-app: your-app
```

3. Run `./install`

### Neovim

Uses [LazyVim](https://github.com/LazyVim/LazyVim) as a starter template.

### Zsh

- Conditionally loads Oh My Zsh if installed
- Includes helpful functions (e.g., `killport`)
- PATH setup for common tools

## Updating

```bash
cd ~/dotfile
git pull
./install
```
