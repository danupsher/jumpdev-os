# JumpDev OS Zsh Environment

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Default programs
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="foot"
export BROWSER="firefox"

# Path
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.npm-global/bin:$PATH"

# Wayland
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland,x11

# Node.js
export NPM_CONFIG_PREFIX="$HOME/.npm-global"

# Rust
export RUSTUP_HOME="$HOME/.rustup"
export CARGO_HOME="$HOME/.cargo"

# Python
export PYTHONDONTWRITEBYTECODE=1

# Less
export LESS='-R --use-color -Dd+r$Du+b'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
