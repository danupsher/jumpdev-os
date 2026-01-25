# JumpDev OS

A portable Linux development environment with AI coding tools pre-installed. Runs from USB on any x86_64 machine.

---

## What is JumpDev OS?

A complete development environment that runs from a USB drive. Claude Code and a modern desktop, ready to go. No installation. No configuration.

Equipped for serious development. Great for developers leveraging AI or vibecoders building their first project.

---

## Why JumpDev?

### Clean & Focused
No bloat. A modern Hyprland desktop with what you need to code.

### Portable
Runs from USB on any PC. Your environment stays consistent across machines. Install to disk anytime to make it permanent.

### Persistent
Optional persistence saves files and settings between reboots.

---

## Features

### AI-Assisted Development
- **Claude Code** — Anthropic's AI coding assistant

### Desktop
- Hyprland with Catppuccin Mocha theme
- Keyboard and mouse friendly

### Tools
- Docker, Git, Neovim, Tmux
- Firefox
- Standard development utilities

---

## Quick Start

1. **Download** the latest ISO from [Releases](https://github.com/danupsher/jumpdev-os/releases)
2. **Flash** to a USB drive using Ventoy, Rufus, or Etcher
3. **Boot** from USB
4. **Code** — open a terminal and type `claude`

---

## Commands

```bash
jumpdev help          # Show all commands
jumpdev setup         # Run first-time setup
jumpdev set-api-key   # Configure your Anthropic API key
jumpdev doctor        # Check system health
```

---

## Requirements

- **USB drive**: 16GB+ recommended, USB 3.0 or faster
- **Machine**: x86_64 PC with USB boot support
- **API key**: Anthropic API key for Claude Code (console.anthropic.com)

---

## Status

In active development.

- [x] Bootable live environment
- [x] Claude Code pre-installed
- [x] Modern desktop
- [x] First-boot setup wizard
- [ ] Persistence on real hardware
- [ ] Install-to-disk option

### Roadmap
- ARM64 support

---

## License

MIT
