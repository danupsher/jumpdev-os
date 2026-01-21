#!/usr/bin/env bash
# Test AgentOS ISO in QEMU
# Usage: ./test-qemu.sh [iso-path] [--bios]

set -euo pipefail

ISO_PATH="${1:-}"
BIOS_MODE="${2:-}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
OUT_DIR="$PROJECT_DIR/out"

# Find ISO if not specified
if [[ -z "$ISO_PATH" ]]; then
    ISO_PATH=$(ls -t "$OUT_DIR"/*.iso 2>/dev/null | head -n1)
    if [[ -z "$ISO_PATH" ]]; then
        echo "Error: No ISO found. Build one first or specify path."
        echo "Usage: $0 [iso-path] [--bios]"
        exit 1
    fi
fi

if [[ ! -f "$ISO_PATH" ]]; then
    echo "Error: ISO not found: $ISO_PATH"
    exit 1
fi

echo "Testing: $ISO_PATH"

# QEMU options
QEMU_OPTS=(
    -enable-kvm
    -m 4G
    -smp 2
    -cdrom "$ISO_PATH"
    -device virtio-net-pci,netdev=net0
    -netdev user,id=net0
    -device virtio-vga-gl
    -display sdl,gl=on
    -usb
    -device usb-tablet
)

# UEFI or BIOS mode
if [[ "$BIOS_MODE" == "--bios" ]]; then
    echo "Mode: BIOS (Legacy)"
else
    echo "Mode: UEFI"
    # Try common OVMF locations
    OVMF_PATHS=(
        "/usr/share/ovmf/x64/OVMF.fd"
        "/usr/share/ovmf/OVMF.fd"
        "/usr/share/edk2-ovmf/x64/OVMF.fd"
        "/usr/share/OVMF/OVMF_CODE.fd"
    )
    OVMF=""
    for path in "${OVMF_PATHS[@]}"; do
        if [[ -f "$path" ]]; then
            OVMF="$path"
            break
        fi
    done
    if [[ -z "$OVMF" ]]; then
        echo "Warning: OVMF not found, falling back to BIOS mode"
        echo "Install OVMF: pacman -S edk2-ovmf"
    else
        QEMU_OPTS+=(-bios "$OVMF")
    fi
fi

echo "Starting QEMU..."
qemu-system-x86_64 "${QEMU_OPTS[@]}"
