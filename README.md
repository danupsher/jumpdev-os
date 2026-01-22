# JumpDev OS

[![Build ISO](https://github.com/danupsher/jumpdev-os/actions/workflows/build-iso.yml/badge.svg)](https://github.com/danupsher/jumpdev-os/actions/workflows/build-iso.yml)

A portable Linux distribution for vibe coding and AI-assisted development. Boot from USB, jump into any machine, and start building.

## What is JumpDev OS?

JumpDev OS is a live USB Arch Linux distribution designed for developers who want a consistent, portable coding environment. Plug it into any PC, boot up, and you're in a fully configured workspace - no installation required.

**Perfect for:**
- Developers who work on multiple machines
- Windows users curious about Linux without commitment
- Anyone who wants a portable, consistent dev environment
- Vibe coding with AI assistants

## Features

### Beginner Friendly
- **Clickable buttons** - Waybar has Apps, Terminal, Files, Browser, and Code buttons
- **Window title bars** - Every window has close, maximize, and minimize buttons
- **Familiar apps** - Firefox, VS Code, Thunar file manager, VLC media player
- **Works with mouse** - No need to memorize keyboard shortcuts

### Developer Ready
- **Modern CLI tools** - fzf, ripgrep, lazygit, yazi, btop, and more
- **Languages** - Node.js, Python, Rust toolchains pre-installed
- **Containers** - Docker and Docker Compose ready to go
- **Git** - GitHub CLI and Lazygit for visual git workflows

### Portable
- **Live USB boot** - Runs entirely from USB, no installation
- **Persistence** (coming soon) - Save projects, configs, and API keys between reboots
- **Wide hardware support** - Intel, AMD, NVIDIA graphics + comprehensive WiFi drivers

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
3. Boot from USB (may need to enter BIOS and select USB boot)
4. Start coding!

## Included Software

### Desktop
| App | Description |
|-----|-------------|
| Hyprland | Tiling Wayland compositor |
| Waybar | Status bar with clickable buttons |
| Fuzzel | App launcher (Super+D or click "Apps") |
| Thunar | File manager |
| Foot | Terminal emulator |

### Development
| App | Description |
|-----|-------------|
| VS Code | Code editor |
| Neovim | Terminal editor with LSP |
| Git + GitHub CLI | Version control |
| Lazygit | Visual git interface |
| Docker | Container runtime |

### Apps
| App | Description |
|-----|-------------|
| Firefox | Web browser |
| Discord | Communication |
| VLC | Media player |
| imv | Image viewer |

### CLI Tools
`fzf` `ripgrep` `fd` `bat` `eza` `zoxide` `yazi` `btop` `jq` `tmux` `fastfetch`

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `Super + Return` | Open terminal |
| `Super + D` | Open app launcher |
| `Super + Q` | Close window |
| `Super + B` | Open Firefox |
| `Super + E` | Open file manager |
| `Super + C` | Open VS Code |
| `Super + 1-9` | Switch workspace |
| `Super + F` | Toggle fullscreen |
| `Super + V` | Toggle floating |
| `Print` | Screenshot region |

**Tip:** You can also use the buttons in the top bar instead of keyboard shortcuts!

## Hardware Support

### Graphics
- **Intel** - Full support (mesa, vulkan-intel)
- **AMD** - Full support (mesa, vulkan-radeon)
- **NVIDIA** - Supported (nvidia-open-dkms)

### WiFi
Includes drivers for Intel, Atheros, Broadcom, Realtek, Marvell, MediaTek, and Ralink chipsets. Most laptops should work out of the box.

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

Requires Arch Linux (VM or container):

```bash
# Clone the repository
git clone https://github.com/danupsher/jumpdev-os.git
cd jumpdev-os

# Build requires archiso
sudo pacman -S archiso

# Build the ISO (runs via GitHub Actions, or locally:)
sudo mkarchiso -v -w /tmp/archiso-work -o out/ archiso/
```

Or just push to main - GitHub Actions builds the ISO automatically.

## Roadmap

- [x] Gate 1: Bootable ISO with Hyprland desktop
- [x] Gate 2: Beginner-friendly GUI with apps
- [ ] Gate 3: Persistence wizard for saving data
- [ ] Gate 4: Polish, branding, and release
- [ ] Gate 5: ARM64/Apple Silicon support

## Contributing

Contributions welcome! See:
- `CLAUDE.md` - Guide for AI-assisted development sessions
- `COMPREHENSIVE_PLAN.md` - Full project roadmap
- `DECISIONS.md` - Architectural decisions
- `BUILD_LOG.md` - Build history and progress

## License

MIT License - see [LICENSE](LICENSE) for details.

## Acknowledgements

- [Arch Linux](https://archlinux.org/) and [Archiso](https://wiki.archlinux.org/title/Archiso)
- [Hyprland](https://hyprland.org/) and [hyprbars plugin](https://github.com/hyprwm/hyprland-plugins)
- [Catppuccin](https://github.com/catppuccin/catppuccin) theme
- [Chaotic-AUR](https://aur.chaotic.cx/) for pre-built AUR packages
