# JumpDev OS

[![Build ISO](https://github.com/danupsher/jumpdev-os/actions/workflows/build-iso.yml/badge.svg)](https://github.com/danupsher/jumpdev-os/actions/workflows/build-iso.yml)

**Your dev environment, on a USB stick.**

A portable Linux distribution for modern development. Boot from USB on any PC, get a fully configured workspace with AI coding tools, and migrate to disk when you're ready.

**Built for everyone** - not just Linux experts. Use the mouse, click buttons, learn shortcuts later if you want. Coming from Windows or Mac? You'll feel at home.

---

## Why JumpDev OS?

**The Problem**: You want to code with AI tools. But setting up a dev environment is overwhelming. Linux guides assume you already know Linux. Most distros are built for experts.

**The Solution**: JumpDev OS. Plug in a USB, boot up, and everything works. Click the Apps button, open VS Code, start coding. No terminal commands required to use the desktop. No memorizing shortcuts. Just a modern workspace that makes sense.

---

## Features

### Works Like You Expect
- **Click to launch apps** - Apps button in the corner, just like Windows/Mac
- **Window buttons** - Close, maximize, minimize on every window
- **Mouse-friendly** - Everything clickable, no commands required
- **Keyboard shortcuts** - Available for power users, never mandatory

### Portable Development
- Boot from USB on any x86_64 PC
- Your environment travels with you
- Files and logins persist between reboots
- Works offline - no cloud dependency

### AI-Powered Coding
- **Claude Code** - AI pair programming in your terminal
- **Aider** - Git-aware AI coding assistant
- **Ollama** - Run local LLMs offline
- Ready to vibe code out of the box

### Modern Desktop
- **Hyprland** - Tiling window manager with smooth animations
- **Window title bars** - Close, maximize, minimize buttons on every window
- **nwg-drawer** - App launcher with categories (like a Start menu)
- **Waybar** - Status bar with quick-launch buttons
- **Catppuccin Mocha** - Easy-on-the-eyes dark theme

### Development Stack
- **Editors**: VS Code + Neovim (LSP pre-configured)
- **Version Control**: Git, GitHub CLI, Lazygit
- **Containers**: Docker, Docker Compose
- **Languages**: Node.js, Python, Rust (rustup)
- **CLI Tools**: fzf, ripgrep, fd, bat, eza, zoxide, yazi, btop, tmux

### Portable → Permanent
Use JumpDev OS from USB for a day, a week, or a month. When you're ready to install permanently:

1. Click "Install to Disk"
2. Partition your drive (erase, dual-boot, or manual)
3. Everything migrates automatically:
   - Browser sessions and logins
   - App data and configurations
   - Projects and files
   - Installed packages

Same environment. Same logins. Just faster.

---

## Screenshots

*Coming soon*

---

## Quick Start

1. **Download** the latest ISO from [Releases](https://github.com/danupsher/jumpdev-os/releases)
2. **Flash** to USB with [Balena Etcher](https://etcher.balena.io/) or [Rufus](https://rufus.ie/)
3. **Boot** from USB (disable Secure Boot if needed)
4. **Code** - everything's ready

---

## Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| USB Drive | 16GB USB 3.0 | 32GB+ USB 3.0/3.1 |
| RAM | 8GB | 16GB |
| CPU | x86_64 | - |
| Boot | UEFI or Legacy BIOS | UEFI |

**Note**: Secure Boot must be disabled.

**USB Recommendations**:
| Tier | Example | Boot Time |
|------|---------|-----------|
| Good | Any USB 3.0 | ~60s |
| Better | SanDisk Extreme Pro | ~30s |
| Best | Samsung T7 SSD | ~15s |

---

## What's Included

### Desktop Environment
| Component | Description |
|-----------|-------------|
| Hyprland | Tiling Wayland compositor |
| Waybar | Status bar with quick-launch buttons |
| nwg-drawer | App launcher with categories |
| Fuzzel | Quick search launcher |
| Mako | Notification daemon |
| wlogout | Logout/power menu |

### Editors
| Editor | Description |
|--------|-------------|
| VS Code | Full GUI editor with extensions |
| Neovim | Terminal editor with LSP, Treesitter, Telescope |

### AI & Coding Tools
| Tool | Description |
|------|-------------|
| Claude Code | AI pair programming |
| Aider | Git-aware AI assistant |
| Ollama | Local LLM runner |
| GitHub CLI | GitHub from the terminal |
| Lazygit | Terminal UI for Git |

### Languages & Runtimes
| Language | Version |
|----------|---------|
| Node.js | Latest LTS |
| Python | 3.x with pip/pipx |
| Rust | Via rustup |

### Containers
| Tool | Description |
|------|-------------|
| Docker | Container runtime |
| Docker Compose | Multi-container apps |
| Docker Buildx | Extended build features |

### Applications
| App | Description |
|-----|-------------|
| Firefox | Web browser |
| Thunar | File manager |
| Discord | Communication |
| VLC | Media player |
| imv | Image viewer |
| pavucontrol | Audio settings |
| blueman | Bluetooth manager |

### CLI Tools
```
fzf        - Fuzzy finder
ripgrep    - Fast search
fd         - Fast find
bat        - Better cat
eza        - Better ls
zoxide     - Smart cd
yazi       - Terminal file manager
btop       - System monitor
jq/yq      - JSON/YAML tools
tmux       - Terminal multiplexer
fastfetch  - System info
```

---

## Keyboard Shortcuts (Optional)

**Everything has a button or menu option.** But if you want to go faster, these shortcuts are available:

### Quick Actions
| Key | Action | Or... |
|-----|--------|-------|
| `Super + Return` | Open terminal | Click "Term" in top bar |
| `Super + D` | App launcher | Click "Apps" in top bar |
| `Super + Q` | Close window | Click X button on window |
| `Super + F` | Toggle fullscreen | Click maximize button |

### Applications
| Key | Action | Or... |
|-----|--------|-------|
| `Super + B` | Firefox | Apps → Firefox |
| `Super + E` | File manager | Click "Files" in top bar |
| `Super + C` | VS Code | Click "Code" in top bar |

### Workspaces
| Key | Action |
|-----|--------|
| `Super + 1-9` | Switch workspace |
| `Super + Shift + 1-9` | Move window to workspace |

Don't want to learn shortcuts? **That's fine.** Use the mouse. The buttons are always there.

---

## Hardware Support

### Graphics
| Vendor | Driver | Status |
|--------|--------|--------|
| Intel | mesa, vulkan-intel | Full support |
| AMD | mesa, vulkan-radeon | Full support |
| NVIDIA | nvidia-open-dkms | Supported |

### WiFi
Drivers included for: Intel, Atheros, Broadcom, Realtek, Marvell, MediaTek, Ralink

Most laptops work out of the box.

### Audio
PipeWire with PulseAudio and JACK compatibility.

---

## Tech Stack

| Component | Choice |
|-----------|--------|
| Base | Arch Linux |
| Kernel | linux-zen |
| Display | Wayland |
| Compositor | Hyprland |
| Terminal | Foot |
| Shell | Zsh + Starship |
| Theme | Catppuccin Mocha |
| Font | JetBrains Mono Nerd Font |
| Icons | Papirus Dark |

---

## Roadmap

- [x] Gate 1: Bootable ISO with Hyprland desktop
- [x] Gate 2: Apps, dev tools, and polished UI
- [ ] Gate 3: Persistence (files/logins saved between reboots)
- [ ] Gate 3.5: Install to disk with seamless migration
- [ ] Gate 4: Polish, branding, and v1.0 release
- [ ] Gate 5: ARM64 / Apple Silicon support

---

## Building from Source

Requires Arch Linux (VM or container):

```bash
# Clone
git clone https://github.com/danupsher/jumpdev-os.git
cd jumpdev-os

# Install archiso
sudo pacman -S archiso

# Build
sudo mkarchiso -v -w /tmp/archiso-work -o out/ archiso/
```

Or just push to `main` - GitHub Actions builds the ISO automatically.

---

## Project Structure

```
jumpdev-os/
├── archiso/           # Archiso build configuration
│   ├── airootfs/      # Files copied to live system
│   ├── packages.x86_64 # Package list
│   └── profiledef.sh  # Build profile
├── configs/           # Application configs
│   ├── hypr/          # Hyprland
│   ├── waybar/        # Status bar
│   ├── nvim/          # Neovim
│   └── ...
└── .github/workflows/ # CI/CD
```

---

## Contributing

Contributions welcome! Read these first:

- `CLAUDE.md` - Guide for AI-assisted development sessions
- `COMPREHENSIVE_PLAN.md` - Full project roadmap and gates
- `DECISIONS.md` - Architectural decisions and rationale
- `BUILD_LOG.md` - Build history and known issues

---

## License

MIT License - see [LICENSE](LICENSE)

---

## Acknowledgements

Built on the shoulders of giants:

- [Arch Linux](https://archlinux.org/) & [Archiso](https://wiki.archlinux.org/title/Archiso)
- [Hyprland](https://hyprland.org/) & [hyprland-plugins](https://github.com/hyprwm/hyprland-plugins)
- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [Chaotic-AUR](https://aur.chaotic.cx/)
- [Neovim](https://neovim.io/)

---

<p align="center">
  <strong>Your dev environment, on a USB stick.</strong><br>
  Plug in. Boot up. Code.
</p>
