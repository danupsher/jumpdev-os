# JumpDev OS

[![Build ISO](https://github.com/danupsher/jumpdev-os/actions/workflows/build-iso.yml/badge.svg)](https://github.com/danupsher/jumpdev-os/actions/workflows/build-iso.yml)

**The first Linux distro built for vibe coding.**

Claude Code, VS Code, and modern CLI tools. Boot from USB anywhere. Migrate to disk when you're ready. Everything just works.

## Why JumpDev OS?

The AI coding wave is here. Everyone's using Claude Code, Aider, Cursor, Copilot. But there's no operating system built for it.

**JumpDev OS is that operating system.**

- **AI tools pre-installed** - Claude Code, Aider, Ollama ready at first boot
- **Boot from USB** - Plug into any PC and start coding
- **Migrate to disk** - When you're ready, install permanently with all your data intact
- **Modern desktop** - Hyprland tiling WM with window buttons and app drawer
- **Everything configured** - VS Code, Neovim, Docker, Git, Node, Python, Rust

No setup. No configuration. Just code.

## Features

### AI-First Development
- **Claude Code** - AI pair programming in your terminal
- **Aider** - AI coding assistant
- **Ollama** - Local LLMs, runs offline

### Modern Desktop
- **Hyprland** - Tiling Wayland compositor with smooth animations
- **Window decorations** - Title bars with close, maximize, minimize
- **nwg-drawer** - App launcher with categories
- **Catppuccin Mocha** - Cohesive dark theme

### Development Stack
- **VS Code** + **Neovim** - GUI and terminal editors
- **Git** + **GitHub CLI** + **Lazygit** - Version control
- **Docker** + **Docker Compose** - Containers
- **Node.js**, **Python**, **Rust** - Languages

### Portable → Permanent
Use JumpDev OS from USB for a day, a week, or a month. When you're ready:

1. Click "Install to Disk"
2. Choose your drive
3. All your logins, projects, and configs migrate automatically

Same browser sessions. Same app logins. Same projects. Just faster.

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

## Included Software

### Apps
Firefox, VS Code, Thunar, Discord, VLC, Foot terminal

### CLI Tools
`fzf` `ripgrep` `fd` `bat` `eza` `zoxide` `yazi` `btop` `lazygit` `tmux`

### Languages
Node.js, Python, Rust (via rustup)

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

Or just use the buttons in the top bar.

## Hardware Support

- **Graphics**: Intel, AMD, NVIDIA (open drivers)
- **WiFi**: Intel, Atheros, Broadcom, Realtek, Marvell, MediaTek

## Tech Stack

| Component | Choice |
|-----------|--------|
| Base | Arch Linux (linux-zen) |
| Display | Wayland + Hyprland |
| Shell | Zsh + Starship |
| Theme | Catppuccin Mocha |
| Font | JetBrains Mono Nerd Font |

## Roadmap

- [x] Bootable ISO with Hyprland desktop
- [x] Apps and developer tools
- [ ] Persistence (save data between reboots)
- [ ] Install to disk with migration
- [ ] AI tools pre-installed
- [ ] ARM64 / Apple Silicon

## Building from Source

```bash
git clone https://github.com/danupsher/jumpdev-os.git
cd jumpdev-os
sudo pacman -S archiso  # Requires Arch Linux
sudo mkarchiso -v -w /tmp/archiso-work -o out/ archiso/
```

## Contributing

See `CLAUDE.md`, `COMPREHENSIVE_PLAN.md`, `DECISIONS.md`

## License

MIT License

## Acknowledgements

[Arch Linux](https://archlinux.org/) / [Hyprland](https://hyprland.org/) / [Catppuccin](https://github.com/catppuccin/catppuccin) / [Chaotic-AUR](https://aur.chaotic.cx/)
