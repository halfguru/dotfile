# Dotfiles

Personal configuration files for Linux (Omarchy/Hyprland).

## Install

```bash
./install
```

This creates symlinks from the repo to your home directory. Existing files are backed up with `.bak` extension.

## Configs

| Config | Path |
|--------|------|
| Zsh | `~/.zshrc` |
| Hyprland | `~/.config/hypr` |
| Neovim | `~/.config/nvim` |
| Openencode | `~/.config/opencode/opencode.json` |

## Structure

```
.
├── install              # Symlink installer
├── .zshrc               # Shell config
├── hypr/                # Hyprland window manager
│   ├── hyprland.conf
│   ├── monitors.conf
│   ├── bindings.conf
│   └── ...
├── nvim/                # Neovim (LazyVim)
│   ├── init.lua
│   └── lua/
└── opencode/            # Openencode AI assistant
    └── opencode.json
```
