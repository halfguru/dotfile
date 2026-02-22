# Agent Guidelines for Dotfiles Repository

This repository contains dotfiles managed with [dotbot](https://github.com/anishathalye/dotbot). The repo acts as a collection of configuration files that are symlinked to your home directory.

## Commands

### Dotfiles Installation
```bash
./install                    # Install all symlinks defined in install.conf.yaml
```

### Validation
```bash
# Validate YAML config
python3 -c "import yaml; yaml.safe_load(open('install.conf.yaml'))"

# Check installed symlinks
ls -la ~/.config/nvim ~/.zshrc ~/.gitconfig
```

### Git Submodules
```bash
git submodule update --init --recursive    # Initialize and update submodules (dotbot)
git submodule sync --quiet --recursive     # Sync submodule URLs with .gitmodules
```

### Dotbot Development (Submodule)

The `dotbot/` directory is a git submodule. If modifying dotbot itself:

```bash
cd dotbot

# Testing
hatch test                                          # Run all tests
hatch test -c                                       # Run with coverage
hatch test tests/test_link.py                       # Run tests in single file
hatch test tests/test_link.py::test_link_canonicalization  # Run single test

# Linting & Formatting
hatch fmt                                           # Format and lint (auto-fix)
hatch fmt --check                                   # Check without modifying

# Type Checking
hatch run types:check                               # Run mypy type checker
```

## Repository Structure

```
.
├── install                 # Main install script (bash)
├── install.conf.yaml       # Dotbot symlink configuration
├── zshrc                   # Zsh shell config
├── zshenv                  # Zsh environment variables
├── gitconfig               # Git configuration
├── neovim/                 # LazyVim-based Neovim config
│   ├── init.lua
│   ├── stylua.toml         # Lua formatter config
│   └── lua/
│       ├── config/         # Core config (options, keymaps, autocmds)
│       └── plugins/        # Plugin specifications
├── .github/
│   └── workflows/          # GitHub Actions CI
│       ├── lint.yaml       # YAML linting
│       └── test.yaml       # Config validation
├── dotbot/                 # Dotbot submodule (git submodule)
└── powershell/             # Windows PowerShell config (not installed on Linux)
```

## Code Style Guidelines

### YAML (Dotbot Configuration)

**Structure**
- `install.conf.yaml` defines symlinks: `~/.config/app: repo_dir`
- Keep symlinks sorted alphabetically for maintainability
- Use `create: true` to create parent directories automatically
- Use `relink: true` to recreate symlinks if they exist

**Example**
```yaml
- defaults:
    link:
      create: true
      relink: true

- link:
    ~/.config/your-app: your-app
    ~/.your-config: your-config
```

### Bash (Install Script)

**Conventions**
- Use `set -e` for error handling
- Quote variables: `"${VAR}"`
- Use `$()` for command substitution
- Shebang: `#!/usr/bin/env bash`

**Example**
```bash
#!/usr/bin/env bash
set -e
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
```

### Zsh Configuration

**Conditional Loading**
- Only load external tools if directories/files exist
- Use `[ -d "$DIR" ]` for directory checks
- Use `[ -f "$FILE" ]` for file checks

**Example**
```bash
[ -d "$HOME/.oh-my-zsh" ] && source "$HOME/.oh-my-zsh/oh-my-zsh.sh"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
```

**PATH Setup**
- Add paths conditionally to avoid errors
- Don't duplicate PATH additions

**Example**
```bash
export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"
```

**Functions**
- Define functions with descriptive names
- Use `local` for function-scoped variables
- Check arguments before processing
- Return appropriate exit codes

```bash
killport() {
  local port="$1"
  if [[ -z "$port" ]]; then
    echo "Usage: killport <port>"
    return 1
  fi
  local pids
  pids=$(lsof -t -i :"$port")
  if [[ -z "$pids" ]]; then
    echo "No process using port $port"
    return 0
  fi
  echo "Killing PID(s) on port $port: $pids"
  kill -9 $pids
}
```

**History Configuration**
- Set `HISTFILE`, `HISTSIZE`, `SAVEHIST` for persistent history
- Use `setopt HIST_IGNORE_DUPS` to avoid duplicate entries
- Use `setopt SHARE_HISTORY` to share history across sessions

```bash
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
```

**Aliases**
- Use conditional aliases for modern tools with fallbacks
- Group related aliases together (navigation, git, etc.)
- Use `command -v` to check if a tool exists

```bash
# Modern tool with fallback
if command -v exa &> /dev/null; then
  alias ls='exa --icons'
  alias ll='exa -l --icons'
else
  alias ll='ls -alF'
fi

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
```

**Local Overrides**
- Source `~/.zshrc.local` at the end for machine-specific config
- Keep personal/sensitive settings out of version control

```bash
[ -f "$HOME/.zshrc.local" ] && . "$HOME/.zshrc.local"
```

### Lua (Neovim Configuration)

**Plugin Structure**
- Plugin specs go in `lua/plugins/`
- Return tables with plugin definitions
- Follow LazyVim conventions

### TOML/JSON/YAML (External Configs)

These are external config files being copied to the repo. Follow their respective tool's conventions:

- `gitconfig` - Git configuration (INI-style)
- `neovim/` - LazyVim/Neovim config (Lua, follows LazyVim conventions)
- `zshrc` / `zshenv` - Zsh shell configuration (Shell)

**Note:** When modifying these configs, follow the conventions of their respective tools, not this repository's conventions. This repo simply manages where they are stored and linked.

## Adding New Configurations

1. Copy config file from `~/.config/your-app` to repo
2. Add symlink entry to `install.conf.yaml`
3. Run `./install` to create symlink
4. Test: Open application and verify config works

**Example:**
```bash
# 1. Copy config
cp ~/.config/your-app/config.toml ./your-app.toml

# 2. Add to install.conf.yaml
# - link:
#     ~/.config/your-app/config.toml: your-app.toml

# 3. Install
./install
```

## Git Commit Conventions

When committing changes:
- Write descriptive commit messages
- Use imperative mood ("Add config" not "Added config")
- Reference issues when applicable

## General Guidelines

- Prefer `"$HOME"` over hardcoded user paths (e.g., `/home/simon`) for portability
- Keep files small and focused
- Comment non-obvious configurations
- Don't commit sensitive data (SSH keys, API tokens, passwords, .env files)
- Use submodules for large external tools (like dotbot)
- The repo is a collection of configs to symlink - configs themselves follow their own tool's conventions
- When working in dotbot submodule, run `hatch fmt` and `hatch test` before committing
- Run `python3 -c "import yaml; yaml.safe_load(open('install.conf.yaml'))"` to validate YAML before committing
