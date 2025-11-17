#!/bin/bash
# Productivity aliases for DGX systems

# List files in long format with type indicators
alias ll='ls -alF'

# List all files including hidden, excluding . and ..
alias la='ls -A'

# Simple directory listing
alias l='ls -CF'

# Quick navigation
alias desk='cd ~/Desktop'
alias proj='cd ~/projects'

# GPU monitoring
alias gpu='watch -n 1 nvidia-smi'

# Update system packages
alias update='sudo apt update && sudo apt upgrade -y'

# Activate default virtual environment (adjust path)
alias pyenv='source ~/venv/bin/activate'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gpl='git pull'
alias gps='git push'

# Make directory and enter it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Show disk usage of current directory
alias dus='du -sh ./* | sort -h'

# Use exa instead of ls if installed (commented out by default)
# alias ls='exa'

# End of aliases

# To use these aliases, source this file in your ~/.bashrc or ~/.zshrc:
#   source /path/to/productivity_aliases.sh