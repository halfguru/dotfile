# PATH setup
export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"
[ -d "$HOME/.duckdb/cli/latest" ] && export PATH="$HOME/.duckdb/cli/latest:$PATH"
[ -d "$HOME/coding/flutter/bin" ] && export PATH="$HOME/coding/flutter/bin:$PATH"

# Oh My Zsh configuration (only if installed)
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
