# PATH setup
export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.duckdb/cli/latest" ] && export PATH="$HOME/.duckdb/cli/latest:$PATH"
[ -d "$HOME/coding/flutter/bin" ] && export PATH="$HOME/coding/flutter/bin:$PATH"
[ -d "$HOME/go/bin" ] && export PATH="$HOME/go/bin:$PATH"
[ -d "/usr/local/go/bin" ] && export PATH="/usr/local/go/bin:$PATH"

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Oh My Zsh configuration (only if installed)
# Note: zsh-autosuggestions and zsh-syntax-highlighting require manual installation:
#   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#   git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ -d "$HOME/.oh-my-zsh" ]; then
  export ZSH="$HOME/.oh-my-zsh"
  ZSH_THEME="robbyrussell"
  plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
  source $ZSH/oh-my-zsh.sh
fi

# Editor setup
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Source local environment if exists
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Functions
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

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Aliases
# Modern replacements (fall back to original if not installed)
if command -v exa &> /dev/null; then
  alias ls='exa --icons'
  alias ll='exa -l --icons'
  alias la='exa -la --icons'
  alias lt='exa --tree --level=2 --icons'
  alias lta='exa --tree --level=2 --icons -a'
else
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
fi

if command -v bat &> /dev/null; then
  alias cat='bat --paging=never'
  alias catp='bat'  # bat with paging
fi

if command -v batcat &> /dev/null; then
  alias cat='batcat --paging=never'
  alias catp='batcat'
fi

# Common aliases
alias cls='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias df='df -h'
alias du='du -h'
alias mkdir='mkdir -pv'
alias ports='netstat -tulanp'
alias myip='curl -s ifconfig.me && echo'
alias weather='curl wttr.in'
alias path='echo -e ${PATH//:/\\n}'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -10'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# Source local zshrc if exists (for machine-specific config)
[ -f "$HOME/.zshrc.local" ] && . "$HOME/.zshrc.local"
