# JumpDev OS Comprehensive Plan

## Executive Summary

JumpDev OS is a portable Arch Linux distribution optimised for AI-assisted software development. The system boots from USB, providing instant access to a fully configured development environment with Claude Code, modern CLI tools, and a Wayland-based tiling window manager.

**Target User**: Developers who want a consistent, portable coding environment with AI tools pre-configured.

**Unique Value**:
- Zero installation - boot from USB on any machine
- Multi-architecture support (x86_64 + ARM64 for Apple Silicon)
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
| Archiso profile configured | `profiledef.sh` exists and valid | DONE |
| Package list complete (base) | `packages.x86_64` includes all deps | DONE |
| ISO builds without errors | `build-iso.sh` exits 0 | DONE |
| Boots in QEMU (UEFI) | Manual test | DONE |
| Boots in QEMU (BIOS) | Manual test | PENDING |
| Hyprland starts | Desktop visible | DONE |
| Waybar visible | Status bar renders | DONE |
| Foot terminal opens | Super+Return launches terminal | TESTING |
| Fuzzel launcher works | Super+D opens launcher | TESTING |

**Deliverable**: `out/jumpdev-foundation-*.iso`

---

### Gate 2: Core Experience
**Objective**: Fully functional development environment with beginner-friendly UI

**Requirements**:
| Requirement | Verification | Status |
|-------------|--------------|--------|
| Zsh configured with Starship | Prompt renders correctly | DONE |
| Neovim with LSP | Code completion works | DONE |
| Git + GitHub CLI + Lazygit | All three functional | DONE |
| Docker + Docker Compose | `docker run hello-world` passes | PENDING |
| Node.js + npm | `npm --version` works | DONE |
| Python + pip/pipx | `pip --version` works | DONE |
| Rust + Cargo | `cargo --version` works (via rustup) | DONE |
| Claude Code installed | `claude` command available | PENDING |
| Aider installed | `aider --version` works | PENDING |
| Ollama installed | `ollama --version` works | PENDING |
| CLI tools (fzf, rg, fd, bat, eza, zoxide) | All commands available | DONE |
| Yazi file manager | `yazi` launches | DONE |
| Catppuccin theme applied | Visual consistency across apps | DONE |

**Beginner-Friendly UI Requirements**:
| Requirement | Verification | Status |
|-------------|--------------|--------|
| Web browser | Firefox launches with Super+B | DONE |
| File manager (GUI) | Thunar launches with Super+E | DONE |
| App launcher | Fuzzel opens with Super+D | TESTING |
| Logout menu | wlogout installed | DONE |
| Volume control GUI | pavucontrol installed | DONE |
| Bluetooth GUI | blueman installed | DONE |
| Network manager applet | nm-applet available | DONE |
| Screenshot tool | grim/slurp/flameshot installed | DONE |
| Dock bar | nwg-dock-hyprland (AUR, first-boot) | PENDING |
| App grid launcher | nwg-drawer (AUR, first-boot) | PENDING |

**Communication Apps**:
| App | Status |
|-----|--------|
| Discord | DONE (via Chaotic-AUR) |

**Media Apps**:
| App | Status |
|-----|--------|
| VLC | DONE |
| imv (image viewer) | DONE |

**Deliverable**: `out/jumpdev-core-*.iso`

---

### Gate 3: Portability
**Objective**: Working live USB with persistence - users stay logged in, files saved

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

**Persistence Approach**:
Ship two formats for different use cases:

| Format | Size | Use Case |
|--------|------|----------|
| `jumpdev-x.x.x-x86_64.iso` | ~4GB | Trying it out, no persistence |
| `jumpdev-x.x.x-x86_64-persistent.img` | ~12GB | Daily driver, persistence built-in |

**IMG format benefits**:
- Zero setup for users - flash and boot, persistence just works
- Same flashing tools (Balena Etcher, Rufus, dd)
- No hardware compatibility difference vs ISO
- App logins (Discord, Firefox), API keys, files all persist across reboots

**Technical implementation**:
- IMG contains two partitions: boot (squashfs) + persistence (ext4)
- Boot scripts detect persistence partition by label `JUMPDEV_PERSIST`
- Overlay filesystem merges read-only base with writable persistence
- Home directory lives on persistence partition

**Deliverable**: `jumpdev-x.x.x-x86_64.iso` + `jumpdev-x.x.x-x86_64-persistent.img`

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
| USB drive recommendations | Document in README | PENDING |

**USB Drive Recommendations (for README)**:
| Tier | Drive | Price | Experience |
|------|-------|-------|------------|
| Minimum | Any USB 3.0 drive | ~$10 | Usable, 60-90s boot |
| Recommended | SanDisk Extreme Pro / Samsung FIT Plus | ~$20-30 | Good, 30-60s boot |
| Best | Samsung T7 portable SSD | ~$60 | Excellent, 15-20s boot |

**Key points for docs**:
- USB 3.0 port required (USB 2.0 = painful)
- 16GB+ RAM recommended for smooth experience
- Cheap USB drives have slow random I/O - worth spending $20 on a good one
| Hardware compatibility doc | Tested machines list | PENDING |
| Secure Boot documentation | Clear disable instructions | PENDING |
| ISO published | Available for download | PENDING |
| SHA256 checksum provided | Verification possible | PENDING |
| Boots on 5+ machines | Expanded hardware testing | PENDING |
| Boot time < 60 seconds | Measured on USB 3.0 | PENDING |

**Deliverable**: `jumpdev-1.0.0-x86_64.iso` + documentation

---

### Gate 5: ARM64 Support (Apple Silicon)
**Objective**: Native ARM64 ISO for Apple Silicon Macs

**Requirements**:
| Requirement | Verification | Status |
|-------------|--------------|--------|
| Arch Linux ARM base working | Boots in UTM/QEMU ARM | PENDING |
| ARM64 package list created | `packages.aarch64` exists | PENDING |
| Asahi Linux drivers evaluated | WiFi, GPU acceleration research | PENDING |
| Hyprland works on ARM64 | Desktop renders | PENDING |
| All dev tools available | Same toolset as x86_64 | PENDING |
| GitHub Actions ARM64 build | CI builds both architectures | PENDING |
| Tested on M1 Mac | Boot from USB | PENDING |
| Tested on M2/M3 Mac | Boot from USB | PENDING |

**Challenges**:
- Apple Silicon requires Asahi Linux work for full hardware support
- Some packages may not be available for ARM64
- USB boot on Apple Silicon requires specific setup
- GPU acceleration via Asahi drivers

**Approach Options**:
1. **Asahi Linux base** - Best hardware support, more complex
2. **Arch Linux ARM** - Standard Arch, limited Apple hardware support
3. **Fedora Asahi Remix** - Consider as alternative base for ARM

**Deliverable**: `jumpdev-1.0.0-aarch64.iso` + Apple Silicon setup guide

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
xdg-desktop-portal-gtk
waybar
fuzzel
mako
grim
slurp
swappy
wl-clipboard
xorg-xwayland
qt5-wayland
qt6-wayland
```

### GUI Applications (Beginner-Friendly)
```
firefox
chromium
thunar
thunar-volman
thunar-archive-plugin
gvfs
gvfs-mtp
tumbler
ffmpegthumbnailer
wlogout
pavucontrol
blueman
brightnessctl
playerctl
network-manager-applet
nm-connection-editor
flameshot
discord
telegram-desktop
vlc
mpv
imv
zenity
```

### AUR Packages (First-Boot Install)
```
# Install via yay/paru after first boot
nwg-dock-hyprland     # Dock bar
nwg-drawer            # App grid launcher
nwg-look              # GTK theme settings
swayosd               # On-screen display for volume/brightness
slack-desktop         # Slack
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

### Network & WiFi (Comprehensive Support)
```
networkmanager
iwd
wireless-regdb
wpa_supplicant
openssh
openvpn
wireguard-tools
broadcom-wl-dkms
linux-firmware-marvell
usb_modeswitch
modemmanager
```

### Bluetooth
```
bluez
bluez-utils
```

### Audio
```
pipewire
pipewire-alsa
pipewire-pulse
pipewire-jack
wireplumber
```

### Graphics
```
mesa
vulkan-icd-loader
libva-mesa-driver
vulkan-intel
intel-media-driver
vulkan-radeon
xf86-video-amdgpu
nvidia-open-dkms
nvidia-utils
nvidia-settings
```

### Hardware Support
```
acpi
acpid
tlp
upower
power-profiles-daemon
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
| Hyprland | `~/.config/hypr/hyprland.conf` | `configs/hypr/` |
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

### Hyprland - Core
| Key | Action |
|-----|--------|
| `Super + Return` | Open terminal (Foot) |
| `Super + D` | Open launcher (Fuzzel) |
| `Super + Q` | Close window |
| `Super + V` | Toggle floating |
| `Super + F` | Toggle fullscreen |
| `Super + Shift + E` | Exit Hyprland |

### Hyprland - Applications
| Key | Action |
|-----|--------|
| `Super + B` | Open browser (Firefox) |
| `Super + E` | Open file manager (Thunar) |
| `Print` | Screenshot region to clipboard |
| `Shift + Print` | Screenshot full screen to clipboard |

### Hyprland - Window Navigation
| Key | Action |
|-----|--------|
| `Super + H/J/K/L` | Focus left/down/up/right |
| `Super + Arrow` | Focus direction |
| `Super + Shift + H/J/K/L` | Move window |
| `Super + Shift + Arrow` | Move window |
| `Super + 1-9` | Switch workspace |
| `Super + Shift + 1-9` | Move window to workspace |

### Hyprland - Media Keys
| Key | Action |
|-----|--------|
| `XF86AudioRaiseVolume` | Volume up 5% |
| `XF86AudioLowerVolume` | Volume down 5% |
| `XF86AudioMute` | Toggle mute |
| `XF86MonBrightnessUp` | Brightness up 5% |
| `XF86MonBrightnessDown` | Brightness down 5% |

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
| Apple Silicon support incomplete | High - limited M1/M2/M3 use | Track Asahi Linux progress, document limitations |
| ARM64 package availability | Medium - missing tools | Identify alternatives or build from source |

---

## Timeline (Estimated)

| Phase | Target |
|-------|--------|
| Gate 1: Foundation (x86_64) | End of Week 1 |
| Gate 2: Core Experience | End of Week 2 |
| Gate 3: Portability | End of Week 3 |
| Gate 4: Polish | End of Week 4 |
| Buffer / Hardware Testing | Week 5-6 |
| Gate 5: ARM64 Support | Week 7-10 |

---

## Next Actions

1. Set up Arch Linux VM for Archiso development
2. Create base `profiledef.sh` and `packages.x86_64`
3. Build minimal bootable ISO
4. Configure Hyprland + Waybar + Foot
5. Test in QEMU
6. Iterate until Gate 1 complete
