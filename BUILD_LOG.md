# JumpDev OS Build Log

> **Update this file at the end of every session.**

---

## Current Status

**Phase**: Gate 1 - Foundation
**Status**: COMPLETE
**Blocking Issues**: None

---

## Gate Progress

| Gate | Status | Notes |
|------|--------|-------|
| Gate 1: Foundation | COMPLETE | Boots to Hyprland on real hardware |
| Gate 2: Core Experience | IN PROGRESS | Packages added, testing keybinds |
| Gate 3: Portability | NOT STARTED | Persistence + hardware testing |
| Gate 4: Polish | NOT STARTED | Branding + release |
| Gate 5: ARM64 | NOT STARTED | Apple Silicon support |

---

## Session Log

### Session 4 - 2026-01-22

**Completed**:
- **Terminal overhaul**: Replaced Foot with Kitty (better color support, SSH terminfo)
- **Launcher overhaul**: Replaced nwg-menu with wofi
  - Clean, minimal search-based launcher
  - Positioned top-left under waybar
  - Single-click to launch apps
  - **Click-outside-to-close** using slurp overlay (standard Wayland workaround)
  - Slight dim effect when menu open (like macOS Spotlight)
- **Power menu**: Small dropdown via wofi
  - Positioned top-right under waybar
  - No search bar (--hide-search)
  - Lock/Logout/Restart/Shutdown options
  - Click-outside-to-close works
- **Volume control**: Waybar pulseaudio module with scroll-step
  - Scroll on icon to adjust volume
  - Click to mute, right-click for pavucontrol
- **Added Omakub-matching terminal tools**:
  - `lazydocker` - Docker TUI
  - `zellij` - Modern terminal multiplexer
  - `mise` - Version manager for node/python/ruby
- **ISO size optimization**:
  - Replaced VLC (40MB) with mpv (6MB)
  - Removed Discord and VS Code from base ISO (moved to first-boot selector)
  - Removed NVIDIA DKMS drivers (moved to first-boot selector)
  - WiFi drivers (Broadcom, Marvell) kept in base - essential for setup
- **First-boot app selector planned** - Will offer optional installs:
  - VS Code, Google Chrome, Discord
  - NVIDIA drivers (nvidia-open-dkms, nvidia-utils, nvidia-settings)
  - Requires persistence partition
- **Plymouth boot splash**:
  - Added plymouth for graphical boot animation
  - No more black screen during boot
- **Self-hosted GitHub Actions runner**:
  - Build runs on local server (faster)
  - ISO served directly from runner work directory
  - HTTP server on port 7900 for easy LAN downloads
  - Only triggers on main branch pushes (safe from PR attacks)

**New Packages Added**:
- kitty, wofi, swaylock, plymouth
- lazydocker, zellij, mise

**Removed from Base**:
- foot, fuzzel, wlogout, nwg-menu, swayosd-git
- VLC (replaced with mpv)
- Discord, VS Code (moved to first-boot selector)
- NVIDIA drivers (moved to first-boot selector)

**Technical Notes**:
- Click-outside-to-close uses slurp overlay - standard Wayland community workaround
- Wayland doesn't have native "click outside to dismiss" like X11
- Scripts: `app-launcher.sh` and `power-menu.sh` handle the slurp+wofi coordination

**Infrastructure**:
- Self-hosted runner at /home/dan/projects/jumpdev-os/runner/
- ISO server at http://192.168.1.46:7900/
- ISOs served directly from runner/_work/ (no duplicate copies)

**Build Status**: Build 27 - SUCCESS

**Next Steps**:
1. Test build 27 with click-outside-to-close
2. Implement first-boot app selector script
3. Add persistence detection and warning

---

### Session 3 - 2026-01-21

**Completed**:
- **First successful boot on real hardware** - Boots to Hyprland desktop
- Fixed mkinitcpio configuration with archiso hooks (was causing "failed to switch root")
- Fixed Hyprland config directory name: `hyprland/` → `hypr/` (Hyprland expects `~/.config/hypr/`)
- Added Gate 5: ARM64/Apple Silicon support to comprehensive plan
- Major package additions for beginner-friendly experience:
  - **Browsers**: Firefox, Chromium
  - **File Manager**: Thunar with plugins, gvfs, tumbler
  - **Communication**: Discord, Telegram (Slack via AUR)
  - **Media**: VLC, mpv, imv
  - **Screenshots**: grim, slurp, swappy, flameshot
  - **GUI Settings**: pavucontrol, blueman, nm-connection-editor, wlogout
  - **WiFi Support**: broadcom-wl-dkms, linux-firmware-marvell, modemmanager, usb_modeswitch
- Added Hyprland keybinds for new apps:
  - `Super + B` → Firefox
  - `Super + E` → Thunar
  - `Print` → Screenshot region
  - `Shift + Print` → Screenshot full screen
- Updated COMPREHENSIVE_PLAN.md with all new packages and GUI requirements
- Documented AUR packages for first-boot install: nwg-dock-hyprland, nwg-drawer, nwg-look, swayosd, slack-desktop

**Build History**:
- Build 1: First successful ISO build
- Build 2: mkinitcpio archiso hooks fix
- Build 3: Hyprland config directory fix (`hypr/` not `hyprland/`)
- Build 4: Failed - wlogout not in repos (AUR only)
- Build 5: Failed - Chaotic-AUR key not initialized
- Build 6: SUCCESS - Chaotic-AUR working, Discord + wlogout included
- Build 7: Failed - hyprland-plugin-hyprbars not in Chaotic-AUR
- Build 8: SUCCESS - Waybar buttons + VS Code (no hyprbars)
- Build 9: Failed - keyserver timeout
- Build 10: Failed - keyserver timeout (added fallback keyservers)
- Build 11: Failed - hyprpm refuses to run as root
- Build 12: Failed - network timeout
- Build 13: SUCCESS - hyprbars built via cmake, window title bars work!
- Build 14: SUCCESS - uwsm fix for Hyprland startup warning
- Build 15: SUCCESS - Text labels for Waybar buttons (font rendering workaround)
- Build 16: IN PROGRESS - Removed redundant close button from Waybar

**User Testing Feedback (Build 13-15)**:
- Firefox works great, audio works
- Window title bars (hyprbars) work with close/fullscreen/minimize buttons
- Discord had "not enough space" errors (likely tmpfs limit - to debug)
- Waybar icon fonts rendered as grey squares - fixed with text labels
- Close button in Waybar redundant since hyprbars has X buttons - removed

**Next Steps**:
1. Test build 16 - verify text labels + no close button
2. Debug Discord "not enough space" error
3. Add AI tools (Claude Code, Aider, Ollama)
4. Gate 3 - Persistence wizard

**Issues Discovered**:
- Hyprland expects config at `~/.config/hypr/`, not `~/.config/hyprland/`
- Keybinds not working until config directory fix (build 3)

**Next**:
1. Push build 4 with all new packages
2. Test keybinds on real hardware (Super+Return, Super+D, Super+B, Super+E)
3. Create first-boot script for AUR package installation
4. Configure Waybar to show system tray applets
5. Test WiFi on various hardware

---

### Session 2 - 2026-01-21

**Completed**:
- Renamed project from AgentOS to JumpDev OS
- Created GitHub repo: github.com/danupsher/jumpdev-os
- All application configs created with Catppuccin Mocha theme:
  - Hyprland (tiling WM with keybinds)
  - Waybar (status bar)
  - Foot (terminal)
  - Zsh + Starship (shell + prompt)
  - Fuzzel (launcher)
  - Neovim (LSP, Treesitter, Telescope, completion)
- GitHub Actions CI pipeline for automated ISO builds
- Complete archiso setup:
  - Auto-login as `jump` user
  - Hyprland auto-start on TTY1
  - NetworkManager + Docker enabled
  - 100+ packages
- **First successful ISO build** (31 minutes on GitHub Actions)

**Issues Encountered**:
- `grub` needed on build host, not just in package list - fixed
- Deprecated boot modes in profiledef.sh - updated to `bios.syslinux` and `uefi-x64.grub.esp`
- `mesa-vdpau` package not found - removed
- `/home/jump` permission error - removed (created at boot from skel)

**Next Session**:
1. Download ISO and test in QEMU
2. Test on real hardware
3. Verify Hyprland starts correctly
4. Test Claude Code installation
5. Work on persistence (Gate 3)

**Notes**:
- ISO available as GitHub Actions artifact
- To release: `git tag v0.1.0-alpha && git push --tags`

---

### Session 1 - 2026-01-21

**Completed**:
- Project directory structure created
- CLAUDE.md session guide written
- COMPREHENSIVE_PLAN.md with 4 gates defined
- DECISIONS.md with architectural decisions documented
- BUILD_LOG.md initialized

**Notes**:
- Project structure follows crypto-trading-system patterns
- All core documentation in place

---

## Known Issues

*None currently blocking.*

---

## Pre-Release Checklist

Tasks to complete before public release:

- [ ] **Disable sshd auto-start** - Currently enabled for QEMU debugging. Remove symlink from `airootfs/etc/systemd/system/multi-user.target.wants/sshd.service` before release. Security risk if left enabled (passwordless user on open network).
- [ ] Remove any debug-only packages if added
- [ ] Final hardware testing (Gate 3)
- [ ] Branding and polish (Gate 4)

---

## Hardware Testing Log

*Hardware testing begins in Gate 3.*

| Machine | Specs | Boot | WiFi | GPU | Notes |
|---------|-------|------|------|-----|-------|
| TBD | - | - | - | - | - |

---

## ISO Build History

| Date | Version | Size | Gate | Result | Notes |
|------|---------|------|------|--------|-------|
| 2026-01-21 | Build 1 | ~3GB | Gate 1 | SUCCESS | First build via GitHub Actions |
| 2026-01-21 | Build 2 | ~3GB | Gate 1 | SUCCESS | mkinitcpio archiso hooks fix |
| 2026-01-21 | Build 3 | ~3GB | Gate 1 | SUCCESS | Hyprland config dir fix (hypr/) |
| 2026-01-21 | Build 4 | - | Gate 2 | FAILED | wlogout not in repos |
| 2026-01-21 | Build 5 | - | Gate 2 | FAILED | Chaotic-AUR key not initialized |
| 2026-01-21 | Build 6 | ~3GB | Gate 2 | SUCCESS | Chaotic-AUR working |
| 2026-01-21 | Build 7 | - | Gate 2 | FAILED | hyprbars not in Chaotic-AUR |
| 2026-01-21 | Build 8 | ~2.4GB | Gate 2 | SUCCESS | Waybar buttons, no hyprbars |
| 2026-01-21 | Build 9-10 | - | Gate 2 | FAILED | Keyserver timeout |
| 2026-01-21 | Build 11 | - | Gate 2 | FAILED | hyprpm refuses root |
| 2026-01-21 | Build 12 | - | Gate 2 | FAILED | Network timeout |
| 2026-01-22 | Build 13 | ~2.4GB | Gate 2 | SUCCESS | hyprbars via cmake! |
| 2026-01-22 | Build 14 | ~2.4GB | Gate 2 | SUCCESS | uwsm startup fix |
| 2026-01-22 | Build 15 | ~2.4GB | Gate 2 | SUCCESS | Text labels for Waybar |
| 2026-01-22 | Build 16 | - | Gate 2 | PENDING | Remove close button |
| 2026-01-22 | Build 17-19 | - | Gate 2 | FAILED | WiFi packages not in Chaotic-AUR |
| 2026-01-22 | Build 20 | ~2.4GB | Gate 2 | SUCCESS | WiFi drivers fixed |
| 2026-01-22 | Build 21 | ~1.9GB | Gate 2 | SUCCESS | Kitty, nwg-menu, mpv, no DKMS |
| 2026-01-22 | Build 22 | ~1.9GB | Gate 2 | SUCCESS | Self-hosted runner working |
| 2026-01-22 | Build 23 | ~1.9GB | Gate 2 | SUCCESS | Wofi replaces nwg-menu |
| 2026-01-22 | Build 24 | ~1.9GB | Gate 2 | SUCCESS | Workflow cleanup |
| 2026-01-22 | Build 25 | ~1.9GB | Gate 2 | SUCCESS | Wofi config fixes |
| 2026-01-22 | Build 26 | ~1.9GB | Gate 2 | SUCCESS | Volume scroll, power menu fixes |
| 2026-01-22 | Build 27 | ~1.9GB | Gate 2 | SUCCESS | Click-outside-to-close via slurp |

---

## Decisions Made During Build

- Removed `mesa-vdpau` - package not in repos
- Using `bios.syslinux` + `uefi-x64.grub.esp` boot modes (others deprecated)
- Home directory created at boot from /etc/skel, not in ISO
- Live user is `jump` with passwordless sudo

---

## QEMU Debugging Environment

**Purpose**: Test ISOs without writing to USB. Claude can interact with the VM via SSH, click buttons, and take screenshots to debug issues autonomously.

**Components**:
- `ydotool` - Simulate mouse clicks and keyboard input on Wayland
- `grim` - Take screenshots of the Wayland session
- `sshd` - Enabled on boot for remote access

**Scripts**:
- `scripts/qemu-test.sh` - Boot ISO in QEMU with SSH and VNC
- `scripts/vm-test.sh` - Interact with VM (click, screenshot, test buttons)

**Usage**:
```bash
# Terminal 1: Start the VM
./scripts/qemu-test.sh

# Terminal 2: Wait for VM, then test
./scripts/vm-test.sh wait
./scripts/vm-test.sh test-all

# Individual commands
./scripts/vm-test.sh screenshot "my-test"
./scripts/vm-test.sh click 30 17          # Click at coordinates
./scripts/vm-test.sh key escape           # Press Escape
./scripts/vm-test.sh cmd "wofi --show drun"  # Run command in VM
```

**Screenshots**: Saved to `test-screenshots/` directory.

**SSH Access**: `ssh -p 2222 jump@localhost` (no password)

**VNC Access**: `localhost:5900` (for visual debugging)

---

## Useful Commands

```bash
# Build ISO (in Arch VM)
sudo mkarchiso -v -w /tmp/archiso-tmp -o out/ archiso/

# Test in QEMU with debugging (recommended)
./scripts/qemu-test.sh

# Test in QEMU (simple UEFI)
qemu-system-x86_64 -enable-kvm -m 4G -cdrom out/jumpdev-*.iso -bios /usr/share/ovmf/OVMF.fd

# Test in QEMU (BIOS)
qemu-system-x86_64 -enable-kvm -m 4G -cdrom out/jumpdev-*.iso

# Write to USB
sudo dd if=out/jumpdev-*.iso of=/dev/sdX bs=4M status=progress oflag=sync

# Check USB label
lsblk -o NAME,LABEL,SIZE,FSTYPE

# Create release
git tag v0.1.0-alpha && git push --tags
```

---

## Links and References

- [GitHub Repo](https://github.com/danupsher/jumpdev-os)
- [GitHub Actions](https://github.com/danupsher/jumpdev-os/actions)
- [Archiso Documentation](https://wiki.archlinux.org/title/Archiso)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Catppuccin Theme](https://github.com/catppuccin/catppuccin)
- [Claude Code](https://claude.ai/code)
