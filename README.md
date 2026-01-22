# JumpDev OS

[![Build ISO](https://github.com/danupsher/jumpdev-os/actions/workflows/build-iso.yml/badge.svg)](https://github.com/danupsher/jumpdev-os/actions/workflows/build-iso.yml)

**Your dev environment, on a USB stick.**

Boot from USB on any PC. Same tools, same configs, same projects. When you're ready, migrate to disk with everything intact.

## The Problem

You work on multiple machines. Or you want Linux without nuking your Windows install. Or you're tired of setting up the same dev environment over and over.

## The Solution

JumpDev OS is a portable Arch Linux distribution with everything configured:

- **VS Code + Neovim** - Editors ready to go
- **Docker + Git + Lazygit** - Containers and version control
- **Node.js, Python, Rust** - Languages pre-installed
- **Claude Code, Aider, Ollama** - AI coding tools included
- **Modern desktop** - Hyprland with window buttons and app drawer

Plug in. Boot up. Code.

## Portable → Permanent

Use JumpDev OS from USB for a day, a week, or a month. Your files and logins persist between reboots.

When you're ready to install permanently:

1. Click "Install to Disk"
2. Choose your drive
3. Everything migrates - browser sessions, app logins, projects, configs

Same environment. Just faster.

## Screenshots

*Coming soon*

## Quick Start

1. Download the latest ISO from [Releases](https://github.com/danupsher/jumpdev-os/releases)
2. Flash to USB with [Balena Etcher](https://etcher.balena.io/) or [Rufus](https://rufus.ie/)
3. Boot from USB
4. Start coding

## Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| USB Drive | 16GB USB 3.0 | 32GB+ USB 3.0/3.1 |
| RAM | 8GB | 16GB |
| CPU | x86_64 | - |

Secure Boot must be disabled.

## What's Included

### Desktop
Hyprland (tiling WM), Waybar, nwg-drawer (app launcher), Catppuccin theme

### Editors
VS Code, Neovim (LSP configured)

### Dev Tools
Git, GitHub CLI, Lazygit, Docker, Docker Compose

### Languages
Node.js, Python, Rust (rustup)

### AI Tools
Claude Code, Aider, Ollama

### Apps
Firefox, Thunar, Discord, VLC

### CLI
`fzf` `ripgrep` `fd` `bat` `eza` `zoxide` `yazi` `btop` `lazygit` `tmux`

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `Super + Return` | Terminal |
| `Super + D` | App launcher |
| `Super + Q` | Close window |
| `Super + B` | Firefox |
| `Super + E` | File manager |
| `Super + C` | VS Code |
| `Super + 1-9` | Switch workspace |

Or use the buttons in the top bar.

## Hardware

- **Graphics**: Intel, AMD, NVIDIA
- **WiFi**: Intel, Atheros, Broadcom, Realtek, Marvell, MediaTek

## Roadmap

- [x] Bootable ISO with Hyprland desktop
- [x] Apps and developer tools
- [ ] Persistence (save data between reboots)
- [ ] Install to disk with seamless migration
- [ ] AI tools pre-installed
- [ ] ARM64 / Apple Silicon

## Building from Source

```bash
git clone https://github.com/danupsher/jumpdev-os.git
cd jumpdev-os
sudo pacman -S archiso  # Requires Arch Linux
sudo mkarchiso -v -w /tmp/archiso-work -o out/ archiso/
```

## License

MIT

## Links

[Arch Linux](https://archlinux.org/) / [Hyprland](https://hyprland.org/) / [Catppuccin](https://github.com/catppuccin/catppuccin) / [Chaotic-AUR](https://aur.chaotic.cx/)
