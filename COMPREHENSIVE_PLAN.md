# JumpDev OS Comprehensive Plan

## Executive Summary

JumpDev OS is a portable Arch Linux distribution optimised for AI-assisted software development. The system boots from USB, providing instant access to a fully configured development environment with Claude Code, modern CLI tools, and a Wayland-based tiling window manager.

**Target User**: Developers who want a consistent, portable coding environment with AI tools pre-configured.

**Unique Value**:
- Zero installation - boot from USB on any machine
- Pre-configured AI agent tooling (Claude Code, Aider, Ollama)
- Modern, keyboard-driven workflow (Hyprland + Neovim)
- Persistence support for projects and API keys

---

## Success Criteria

### MVP (Gate 3 Complete)
- [ ] Boots from USB on at least 3 different machines
- [ ] All core applications launch and function
- [ ] Claude Code authenticates and works
- [ ] Persistence saves files between reboots
- [ ] WiFi connects on tested hardware

### Production Release (Gate 4 Complete)
- [ ] Tested on 5+ machines with different hardware
- [ ] Sub-60 second boot to desktop
- [ ] First-boot wizard guides API key setup
- [ ] Professional branding and documentation
- [ ] Published ISO with SHA256 checksum

---

## Completion Gates

### Gate 1: Foundation
**Objective**: Bootable ISO that launches to Hyprland desktop

**Requirements**:
| Requirement | Verification | Status |
|-------------|--------------|--------|
| Archiso profile configured | `profiledef.sh` exists and valid | PENDING |
| Package list complete (base) | `packages.x86_64` includes all deps | PENDING |
| ISO builds without errors | `build-iso.sh` exits 0 | PENDING |
| Boots in QEMU (UEFI) | Manual test | PENDING |
| Boots in QEMU (BIOS) | Manual test | PENDING |
| Hyprland starts | Desktop visible | PENDING |
| Waybar visible | Status bar renders | PENDING |
| Foot terminal opens | Super+Return launches terminal | PENDING |
| Fuzzel launcher works | Super+D opens launcher | PENDING |

**Deliverable**: `out/jumpdev-foundation-*.iso`

---

### Gate 2: Core Experience
**Objective**: Fully functional development environment

**Requirements**:
| Requirement | Verification | Status |
|-------------|--------------|--------|
| Zsh configured with Starship | Prompt renders correctly | PENDING |
| Neovim with LSP | Code completion works | PENDING |
| Git + GitHub CLI + Lazygit | All three functional | PENDING |
| Docker + Docker Compose | `docker run hello-world` passes | PENDING |
| Node.js + pnpm | `pnpm --version` works | PENDING |
| Python + uv | `uv --version` works | PENDING |
| Rust + Cargo | `cargo --version` works | PENDING |
| Claude Code installed | `claude` command available | PENDING |
| Aider installed | `aider --version` works | PENDING |
| Ollama installed | `ollama --version` works | PENDING |
| CLI tools (fzf, rg, fd, bat, eza, zoxide) | All commands available | PENDING |
| Yazi file manager | `yazi` launches | PENDING |
| Catppuccin theme applied | Visual consistency across apps | PENDING |

**Deliverable**: `out/jumpdev-core-*.iso`

---

### Gate 3: Portability
**Objective**: Working live USB with persistence

**Requirements**:
| Requirement | Verification | Status |
|-------------|--------------|--------|
| Persistence partition detection | Auto-mounts `JUMPDEV_PERSIST` label | PENDING |
| Overlay filesystem working | Changes survive reboot | PENDING |
| First-boot wizard | Prompts for API keys on first run | PENDING |
| API keys stored securely | Keys in persistence, correct perms | PENDING |
| WiFi firmware included | `linux-firmware` + extras | PENDING |
| WiFi connects | Manual test on real hardware | PENDING |
| Boots on real hardware (Machine 1) | Document specs | PENDING |
| Boots on real hardware (Machine 2) | Document specs | PENDING |
| Boots on real hardware (Machine 3) | Document specs | PENDING |
| USB 3.0 performance acceptable | Subjective but usable | PENDING |

**Deliverable**: `out/jumpdev-portable-*.iso` + tested USB image

---

### Gate 4: Polish
**Objective**: Release-ready distribution

**Requirements**:
| Requirement | Verification | Status |
|-------------|--------------|--------|
| Custom boot splash | Plymouth theme or GRUB splash | PENDING |
| Custom wallpaper | Branded desktop background | PENDING |
| Custom Neofetch/Fastfetch | Shows JumpDev OS branding | PENDING |
| README.md complete | Installation, usage, troubleshooting | PENDING |
| Hardware compatibility doc | Tested machines list | PENDING |
| Secure Boot documentation | Clear disable instructions | PENDING |
| ISO published | Available for download | PENDING |
| SHA256 checksum provided | Verification possible | PENDING |
| Boots on 5+ machines | Expanded hardware testing | PENDING |
| Boot time < 60 seconds | Measured on USB 3.0 | PENDING |

**Deliverable**: `jumpdev-1.0.0.iso` + documentation

---

## Package Registry

### Base System
```
base
base-devel
linux-zen
linux-zen-headers
linux-firmware
intel-ucode
amd-ucode
efibootmgr
grub
mkinitcpio
mkinitcpio-archiso
```

### Display Stack
```
hyprland
xdg-desktop-portal-hyprland
waybar
fuzzel
mako
grim
slurp
wl-clipboard
xorg-xwayland
```

### Terminal & Shell
```
foot
zsh
starship
```

### Editors
```
neovim
```

### Development Tools
```
git
github-cli
lazygit
docker
docker-compose
docker-buildx
nodejs
npm
python
python-pip
rustup
```

### CLI Utilities
```
fzf
ripgrep
fd
bat
eza
zoxide
yazi
btop
jq
yq
curl
wget
unzip
zip
```

### Fonts & Theming
```
ttf-jetbrains-mono-nerd
noto-fonts
noto-fonts-emoji
```

### Network & Hardware
```
networkmanager
iwd
bluez
bluez-utils
pipewire
pipewire-alsa
pipewire-pulse
wireplumber
mesa
vulkan-intel
vulkan-radeon
nvidia-open-dkms
nvidia-utils
```

### AI/Agent Tools (Manual Installation)
```
# These require special handling - not in official repos
# Claude Code: npm install -g @anthropic-ai/claude-code
# Aider: pipx install aider-chat
# Ollama: curl -fsSL https://ollama.com/install.sh | sh
```

---

## Configuration Registry

| Application | Config Location | Source in Repo |
|-------------|-----------------|----------------|
| Hyprland | `~/.config/hypr/hyprland.conf` | `configs/hyprland/` |
| Waybar | `~/.config/waybar/` | `configs/waybar/` |
| Foot | `~/.config/foot/foot.ini` | `configs/foot/` |
| Neovim | `~/.config/nvim/` | `configs/nvim/` |
| Zsh | `~/.zshrc`, `~/.zshenv` | `configs/zsh/` |
| Starship | `~/.config/starship.toml` | `configs/starship/` |
| Fuzzel | `~/.config/fuzzel/fuzzel.ini` | `configs/fuzzel/` |
| Yazi | `~/.config/yazi/` | `configs/yazi/` |
| Btop | `~/.config/btop/` | `configs/btop/` |
| Lazygit | `~/.config/lazygit/` | `configs/lazygit/` |
| Git | `~/.gitconfig` | `configs/git/` |

---

## Keybind Reference

### Hyprland (Default)
| Key | Action |
|-----|--------|
| `Super + Return` | Open terminal (Foot) |
| `Super + D` | Open launcher (Fuzzel) |
| `Super + Q` | Close window |
| `Super + V` | Toggle floating |
| `Super + F` | Toggle fullscreen |
| `Super + 1-9` | Switch workspace |
| `Super + Shift + 1-9` | Move window to workspace |
| `Super + Arrow` | Focus direction |
| `Super + Shift + Arrow` | Move window |

### Neovim (Custom)
| Key | Action |
|-----|--------|
| `Space` | Leader key |
| `Space + ff` | Find files (Telescope) |
| `Space + fg` | Live grep |
| `Space + e` | File explorer |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `Space + ca` | Code actions |

---

## Risk Register

| Risk | Impact | Mitigation |
|------|--------|------------|
| NVIDIA driver issues | High - black screen | Include fallback to nouveau, document nomodeset |
| WiFi not working | High - unusable on laptops | Include broad firmware, document known-working adapters |
| Secure Boot blocking boot | Medium - user confusion | Clear documentation, consider shim signing later |
| USB 2.0 too slow | Medium - poor UX | Document USB 3.0 requirement, test minimum viable |
| Archiso breaking changes | Medium - build fails | Pin archiso version or document working version |
| Package repo changes | Low - missing packages | Use explicit versions where possible |

---

## Timeline (Estimated)

| Phase | Target |
|-------|--------|
| Gate 1: Foundation | End of Week 1 |
| Gate 2: Core Experience | End of Week 2 |
| Gate 3: Portability | End of Week 3 |
| Gate 4: Polish | End of Week 4 |
| Buffer / Hardware Testing | Week 5-6 |

---

## Next Actions

1. Set up Arch Linux VM for Archiso development
2. Create base `profiledef.sh` and `packages.x86_64`
3. Build minimal bootable ISO
4. Configure Hyprland + Waybar + Foot
5. Test in QEMU
6. Iterate until Gate 1 complete
