# JumpDev OS Architectural Decisions

> **Do not relitigate these decisions** without strong justification. They were made deliberately after considering alternatives.

---

## Base Distribution: Arch Linux

**Decision**: Use Arch Linux as the base distribution.

**Why**:
- Archiso provides well-documented live ISO tooling
- Rolling release means latest packages without backporting
- Hyprland and modern Wayland stack are first-class citizens
- Minimal base allows precise control over included packages
- Large AUR for edge-case packages (though we avoid AUR in ISO)

**Alternatives Considered**:
- **Debian/Ubuntu**: Older packages, would need PPAs for Hyprland
- **Fedora**: Good option but Archiso tooling is more flexible
- **NixOS**: Interesting but adds complexity; target audience familiar with Arch
- **Void Linux**: Smaller community, less documentation

---

## Display Server: Wayland (not X11)

**Decision**: Wayland-only with Hyprland compositor.

**Why**:
- Modern, secure display protocol
- Better HiDPI support
- Hyprland is actively developed with excellent features
- X11 is legacy; new projects should use Wayland
- XWayland handles legacy X11 applications

**Alternatives Considered**:
- **X11 + i3**: More compatible but dated
- **X11 + bspwm**: Same issues as i3
- **Sway**: Good but Hyprland has better animations and features

---

## Window Manager: Hyprland

**Decision**: Use Hyprland as the tiling compositor.

**Why**:
- Native Wayland (not a port)
- Smooth animations and modern feel
- Highly configurable
- Active development and community
- Good documentation

**Alternatives Considered**:
- **Sway**: Stable but less features, i3 compatibility not needed
- **River**: Too minimal for target audience
- **dwl**: Too minimal, less documentation

---

## Terminal: Foot

**Decision**: Use Foot as the terminal emulator.

**Why**:
- Native Wayland (no XWayland)
- Extremely fast
- Simple configuration
- Low resource usage
- Good font rendering

**Alternatives Considered**:
- **Alacritty**: GPU-accelerated but more resource heavy
- **Kitty**: Feature-rich but heavier
- **Wezterm**: Lua config interesting but overkill

---

## Shell: Zsh + Starship

**Decision**: Use Zsh with Starship prompt.

**Why**:
- Zsh has better completion and scripting than Bash
- Starship is fast (Rust), cross-shell, beautiful defaults
- Minimal configuration needed for good experience
- Wide plugin ecosystem if users want to extend

**Alternatives Considered**:
- **Bash + custom prompt**: Too basic
- **Fish**: Good but syntax differs from Bash/Zsh scripts
- **Nushell**: Too different, learning curve

---

## Editors: Neovim + VS Code

**Decision**: Include both Neovim (terminal) and VS Code (GUI).

**Why**:
- Neovim for terminal-native editing with LSP
- VS Code for users who prefer a GUI editor
- Both are widely used in development
- VS Code available via Chaotic-AUR (visual-studio-code-bin)
- Covers both CLI power users and GUI-preferring developers

**Alternatives Considered**:
- **Neovim only**: Too steep learning curve for beginners
- **Cursor**: Not available in Chaotic-AUR
- **VS Codium**: Less extension compatibility
- **Helix**: Interesting but smaller ecosystem

---

## Theme: Catppuccin Mocha

**Decision**: Use Catppuccin Mocha as the universal theme.

**Why**:
- Available for virtually every application
- Consistent, well-designed color palette
- Easy on the eyes for long coding sessions
- Active community maintaining ports
- Mocha variant has good contrast

**Alternatives Considered**:
- **Dracula**: Good but Catppuccin has more app coverage
- **Nord**: Too muted for some tastes
- **Gruvbox**: Good but Catppuccin feels more modern
- **Tokyo Night**: Close second, Catppuccin chosen for broader support

---

## Font: JetBrains Mono Nerd Font

**Decision**: Use JetBrains Mono Nerd Font as the monospace font.

**Why**:
- Excellent readability
- Programming ligatures (optional)
- Nerd Font variant includes icons for prompt/file managers
- Free and open source
- Good Unicode coverage

**Alternatives Considered**:
- **Fira Code**: Good but JetBrains Mono slightly more readable
- **Hack**: Solid but lacks ligatures
- **Iosevka**: Highly customizable but default not as polished

---

## Package Manager for AI Tools: npm + pipx + curl

**Decision**: Install AI tools via their native methods, not system packages.

**Why**:
- Claude Code: npm is the official distribution method
- Aider: pipx isolates Python dependencies
- Ollama: Official install script ensures correct setup
- These tools update frequently; native methods get updates faster

**Alternatives Considered**:
- **System packages only**: These tools aren't in official repos
- **AUR**: Can't use AUR directly in Archiso
- **Flatpak**: Adds complexity, sandboxing can interfere

---

## Persistence: Labeled Partition + Overlay

**Decision**: Use a separate partition labeled `JUMPDEV_PERSIST` with overlay filesystem.

**Why**:
- Clean separation of ISO (read-only) and user data (read-write)
- Standard approach for live USB persistence
- Easy to create: just partition and label
- Overlay allows seamless merge of persistent changes

**Alternatives Considered**:
- **Casper-style persistence file**: Works but partition is cleaner
- **Full installation to USB**: Defeats "live" purpose, slower updates
- **No persistence**: Too limiting for API keys and projects

---

## Init System: systemd

**Decision**: Use systemd (Arch default).

**Why**:
- Arch default, well-integrated
- Hyprland can be started via systemd user services
- Good logging with journalctl
- Service management for Docker, NetworkManager, etc.

**Alternatives Considered**:
- **OpenRC**: Would require significant changes to Arch base
- **runit**: Same issues
- **dinit**: Interesting but not worth the integration effort

---

## Network Management: NetworkManager

**Decision**: Use NetworkManager for network configuration.

**Why**:
- Good WiFi support including enterprise networks
- CLI (nmcli) and TUI (nmtui) tools
- Handles VPN, mobile broadband
- Well-documented and widely used

**Alternatives Considered**:
- **iwd standalone**: Simpler but less features
- **systemd-networkd**: Better for servers, worse for laptops
- **connman**: Less common, fewer examples

---

## Build Environment: Arch VM or Container

**Decision**: Build ISOs in an Arch Linux VM or container.

**Why**:
- Archiso must run on Arch Linux
- VM provides clean, reproducible environment
- Container (docker/podman) is faster alternative
- Avoids polluting host system

**Alternatives Considered**:
- **Build on host**: Only works if host is Arch
- **GitHub Actions**: Possible but slower iteration
- **Cross-distro build**: Not supported by Archiso

---

## Secure Boot: Document Disable Procedure

**Decision**: Require Secure Boot to be disabled; document the process.

**Why**:
- Custom kernel/bootloader not signed by Microsoft
- Signing is complex and requires key management
- Most developers can disable Secure Boot easily
- Can revisit signing in future versions

**Alternatives Considered**:
- **Sign with shim**: Complex, requires ongoing maintenance
- **MOK enrollment**: Requires user interaction at boot
- **PreLoader**: Similar complexity to shim

---

## AUR Packages: Chaotic-AUR

**Decision**: Use Chaotic-AUR repository for pre-built AUR packages.

**Why**:
- AUR packages can't be built directly in Archiso
- Chaotic-AUR provides pre-built binaries of popular AUR packages
- Includes Discord, wlogout, VS Code, and other essentials
- Avoids slow first-boot compilation
- Trusted repository with GPG-signed packages

**Alternatives Considered**:
- **Build AUR packages in CI**: Complex, time-consuming
- **First-boot AUR compilation**: Too slow, bad user experience
- **Flatpak**: Sandboxing issues, larger download size
- **Skip AUR packages**: Loses important software like Discord, VS Code

---

## Window Title Bars: hyprbars Plugin

**Decision**: Build and include hyprbars plugin for window title bars with buttons.

**Why**:
- Provides close, maximize, minimize buttons on every window
- Essential for users coming from Windows/macOS
- Makes Hyprland usable without memorizing keybinds
- Plugin built from source in CI (not available pre-built)

**Alternatives Considered**:
- **No title bars**: Too unfamiliar for beginners
- **Use GTK/Qt decorations**: Inconsistent, doesn't work for all apps
- **Switch to Sway**: Would lose Hyprland features we want

---

## Beginner-Friendly Features

**Decision**: Include clickable Waybar buttons and GUI elements.

**Why**:
- Target audience includes Windows users new to Linux
- Reduces barrier to entry
- Apps button, Terminal, Files, Browser, Code buttons in Waybar
- Users can still learn keybinds over time
- Power button for clean shutdown/logout

**Alternatives Considered**:
- **Keyboard-only**: Alienates beginners
- **Dock (nwg-dock)**: Another dependency, Waybar buttons sufficient
- **Different DE**: Loses benefits of Hyprland tiling
