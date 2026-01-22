# JumpDev OS - Claude Session Guide

> **START HERE** - Read this file at the beginning of every session.

## Session Checklist

1. Read `BUILD_LOG.md` for current progress and context
2. Check `DECISIONS.md` before proposing architectural changes
3. Review `COMPREHENSIVE_PLAN.md` for current phase and gate requirements
4. Run verification: `./scripts/verify.sh` (when available)

## Project Overview

JumpDev OS is a portable Arch Linux distribution designed for AI-assisted development and vibe coding. It boots from USB, providing any machine with a complete agent-driven coding environment featuring Claude Code, modern CLI tools, and a tiling Wayland compositor.

**Primary Goal**: Create a distributable ISO that boots to a fully configured development environment with persistence support.

## Market Position

**The Opportunity**: AI-assisted coding (vibe coding) is bringing a new wave of people into development. These users are not veteran developers - they're normal people who expect a normal desktop experience.

**Competitive Landscape**:
- **Omarchy** (by DHH/37signals) targets experienced developers switching from Mac. Keyboard-driven, assumes Linux expertise.
- **JumpDev OS** targets the broader audience discovering coding through AI. Approachable desktop with buttons and menus, plus keyboard shortcuts for power users.

**Our Differentiators**:
1. Portable USB environment (boot anywhere)
2. Seamless USB → disk migration with all data
3. AI tools pre-installed (Claude Code, Aider, Ollama)
4. Approachable for newcomers, powerful for experts

**The Vision**: Be the operating system people reach for when they want to build things with AI - whether they've used Linux before or not.

**The User Journey**: New users start with the approachable UI - buttons, menus, window controls. As they grow into serious developers, they discover keyboard shortcuts, tiling workflows, terminal tools. The system is just as powerful as any expert-focused distro - Hyprland, Neovim, full CLI toolkit. Users don't outgrow JumpDev OS, they grow with it.

## Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                        JumpDev OS ISO                                │
├─────────────────────────────────────────────────────────────────────┤
│  Boot Layer                                                          │
│  ├── GRUB/systemd-boot (UEFI + Legacy BIOS)                         │
│  ├── Kernel + initramfs (linux-zen recommended)                     │
│  └── Persistence detection (optional partition)                      │
├─────────────────────────────────────────────────────────────────────┤
│  Display Stack                                                       │
│  ├── Wayland compositor (Hyprland)                                  │
│  ├── Status bar (Waybar)                                            │
│  ├── App launcher (nwg-drawer)                                      │
│  └── Notifications (mako)                                           │
├─────────────────────────────────────────────────────────────────────┤
│  Terminal Environment                                                │
│  ├── Foot terminal                                                  │
│  ├── Zsh + Starship prompt                                          │
│  ├── Neovim (primary editor)                                        │
│  └── CLI tools (fzf, ripgrep, fd, bat, eza, zoxide, yazi)          │
├─────────────────────────────────────────────────────────────────────┤
│  AI/Agent Tools                                                      │
│  ├── Claude Code (primary)                                          │
│  ├── Aider                                                          │
│  └── Ollama (local models)                                          │
├─────────────────────────────────────────────────────────────────────┤
│  Development Stack                                                   │
│  ├── Git, GitHub CLI, Lazygit                                       │
│  ├── Docker, Docker Compose                                         │
│  ├── Node.js + pnpm                                                 │
│  ├── Python + uv                                                    │
│  └── Rust + Cargo                                                   │
└─────────────────────────────────────────────────────────────────────┘
```

## Directory Structure

```
jumpdev-os/
├── archiso/                    # Archiso build configuration
│   ├── airootfs/              # Files copied to live system root
│   │   ├── etc/               # System configuration
│   │   │   ├── skel/          # User skeleton (dotfiles)
│   │   │   └── systemd/       # Service files
│   │   └── usr/               # User programs and data
│   │       ├── local/bin/     # Custom scripts
│   │       └── share/         # Shared data (desktop files, etc)
│   ├── packages.x86_64        # Package list for ISO
│   ├── pacman.conf            # Pacman configuration
│   └── profiledef.sh          # Archiso profile definition
├── configs/                    # Application configurations
│   ├── hypr/                  # Hyprland compositor config (MUST be 'hypr' not 'hyprland')
│   ├── waybar/                # Status bar config
│   ├── foot/                  # Terminal config
│   ├── nvim/                  # Neovim configuration
│   ├── zsh/                   # Zsh configuration
│   ├── starship/              # Prompt configuration
│   ├── fuzzel/                # Launcher configuration
│   ├── yazi/                  # File manager configuration
│   ├── btop/                  # System monitor configuration
│   ├── lazygit/               # Git UI configuration
│   └── catppuccin/            # Theme files (reference)
├── scripts/                    # Build and utility scripts
│   ├── build-iso.sh           # Main ISO build script
│   ├── setup-persistence.sh   # Persistence partition setup
│   ├── first-boot.sh          # First boot wizard
│   └── verify.sh              # Verification/gate checks
├── docs/                       # Additional documentation
├── assets/                     # Visual assets
│   ├── wallpapers/            # Desktop wallpapers
│   └── branding/              # Logos, boot splash
├── tests/                      # Test scripts and fixtures
├── CLAUDE.md                   # This file - session guide
├── BUILD_LOG.md                # Build progress tracking
├── DECISIONS.md                # Architectural decisions
└── COMPREHENSIVE_PLAN.md       # Full project plan with gates
```

## Key Files Reference

| File | Purpose | When to Modify |
|------|---------|----------------|
| `archiso/packages.x86_64` | Package list for ISO | Adding/removing packages |
| `archiso/profiledef.sh` | Archiso profile config | Changing ISO metadata |
| `archiso/airootfs/etc/skel/` | User dotfiles | Changing default configs |
| `configs/hypr/hyprland.conf` | WM configuration | Keybinds, layout, appearance |
| `configs/nvim/init.lua` | Neovim configuration | Editor setup, plugins |
| `scripts/build-iso.sh` | ISO build process | Build pipeline changes |
| `scripts/first-boot.sh` | First boot wizard | Onboarding flow |

## Build Commands

```bash
# Build the ISO (requires root, run in Arch VM/container)
sudo ./scripts/build-iso.sh

# Test ISO in QEMU
./scripts/test-qemu.sh out/jumpdev-*.iso

# Verify current gate requirements
./scripts/verify.sh

# Clean build artifacts
./scripts/clean.sh
```

## Common Gotchas

### Archiso
- Must build on Arch Linux (VM or container acceptable)
- `airootfs` files are copied with preserved permissions - ensure correct modes
- Package list must include all dependencies; no AUR packages directly (use custom repo or build in airootfs)

### Hyprland/Wayland
- **Config directory is `~/.config/hypr/` NOT `~/.config/hyprland/`** - this is a common mistake
- No X11 applications without XWayland (included by default)
- Environment variables must be set for Wayland compatibility
- NVIDIA requires specific configuration (nvidia-drm.modeset=1)

### Persistence
- Persistence partition must be labeled `JUMPDEV_PERSIST` for auto-detection
- Sensitive data (API keys) should be in persistence, not ISO
- Overlay filesystem used to merge persistence with squashfs

### Hardware Compatibility
- WiFi firmware packages: `linux-firmware`, `broadcom-wl` (if needed)
- GPU: Mesa for AMD/Intel, nvidia-open for NVIDIA
- Secure Boot must be disabled on target machines (document in README)

## Testing Checklist

Before marking a gate complete:

- [ ] ISO builds without errors
- [ ] Boots in QEMU (UEFI mode)
- [ ] Boots in QEMU (BIOS mode)
- [ ] Desktop environment loads
- [ ] Terminal opens and shell works
- [ ] Network connectivity (QEMU virtio-net)
- [ ] All keybinds functional
- [ ] Theme applied consistently

## Emergency Procedures

### Build Fails
1. Check `BUILD_LOG.md` for known issues
2. Verify package names in `packages.x86_64` are current
3. Run `pacman -Sy` to update package database in build environment
4. Check Archiso documentation for breaking changes

### Boot Fails
1. Add `nomodeset` to kernel parameters for GPU issues
2. Try BIOS mode if UEFI fails (or vice versa)
3. Boot with verbose output: remove `quiet` from kernel params
4. Check journalctl in recovery: `journalctl -xb`

---

**Remember**: Update `BUILD_LOG.md` at the end of every session with progress made and any issues encountered.
