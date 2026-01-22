# JumpDev OS

[![Build ISO](https://github.com/danupsher/jumpdev-os/actions/workflows/build-iso.yml/badge.svg)](https://github.com/danupsher/jumpdev-os/actions/workflows/build-iso.yml)

A portable Linux distribution for vibe coding and AI-assisted development. Boot from USB, jump into any machine, and start building.

## What is JumpDev OS?

JumpDev OS is a live Arch Linux distribution that runs entirely from USB. No installation, no dual-boot hassle - just plug in and code. Your environment travels with you.

**Built for:**
- Developers who work across multiple machines
- Portable coding setups
- Clean, consistent dev environments
- AI-assisted development workflows

## Features

### Modern Desktop
- **Hyprland** - Tiling Wayland compositor with smooth animations
- **Waybar** - Clean status bar with quick-launch buttons
- **Window decorations** - Title bars with close, maximize, minimize
- **Fuzzel** - Fast app launcher
- **Catppuccin Mocha** - Cohesive dark theme across all apps

### Development Stack
- **VS Code** + **Neovim** - GUI and terminal editors
- **Git** + **GitHub CLI** + **Lazygit** - Version control
- **Docker** + **Docker Compose** - Containers
- **Node.js**, **Python**, **Rust** - Language toolchains

### Included Apps
- **Firefox** - Browser
- **Thunar** - File manager
- **Discord** - Communication
- **VLC** - Media player
- **Foot** - Fast terminal

### CLI Tools
`fzf` `ripgrep` `fd` `bat` `eza` `zoxide` `yazi` `btop` `jq` `tmux` `fastfetch`

## Screenshots

*Coming soon*

## Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| USB Drive | 16GB USB 3.0 | 32GB+ USB 3.0/3.1 |
| RAM | 8GB | 16GB |
| CPU | x86_64 | - |
| Boot | UEFI or Legacy BIOS | UEFI |

**Note:** Secure Boot must be disabled.

## Quick Start

1. Download the latest ISO from [Releases](https://github.com/danupsher/jumpdev-os/releases)
2. Write to USB using [Balena Etcher](https://etcher.balena.io/), [Rufus](https://rufus.ie/), or:
   ```bash
   sudo dd if=jumpdev-*.iso of=/dev/sdX bs=4M status=progress oflag=sync
   ```
3. Boot from USB
4. Start coding

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
| `Super + F` | Fullscreen |
| `Super + V` | Toggle floating |
| `Print` | Screenshot region |

## Hardware Support

### Graphics
- **Intel** - Full support (mesa, vulkan-intel)
- **AMD** - Full support (mesa, vulkan-radeon)
- **NVIDIA** - Supported (nvidia-open-dkms)

### WiFi
Drivers included for Intel, Atheros, Broadcom, Realtek, Marvell, MediaTek, and Ralink chipsets.

## Tech Stack

| Component | Choice |
|-----------|--------|
| Base | Arch Linux (linux-zen kernel) |
| Display | Wayland + Hyprland |
| Terminal | Foot |
| Shell | Zsh + Starship |
| Editor | Neovim + VS Code |
| Theme | Catppuccin Mocha |
| Font | JetBrains Mono Nerd Font |

## Building from Source

```bash
git clone https://github.com/danupsher/jumpdev-os.git
cd jumpdev-os

# Requires Arch Linux with archiso
sudo pacman -S archiso
sudo mkarchiso -v -w /tmp/archiso-work -o out/ archiso/
```

Or push to main - GitHub Actions builds automatically.

## Roadmap

- [x] Gate 1: Bootable ISO with Hyprland desktop
- [x] Gate 2: Apps and developer tools
- [ ] Gate 3: Persistence for saving data between reboots
- [ ] Gate 4: Polish and release
- [ ] Gate 5: ARM64 / Apple Silicon

## Contributing

See:
- `CLAUDE.md` - AI-assisted development guide
- `COMPREHENSIVE_PLAN.md` - Project roadmap
- `DECISIONS.md` - Architectural decisions
- `BUILD_LOG.md` - Build history

## License

MIT License - see [LICENSE](LICENSE)

## Acknowledgements

- [Arch Linux](https://archlinux.org/) / [Archiso](https://wiki.archlinux.org/title/Archiso)
- [Hyprland](https://hyprland.org/) / [hyprbars](https://github.com/hyprwm/hyprland-plugins)
- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [Chaotic-AUR](https://aur.chaotic.cx/)
