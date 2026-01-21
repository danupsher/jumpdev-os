# JumpDev OS

A portable Linux distribution for vibe coding and AI-assisted development. Boot from USB, jump into any machine, and start building with Claude Code.

## What is JumpDev OS?

JumpDev OS is a live USB Arch Linux distribution designed for developers who want a consistent, portable coding environment with AI tools pre-configured. Plug it into any PC, boot up, and you're in a fully configured workspace with:

- **Claude Code** - AI pair programming in your terminal
- **Hyprland** - Modern tiling Wayland compositor
- **Neovim** - Pre-configured with LSP and modern plugins
- **Modern CLI tools** - fzf, ripgrep, lazygit, yazi, and more

No installation required. Your environment travels with you.

## Features

- **Live USB boot** - No installation, runs entirely from USB
- **Persistence** - Dedicated partition saves projects, configs, and API keys
- **AI-first tooling** - Claude Code, Aider, and Ollama pre-installed
- **Modern stack** - Wayland, Hyprland, Foot terminal, Zsh + Starship
- **Developer ready** - Git, Docker, Node.js, Python, Rust out of the box
- **Consistent theming** - Catppuccin Mocha across all applications

## Requirements

- USB 3.0 drive (16GB minimum, 32GB recommended)
- 8GB RAM minimum (16GB recommended)
- x86_64 system with UEFI or Legacy BIOS
- Secure Boot must be disabled

## Quick Start

1. Download the latest ISO from [Releases](https://github.com/danupsher/jumpdev-os/releases)
2. Verify the checksum: `sha256sum -c jumpdev-*.iso.sha256`
3. Write to USB:
   ```bash
   sudo dd if=jumpdev-*.iso of=/dev/sdX bs=4M status=progress oflag=sync
   ```
4. Boot from USB (may need to disable Secure Boot)
5. Run first-boot wizard to configure API keys

## Default Keybinds

| Key | Action |
|-----|--------|
| `Super + Return` | Open terminal |
| `Super + D` | Open launcher |
| `Super + Q` | Close window |
| `Super + 1-9` | Switch workspace |
| `Super + F` | Toggle fullscreen |

## Persistence

To enable persistence between reboots:

1. Create an ext4 partition on your USB drive
2. Label it `JUMPDEV_PERSIST`
3. JumpDev OS will auto-detect and mount it

Your projects, dotfiles, and API keys will survive reboots.

## Building from Source

Requires Arch Linux (VM or container):

```bash
# Install archiso
sudo pacman -S archiso

# Clone the repository
git clone https://github.com/danupsher/jumpdev-os.git
cd jumpdev-os

# Build the ISO
sudo ./scripts/build-iso.sh

# Test in QEMU
./scripts/test-qemu.sh
```

## Tech Stack

| Component | Choice |
|-----------|--------|
| Base | Arch Linux |
| Display | Wayland + Hyprland |
| Terminal | Foot |
| Shell | Zsh + Starship |
| Editor | Neovim |
| Theme | Catppuccin Mocha |
| Font | JetBrains Mono Nerd Font |

## Contributing

Contributions welcome! Please read the existing documentation:

- `CLAUDE.md` - Session guide for AI-assisted development
- `COMPREHENSIVE_PLAN.md` - Project roadmap and gates
- `DECISIONS.md` - Architectural decisions

## License

MIT License - see [LICENSE](LICENSE) for details.

## Acknowledgements

- [Arch Linux](https://archlinux.org/) and [Archiso](https://wiki.archlinux.org/title/Archiso)
- [Hyprland](https://hyprland.org/)
- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [Claude Code](https://claude.ai/code) by Anthropic
