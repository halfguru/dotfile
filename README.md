<div align="center">

# Dotfiles

Personal dotfiles managed with [dotbot](https://github.com/anishathalye/dotbot)

[![License](https://img.shields.io/github/license/halfguru/dotfile?style=flat-square&color=blue)](LICENSE.md)
[![Dotbot](https://img.shields.io/badge/managed%20with-dotbot-blue?style=flat-square)](https://github.com/anishathalye/dotbot)
[![Neovim](https://img.shields.io/badge/Neovim-LazyVim-green?style=flat-square&logo=neovim)](https://github.com/LazyVim/LazyVim)
[![Shell](https://img.shields.io/badge/Shell-Zsh-informational?style=flat-square&logo=zsh)](https://www.zsh.org/)

<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=80&section=footer" />

</div>

## Features

- Cross-platform support (Linux & Windows)
- Neovim configured with [LazyVim](https://github.com/LazyVim/LazyVim)
- Zsh with Oh My Zsh integration
- Git configuration
- Managed with [dotbot](https://github.com/anishathalye/dotbot) for easy symlink management

## Prerequisites

| Tool | Required | Notes |
|------|----------|-------|
| Git | Yes | Version control |
| Zsh | Yes | Shell (Linux) |
| [Oh My Zsh](https://ohmyz.sh/) | Optional | Recommended for best experience |
| [Neovim](https://neovim.io/) | Optional | v0.9+ recommended |

### Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Installation

```bash
git clone https://github.com/halfguru/dotfile.git ~/dotfile
cd ~/dotfile
./install
```

### What gets linked

| Source | Target |
|--------|--------|
| `neovim/` | `~/.config/nvim` |
| `zshrc` | `~/.zshrc` |
| `zshenv` | `~/.zshenv` |
| `gitconfig` | `~/.gitconfig` |

## Updating

```bash
cd ~/dotfile
git pull
./install
```

## Configuration

### Neovim

Uses [LazyVim](https://github.com/LazyVim/LazyVim) as a starter template with:

- Custom colorscheme (retrobox)
- 4-space indentation
- LSP inlay hints disabled

### Zsh

- Conditionally loads Oh My Zsh if installed
- Includes helpful functions (e.g., `killport`)
- PATH setup for common tools (cargo, bun, nvm, etc.)

### Adding New Configs

1. Copy config to this repo
2. Add symlink to `install.conf.yaml`:

```yaml
- link:
    ~/.config/your-app: your-app
```

3. Run `./install`

## License

Released under [The Unlicense](LICENSE.md) - do whatever you want with it.

---

<div align="center">
<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=80&section=header" />
</div>
