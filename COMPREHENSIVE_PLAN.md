# JumpDev OS Comprehensive Plan

## Executive Summary

JumpDev OS is a portable Arch Linux distribution for developers. Boot from USB on any PC with a fully configured environment - editors, containers, languages, AI tools. Use it portable, then seamlessly migrate to disk when you're ready.

**Target User**: Developers who work on multiple machines or want a consistent, ready-to-go environment.

**Why JumpDev OS Exists**: Setting up a dev environment is tedious. Doing it on every machine is worse. JumpDev OS is your environment on a USB stick - same tools, same configs, anywhere.

---

## Killer Features

| Feature | Why It Matters | Competition |
|---------|----------------|-------------|
| **Portable dev environment** | Your whole setup travels. Same on any PC. | VMs are slow, cloud needs internet |
| **USB → Disk migration** | Use portable, graduate to permanent. All data migrates. | No distro does this well |
| **Everything pre-configured** | Editors, containers, languages, AI tools - ready at boot | Hours of setup on other distros |
| **AI tools included** | Claude Code, Aider, Ollama out of the box | Everyone else: DIY setup |
| **Approachable desktop** | Normal desktop experience with buttons and menus | Most dev distros assume Linux expertise |

**The Pitch**:
> "Your dev environment, on a USB stick. Boot from USB on any PC. Same tools, same configs, same projects. Migrate to disk when you're ready."

---

## Target Users

**Primary: Normal people vibe coding with AI**
- NOT veteran developers - people discovering coding through AI
- Coming from Windows/Mac - expect mouse-driven interfaces
- Don't know Linux - shouldn't need to learn it to use the desktop
- Want to build things - not configure things

**Secondary:**
- Developers who work on multiple machines - consistent environment
- Students/bootcampers - plug in at any computer lab
- Windows/Mac users curious about Linux - low-commitment way to try it
- Contractors - plug into client machine, code securely

## Design Philosophy

**Approachable by default.** Window buttons, app launcher, status bar with quick actions. Keyboard shortcuts available for power users.

**Different from Omarchy:** Omarchy targets veteran devs switching from Mac. JumpDev OS targets the broader audience discovering coding through AI - people who expect a normal desktop experience.

**Grow with the system:** New users start with buttons and menus. As they become serious developers, they discover shortcuts, tiling workflows, and terminal tools. The system is just as powerful as any expert distro - Hyprland, Neovim, full CLI toolkit. Users don't outgrow JumpDev OS, they grow with it.

---

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
| Kitty terminal opens | Super+Return launches terminal | DONE |
| nwg-menu launcher works | Super+D opens menu | DONE |

**Deliverable**: `out/jumpdev-foundation-*.iso`

---

### Gate 2: Core Experience
**Objective**: Fully functional development environment with beginner-friendly UI

**Requirements**:
| Requirement | Verification | Status |
|-------------|--------------|--------|
| Zsh configured with Starship | Prompt renders correctly | DONE |
| Neovim with LSP | Code completion works | DONE |
| VS Code | Available via first-boot selector | MOVED |
| Git + GitHub CLI + Lazygit | All three functional | DONE |
| Docker + Docker Compose | `docker run hello-world` passes | PENDING |
| Node.js + npm | `npm --version` works | DONE |
| Python + pip/pipx | `pip --version` works | DONE |
| Rust + Cargo | `cargo --version` works (via rustup) | DONE |
| Claude Code installed | `claude` command available | PENDING (Build 10) |
| Aider installed | `aider --version` works | PENDING (Build 10) |
| Ollama installed | `ollama --version` works | PENDING (Build 10) |
| CLI tools (fzf, rg, fd, bat, eza, zoxide) | All commands available | DONE |
| Yazi file manager | `yazi` launches | DONE |
| Catppuccin theme applied | Visual consistency across apps | DONE |
| `jumpdev` helper command | `jumpdev help` works | PENDING |

**Beginner-Friendly UI Requirements**:
| Requirement | Verification | Status |
|-------------|--------------|--------|
| Web browser | Firefox launches with Super+B | DONE |
| File manager (GUI) | Thunar launches with Super+E | DONE |
| App launcher | nwg-menu opens with Super+D | DONE |
| Logout menu | wlogout installed | DONE |
| Volume control GUI | pavucontrol installed | DONE |
| Bluetooth GUI | blueman installed | DONE |
| Network manager applet | nm-applet available | DONE |
| Screenshot tool | grim/slurp/flameshot installed | DONE |
| Dock bar | nwg-dock-hyprland (optional, first-boot) | PENDING |

**Communication Apps**:
| App | Status |
|-----|--------|
| Discord | Available via first-boot selector |

**Media Apps**:
| App | Status |
|-----|--------|
| mpv | DONE |
| imv (image viewer) | DONE |

**`jumpdev` Helper Command** (inspired by Bluefin's `ujust`):
Simple CLI tool for common tasks - makes setup easy for beginners.

| Command | Action |
|---------|--------|
| `jumpdev help` | Show all available commands |
| `jumpdev setup` | Run first-time setup wizard |
| `jumpdev install-claude` | Install/update Claude Code |
| `jumpdev install-aider` | Install/update Aider |
| `jumpdev install-ollama` | Install Ollama + pull common models |
| `jumpdev set-api-key` | Configure API keys (Anthropic, OpenAI) |
| `jumpdev update` | Update system + all dev tools |
| `jumpdev doctor` | Check system health, report issues |
| `jumpdev reset` | Reset to defaults (keeps persistence) |

**Editor Choice**:
| Editor | Use Case | Launch |
|--------|----------|--------|
| VS Code | GUI, beginners, devcontainers | `code .` or Super+C |
| Neovim | Terminal, keyboard purists | `nvim` or Super+N |

**Devcontainer Support**:
- VS Code devcontainers extension pre-installed
- Docker ready for container-based development
- Clone repo → open in VS Code → "Reopen in Container" just works

**AI Tools Installation (Build 10)**:
Pre-install during CI so users have everything out of the box:

| Tool | Install Method | Size |
|------|----------------|------|
| Claude Code | `npm install -g @anthropic-ai/claude-code` | ~50MB |
| Aider | `pipx install aider-chat` | ~100MB |
| Ollama | Binary install + base model | ~300MB |

All three will be ready at first boot. User just needs to add API keys via `jumpdev set-api-key`.

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
Standard ISO with first-boot wizard - familiar for users, easy setup.

**First-boot wizard flow**:
1. User flashes ISO to USB (Etcher, Rufus, dd - normal process)
2. First boot → Welcome wizard appears automatically
3. Wizard asks: "Save files and stay logged in between reboots?"
   - **Yes** → Creates `persistence.img` file on USB free space (~8GB)
   - **No** → Runs in demo mode, wizard won't ask again
4. If yes → Quick reboot to activate persistence
5. Second boot → "Setup complete!", optional API key configuration
6. Done → Wizard never appears again (flag in persistence)

**Why file-based persistence (not partition)**:
- No risky repartitioning while booted from USB
- Works regardless of how user flashed the ISO
- Simpler and safer than resizing partitions

**Technical implementation**:
- First-boot script detects if persistence exists
- If not, shows wizard (GTK dialog via zenity or custom app)
- Creates `persistence.img` file (ext4 formatted) on USB free space
- Boot scripts mount `persistence.img` as loop device
- Overlayfs merges: read-only squashfs + writable persistence.img
- Home directory and select system paths live on overlay

**What persists**:
- Home folder (~/.config, app logins, API keys, files)
- Installed packages (pacman database + cache)
- System settings changes

**Deliverable**: `jumpdev-x.x.x-x86_64.iso` (~4GB) + first-boot wizard

---

### Gate 3.5: Install to Disk (Migration)
**Objective**: Users can seamlessly migrate from USB to permanent HD installation

**Requirements**:
| Requirement | Verification | Status |
|-------------|--------------|--------|
| Calamares installer included | Package in ISO | PENDING |
| Calamares themed | Matches Catppuccin/JumpDev branding | PENDING |
| Partition manager works | Can erase, dual-boot, or manual partition | PENDING |
| Migration option appears | "Migrate from USB?" prompt post-install | PENDING |
| Home folder migrates | All configs, projects, app data copied | PENDING |
| Browser logins preserved | ~/.mozilla/firefox/ copied | PENDING |
| App logins preserved | ~/.config/* copied | PENDING |
| Extra packages reinstalled | Tracks user-installed packages, reinstalls | PENDING |
| User systemd services migrate | ~/.config/systemd/user/ copied | PENDING |
| System services tracked | Diff vs base ISO, re-enable on new install | PENDING |
| Migration summary shown | "Migrated X services, Y packages, Z GB" | PENDING |

**Migration Flow**:
1. User clicks "Install to Disk" (desktop icon or Apps menu)
2. Calamares opens with JumpDev branding
3. User partitions drive (erase / dual-boot / manual)
4. Base system installs
5. Post-install prompt: "Migrate your data from USB?"
   - **Yes** → Copies entire home folder, reinstalls extra packages, re-enables services
   - **No** → Fresh install, user starts clean
6. Migration summary displayed
7. Reboot → exactly where they left off (same logins, configs, projects)

**What Migrates Automatically**:
- `/home/user/` - entire home folder (projects, dotfiles, configs)
- `~/.mozilla/firefox/` - browser logins, bookmarks, history, extensions
- `~/.config/discord/` - Discord session (stays logged in)
- `~/.config/Code/` - VS Code settings, extensions, accounts
- `~/.ssh/` - SSH keys
- `~/.config/systemd/user/` - user-level systemd services
- Package list diff - any packages user installed beyond base ISO

**What Requires Manual Re-setup** (edge cases):
- System-level systemd services added by user (rare)
- Custom kernel parameters
- System files modified outside /home

**Note**: A small warning will inform users about system-level services. 99% of users won't be affected.

**Deliverable**: Calamares installer + migration script

---

### Gate 4: Polish
**Objective**: Release-ready distribution with strong brand identity

**Requirements**:
| Requirement | Verification | Status |
|-------------|--------------|--------|
| Logo + favicon | SVG + PNG assets created | PENDING |
| Custom wallpaper | Branded desktop background | PENDING |
| Custom boot splash | Plymouth theme or GRUB splash | PENDING |
| Custom Fastfetch | Shows JumpDev OS branding | PENDING |
| Landing page | Live at projectjumpdev.io or similar | PENDING |
| README.md complete | Installation, usage, troubleshooting | PENDING |
| Demo video | 2-min YouTube video | PENDING |
| Social assets | Screenshots, banners for socials | PENDING |
| Hardware compatibility doc | Tested machines list | PENDING |
| Secure Boot documentation | Clear disable instructions | PENDING |
| ISO published | Available for download | PENDING |
| SHA256 checksum provided | Verification possible | PENDING |
| Boots on 5+ machines | Expanded hardware testing | PENDING |
| Boot time < 60 seconds | Measured on USB 3.0 | PENDING |

---

## Brand Guidelines

**Brand Personality**: Bold. Playful but productive. Developer-first.

| ✓ We Are | ✗ We're Not |
|----------|-------------|
| Confident, energetic | Corporate, boring |
| Fun but capable | Childish, meme-heavy |
| Modern, fresh | Retro, nostalgic |
| Opinionated | Generic "another Linux distro" |

**Tagline**: "Boot. Code. Ship."

**Alternative taglines**:
- "Code anywhere. Setup nowhere."
- "Your AI dev team, pocket-sized."
- "Just plug in and build."

**Color Palette** (Catppuccin Mocha):
| Color | Hex | Use |
|-------|-----|-----|
| Mauve (Primary) | `#cba6f7` | Accents, CTAs, logo |
| Blue | `#89b4fa` | Links, secondary accents |
| Base | `#1e1e2e` | Backgrounds |
| Text | `#cdd6f4` | Body text |
| Surface | `#313244` | Cards, panels |

**Logo Direction**:
- Bold geometric shapes
- Purple/blue gradient from palette
- Works at favicon size (16px) and large (512px+)
- Concepts: rocket, terminal cursor, "J" lettermark, abstract jump/leap

**Typography**:
- Headings: Bold, modern sans-serif (Inter, Manrope)
- Body: Clean, readable (Inter, system fonts)
- Code: JetBrains Mono (already in distro)

**Voice & Tone**:
| Context | Example |
|---------|---------|
| Website hero | "Plug in a USB. Boot up. Start shipping." |
| Feature description | "Claude Code, Aider, and Ollama. Pre-installed." |
| Error messages | "Something broke. Here's what happened:" |
| First-boot wizard | "Let's get you coding in 60 seconds." |
| Success states | "You're all set. Go build something." |

**Photography/Imagery**:
- Abstract gradients with subtle grid/code texture
- Developer workspaces (clean, modern)
- No stock photos of people pointing at screens
- Screenshots should show actual UI, Catppuccin themed

---

## Landing Page Structure

**URL**: jumpdev.dev or projectjumpdev.io (TBD)

**Hero Section**:
```
[Logo]

Boot. Code. Ship.

Your portable AI coding environment.
Claude Code + VS Code + modern CLI tools.
Just plug in and build.

[Download ISO - 4GB]  [View on GitHub]
```

**Section 2 - What's Inside** (3-column grid):
```
[Icon] AI-First Development
Claude Code, Aider, and Ollama pre-configured.
Start vibe coding immediately.

[Icon] Modern Dev Stack
VS Code, Neovim, Docker, Node, Python, Rust.
Everything you need, nothing you don't.

[Icon] Runs Anywhere
Boot from USB on any PC. Your environment
travels with you. Works offline.
```

**Section 3 - Screenshot/Demo**:
```
[Large screenshot of Hyprland desktop]
or
[Embedded 2-min YouTube demo]
```

**Section 4 - How It Works** (3 steps):
```
1. Download & Flash
   Grab the ISO. Flash to USB with Etcher or Rufus.

2. Boot & Setup
   Plug into any PC. One-time 60-second setup.

3. Code Anywhere
   Your files, logins, and tools persist across reboots.
```

**Section 5 - What's Included** (expandable list):
```
▸ AI Tools: Claude Code, Aider, Ollama
▸ Editors: VS Code, Neovim (LSP configured)
▸ Languages: Node.js, Python, Rust
▸ Containers: Docker, Docker Compose
▸ CLI: fzf, ripgrep, bat, eza, zoxide, yazi
▸ Desktop: Hyprland, Waybar, nwg-menu
▸ Apps: Firefox, Thunar, mpv
```

**Section 6 - Requirements**:
```
Minimum:
- 8GB USB 3.0 drive
- 8GB RAM
- x86_64 processor

Recommended:
- 16GB+ fast USB (Samsung FIT Plus)
- 16GB+ RAM
- Disable Secure Boot
```

**Section 7 - FAQ** (collapsible):
```
▸ Does it work on Mac?
  Intel Macs: Yes. Apple Silicon: Coming soon (Gate 5).

▸ Will my files be saved?
  Yes! First-boot wizard sets up persistence automatically.

▸ Can I install it to my hard drive?
  Yes! Click "Install to Disk" and it migrates everything - logins,
  projects, configs. Exactly where you left off, just faster.

▸ Is it free?
  Yes, MIT licensed. Free forever.
```

**Footer**:
```
[GitHub] [Discord] [Twitter]

Made with 🧡 by developers, for developers.
MIT License | v1.0.0
```

---

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

---

## YouTuber / Influencer Outreach

**Why JumpDev OS is content-friendly:**
- Boots in 30 seconds (no dead air on camera)
- Visually stunning (Hyprland + Catppuccin = eye candy)
- Clear hook: "AI coding environment on a USB stick"
- Free & open source (audience can try immediately)
- Controversial angle: "Do you even need an installed OS?"

**Target Creators:**

| Creator | Platform | Angle | Priority |
|---------|----------|-------|----------|
| Fireship | YouTube (3M+) | "JumpDev in 100 seconds" format | HIGH |
| ThePrimeagen | YouTube/Twitch (1M+) | CLI tools, vim, dev productivity | HIGH |
| NetworkChuck | YouTube (4M+) | "Hacker USB stick" / portable lab | HIGH |
| Chris Titus Tech | YouTube (1M+) | Linux distro review | HIGH |
| Theo (t3.gg) | YouTube (400K+) | AI dev tools, modern stack | MEDIUM |
| The Linux Experiment | YouTube (300K+) | Beginner-friendly Linux | MEDIUM |
| DistroTube | YouTube (200K+) | Tiling WM, Hyprland focus | MEDIUM |
| TechHut | YouTube (200K+) | Linux reviews | MEDIUM |
| Michael Horn | YouTube (100K+) | Hyprland content | MEDIUM |
| Level1Techs | YouTube (500K+) | Technical deep-dive | LOW |

**Outreach Strategy:**

1. **Before reaching out:**
   - Have polished ISO ready (Gate 4 complete)
   - Landing page live with clear messaging
   - 2-min demo video showing the highlights
   - Screenshots / b-roll footage ready to share

2. **Outreach message template:**
   ```
   Subject: JumpDev OS - Portable AI coding environment (review/content idea)

   Hey [Name],

   Built something your audience might dig - JumpDev OS is a portable
   Linux distro designed for AI-assisted coding. Boot from USB, get
   Claude Code + VS Code + modern CLI tools instantly.

   Think: "dev environment in your pocket" for the vibe coding era.

   - 30-second boot to Hyprland desktop
   - Claude Code, Aider, Ollama pre-installed
   - Runs on any PC, persistence built-in
   - Free, MIT licensed

   Happy to send a USB stick or answer any questions.

   [Link to landing page]
   [Link to demo video]
   ```

3. **Content angles to suggest:**
   - "I coded for a week using only a USB stick"
   - "The Linux distro built for AI coding"
   - "Can you replace your dev machine with a USB drive?"
   - "Hyprland rice review + productivity test"
   - "Best portable Linux for developers 2026"

4. **Timing:**
   - Reach out Tuesday-Thursday (best engagement)
   - Follow up once after 1 week if no response
   - Don't spam - quality over quantity

**Community Seeding:**

| Platform | Subreddit/Community | Post Angle |
|----------|---------------------|------------|
| Reddit | r/linux | "Show r/linux: JumpDev OS" |
| Reddit | r/unixporn | Screenshot post with dotfiles |
| Reddit | r/hyprland | Config showcase |
| Reddit | r/ClaudeAI | "Portable Claude Code environment" |
| Reddit | r/LocalLLaMA | Ollama pre-installed angle |
| Hacker News | Show HN | Technical + "why I built this" |
| Twitter/X | Dev community | Demo video + thread |
| Discord | Claude/Anthropic servers | Soft launch, gather feedback |

**Success Metrics:**
- 1 YouTuber with 100K+ covers it → success
- 500+ GitHub stars in first month → healthy
- Front page of r/linux or HN → viral potential
- 1000+ ISO downloads first week → strong launch

**Deliverable**: `jumpdev-1.0.0-x86_64.iso` + documentation + landing page + demo video

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
uwsm
xdg-desktop-portal-hyprland
xdg-desktop-portal-gtk
waybar
nwg-menu
mako
grim
slurp
wl-clipboard
xorg-xwayland
qt5-wayland
qt6-wayland
```

### GUI Applications (Beginner-Friendly)
```
firefox
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
mpv
imv
zenity
```

### First-Boot App Selector (Requires Persistence)
```
# Optional apps users can install via first-boot wizard
visual-studio-code-bin  # Code editor
google-chrome           # Browser (for Windows converts)
discord                 # Communication
nvidia-open-dkms        # NVIDIA GPU drivers
nvidia-utils
nvidia-settings
nwg-dock-hyprland       # Dock bar (optional)
nwg-look                # GTK theme settings
```

### Terminal & Shell
```
kitty
zsh
starship
zellij
tmux
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
lazydocker
mise
nodejs
npm
python
python-pip
python-pipx
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
# NVIDIA drivers available via first-boot app selector
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
| Kitty | `~/.config/kitty/kitty.conf` | `configs/kitty/` |
| nwg-menu | `~/.config/nwg-menu/` | `configs/nwg-menu/` |
| Neovim | `~/.config/nvim/` | `configs/nvim/` |
| Zsh | `~/.zshrc`, `~/.zshenv` | `configs/zsh/` |
| Starship | `~/.config/starship.toml` | `configs/starship/` |
| Yazi | `~/.config/yazi/` | `configs/yazi/` |
| Btop | `~/.config/btop/` | `configs/btop/` |
| Lazygit | `~/.config/lazygit/` | `configs/lazygit/` |

---

## Keybind Reference

### Hyprland - Core
| Key | Action |
|-----|--------|
| `Super + Return` | Open terminal (Kitty) |
| `Super + D` | Open app menu (nwg-menu) |
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
