#!/usr/bin/env bash
# JumpDev OS - Customize airootfs script
# This runs during ISO build to configure the live system

set -e

echo "=== JumpDev OS Customization ==="

# Generate locales
echo "Generating locales..."
locale-gen

# Install Claude Code globally via npm
echo "Installing Claude Code..."
npm install -g @anthropic-ai/claude-code || echo "Claude Code install failed, will retry on first boot"

# Aider requires persistence (too large for live tmpfs)
# Users can install via: jumpdev install-aider (after setting up persistence)

# Ollama available via: jumpdev install-ollama (optional, large download)

# Initialize rustup for the jump user's skel
echo "Initializing Rust toolchain..."
export RUSTUP_HOME=/etc/skel/.rustup
export CARGO_HOME=/etc/skel/.cargo
rustup default stable || echo "Rustup init failed, user can run rustup on first boot"

# Ensure jump user owns their home directory
echo "Setting permissions..."
chown -R 1000:1000 /home/jump

echo "=== Customization complete ==="
