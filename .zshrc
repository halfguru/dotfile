export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

alias cat='bat'
alias ls='eza --icons'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias lt='eza --tree --icons'
alias grep='grep --color=auto'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

[ -f "$HOME/.zshrc.local" ] && . "$HOME/.zshrc.local"
