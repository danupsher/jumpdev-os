#!/usr/bin/env bash
# JumpDev OS ISO Build Script
# Must be run on Arch Linux with archiso installed
# Requires root privileges

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
PROFILE_DIR="$PROJECT_DIR/archiso"
WORK_DIR="/tmp/jumpdev-build"
OUT_DIR="$PROJECT_DIR/out"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."

    if [[ $EUID -ne 0 ]]; then
        log_error "This script must be run as root"
        exit 1
    fi

    if ! command -v mkarchiso &> /dev/null; then
        log_error "mkarchiso not found. Install archiso: pacman -S archiso"
        exit 1
    fi

    if [[ ! -f /etc/arch-release ]]; then
        log_error "This script must be run on Arch Linux"
        exit 1
    fi

    log_info "Prerequisites OK"
}

# Clean previous build
clean_build() {
    log_info "Cleaning previous build..."
    rm -rf "$WORK_DIR"
    mkdir -p "$WORK_DIR"
    mkdir -p "$OUT_DIR"
}

# Copy configs to airootfs
prepare_airootfs() {
    log_info "Preparing airootfs..."

    # Copy skel configs
    local skel_dir="$PROFILE_DIR/airootfs/etc/skel"
    mkdir -p "$skel_dir/.config"

    # Copy each config directory if it exists
    for config in hyprland waybar foot nvim starship fuzzel yazi btop lazygit; do
        if [[ -d "$PROJECT_DIR/configs/$config" ]]; then
            cp -r "$PROJECT_DIR/configs/$config" "$skel_dir/.config/"
            log_info "  Copied $config config"
        fi
    done

    # Copy zsh configs
    if [[ -d "$PROJECT_DIR/configs/zsh" ]]; then
        cp -f "$PROJECT_DIR/configs/zsh/.zshrc" "$skel_dir/" 2>/dev/null || true
        cp -f "$PROJECT_DIR/configs/zsh/.zshenv" "$skel_dir/" 2>/dev/null || true
    fi
}

# Build the ISO
build_iso() {
    log_info "Building ISO..."
    log_info "  Profile: $PROFILE_DIR"
    log_info "  Work dir: $WORK_DIR"
    log_info "  Output: $OUT_DIR"

    mkarchiso -v -w "$WORK_DIR" -o "$OUT_DIR" "$PROFILE_DIR"
}

# Main
main() {
    log_info "JumpDev OS ISO Build"
    log_info "=================="

    check_prerequisites
    clean_build
    prepare_airootfs
    build_iso

    log_info "=================="
    log_info "Build complete!"
    log_info "ISO location: $OUT_DIR/"
    ls -lh "$OUT_DIR"/*.iso 2>/dev/null || log_warn "No ISO found in output directory"
}

main "$@"
